#pragma once

#include <cmath>
#include <cfloat>
#include <xmmintrin.h>
#include <pmmintrin.h>

union myUnion {
    double dValue;
    uint64_t iValue;
};

double eps(double t)
{
    if (t == 0)
        return DBL_MIN;
    else
    {
        myUnion myValue;
        myValue.dValue = t;
        int e = ((myValue.iValue >> 52) & 0x7ff) - 1023;
        return exp2(e + 1 - 53);
    }
}

#define y_mat(i, j) y[(i)*grid_size+(j)]
#define dy(i, j)    dydt[(i)*grid_size+(j)]

double delta = 0.01;
double clearance = 0.02;

void odeFcn_main(int grid_size, double* y, double* dydt)
{
    dy(0, 0) = dy(grid_size - 1, 0) = dy(0, grid_size - 1) = dy(grid_size - 1, grid_size - 1) = 0;
    
    for (int jj = 1; jj < grid_size - 1; jj++)
    {
        dy(0, jj) = (delta / 4 * y_mat(1, jj) + delta / 4 * y_mat(0, jj - 1) + delta / 4 * y_mat(0, jj + 1)) - 3 * delta / 4 * y_mat(0, jj) - clearance * y_mat(0, jj);
        dy(grid_size-1, jj) = (delta / 4 * y_mat(grid_size - 2, jj) + delta / 4 * y_mat(grid_size-1, jj - 1) + delta / 4 * y_mat(grid_size-1, jj + 1)) - 3 * delta / 4 * y_mat(grid_size-1, jj) - clearance * y_mat(grid_size-1, jj);
        dy(jj, 0) = (delta / 4 * y_mat(jj + 1, 0) + delta / 4 * y_mat(jj - 1, 0) + delta / 4 * y_mat(jj, 1)) - delta * y_mat(jj, 0) - clearance * y_mat(jj, 0);
        dy(jj, grid_size-1) = (delta / 4 * y_mat(jj + 1, grid_size-1) + delta / 4 * y_mat(jj - 1, grid_size-1) + delta / 4 * y_mat(jj, grid_size-2)) - delta * y_mat(jj, grid_size-1) - clearance * y_mat(jj, grid_size-1);
    }
    
    for (int ii = 1; ii < grid_size - 1; ii++)
        for (int jj = 1; jj < grid_size - 1; jj++)
            dy(ii, jj) = (delta / 4 * y_mat(ii + 1, jj) + delta / 4 * y_mat(ii - 1, jj) + delta / 4 * y_mat(ii, jj - 1) + delta / 4 * y_mat(ii, jj + 1)) - delta * y_mat(ii, jj) - clearance * y_mat(ii, jj);
}


double a2 = 1.0 / 5;
double a3 = 3.0 / 10;
double a4 = 4.0 / 5;
double a5 = 8.0 / 9;

double b11 = 1.0 / 5;
double b21 = 3.0 / 40;
double b31 = 44.0 / 45;
double b41 = 19372.0 / 6561;
double b51 = 9017.0 / 3168;
double b61 = 35.0 / 384;
double b22 = 9.0 / 40;
double b32 = -56.0 / 15;
double b42 = -25360.0 / 2187;
double b52 = -355.0 / 33;
double b33 = 32.0 / 9;
double b43 = 64448.0 / 6561;
double b53 = 46732.0 / 5247;
double b63 = 500.0 / 1113;
double b44 = -212.0 / 729;
double b54 = 49.0 / 176;
double b64 = 125.0 / 192;
double b55 = -5103.0 / 18656;
double b65 = -2187.0 / 6784;
double b66 = 11.0 / 84;

double e1 = 71.0 / 57600;
double e3 = -71.0 / 16695;
double e4 = 71.0 / 1920;
double e5 = -17253.0 / 339200;
double e6 = 22.0 / 525;
double e7 = -1.0 / 40;

void Diffuse(double t0, double tfinal, double* y0, int grid_size)
{
    _MM_SET_FLUSH_ZERO_MODE(_MM_FLUSH_ZERO_ON);

    int iterations = 0;

    double err;
    double tnew;
    int nsteps = 0;
    int nfevals = 0;
    int nfailed = 0;

    double* f1 = new double[grid_size * grid_size];
    double* f2 = new double[grid_size * grid_size];
    double* f3 = new double[grid_size * grid_size];
    double* f4 = new double[grid_size * grid_size];
    double* f5 = new double[grid_size * grid_size];
    double* f6 = new double[grid_size * grid_size];
    double* f7 = new double[grid_size * grid_size];
    double* ynew = new double[grid_size * grid_size];

    double hmax = 0.1 * (abs(tfinal - t0));
    double htspan = 1; // = t1 - t0
    double rtol = 1e-3;
    double atol = 1e-6;
    double threshold = atol / rtol;

    odeFcn_main(grid_size, y0, f1);

    double t = t0;
    double* y = y0;

    double _pow = 1.0 / 5;
    double hmin = 16 * eps(t);

    // Compute an initial step size h using y'(t).
    double absh = std::min(hmax, htspan);

    double largest0 = 0;
    for (int i = 0; i < grid_size * grid_size; i++)
    {
        double r = std::abs(f1[i] / std::max(abs(y[i]), threshold));
        if (r > largest0)
            largest0 = r;
    }
    double rh = largest0 / (0.8 * pow(rtol, _pow));

    if (absh * rh > 1)
        absh = 1 / rh;
    absh = std::max(absh, hmin);

    bool done = false;
    while (!done)
    {
        double hmin = 16 * eps(t);
        absh = std::min(hmax, std::max(hmin, absh));
        double h = absh;

        if (1.1 * absh >= abs(tfinal - t))
        {
            h = tfinal - t;
            absh = abs(h);
            done = true;
        }

        bool nofailed = true;

        while (true)
        {
            iterations++;
            for (int i = 0; i < grid_size * grid_size; i++)
                ynew[i] = y[i] + h * (b11 * f1[i]);
            odeFcn_main(grid_size, ynew, f2);

            for (int i = 0; i < grid_size * grid_size; i++)
                ynew[i] = y[i] + h * (b21 * f1[i] + b22 * f2[i]);
            odeFcn_main(grid_size, ynew, f3);

            for (int i = 0; i < grid_size * grid_size; i++)
                ynew[i] = y[i] + h * (b31 * f1[i] + b32 * f2[i] + b33 * f3[i]);
            odeFcn_main(grid_size, ynew, f4);

            for (int i = 0; i < grid_size * grid_size; i++)
                ynew[i] = y[i] + h * (b41 * f1[i] + b42 * f2[i] + b43 * f3[i] + b44 * f4[i]);
            odeFcn_main(grid_size, ynew, f5);

            for (int i = 0; i < grid_size * grid_size; i++)
                ynew[i] = y[i] + h * (b51 * f1[i] + b52 * f2[i] + b53 * f3[i] + b54 * f4[i] + b55 * f5[i]);
            odeFcn_main(grid_size, ynew, f6);

            tnew = t + h;
            if (done)
                tnew = tfinal;   // Hit end point exactly.
            h = tnew - t;      // Purify h.
            for (int i = 0; i < grid_size * grid_size; i++)
                ynew[i] = y[i] + h * (b61 * f1[i] + b63 * f3[i] + b64 * f4[i] + b65 * f5[i] + b66 * f6[i]);
            odeFcn_main(grid_size, ynew, f7);

            nfevals = nfevals + 6;

            double largest = 0;
            for (int i = 0; i < grid_size * grid_size; i++)
            {
                double fE = f1[i] * e1 + f3[i] * e3 + f4[i] * e4 + f5[i] * e5 + f6[i] * e6 + f7[i] * e7;
                double r = std::abs(fE / std::max(std::max(y[i], ynew[i]), threshold));
                if (r > largest) largest = r;
            }
            err = absh * largest;

            // Accept the solution only if the weighted error is no more than the
            // tolerance rtol.Estimate an h that will yield an error of rtol on
            // the next step or the next try at taking this step, as the case may be,
            // and use 0.8 of this value to avoid failures.
            if (err > rtol)                       // Failed step
            {
                nfailed = nfailed + 1;
                if (absh <= hmin)
                {
                    //warning(message('MATLAB:ode45:IntegrationTolNotMet', sprintf('%e', t), sprintf('%e', hmin)));
                    //solver_output = odefinalize(solver_name, sol, outputFcn, outputArgs, printstats, [nsteps, nfailed, nfevals], nout, tout, yout, haveEventFcn, teout, yeout, ieout, { f3d,idxNonNegative});
                }

                if (nofailed)
                {
                    nofailed = false;
                    absh = std::max(hmin, absh * std::max(0.1, 0.8 * pow(rtol / err, _pow)));
                }
                else
                    absh = std::max(hmin, 0.5 * absh);

                h = absh;
                done = false;
            }
            else                                // Successful step
                break;
        }
        nsteps = nsteps + 1;

        // Advance the integration one step.
        t = tnew;

        for (int i = 0; i < grid_size * grid_size; i++)
        {
            y[i] = ynew[i];
            f1[i] = f7[i];
            // Already have f(tnew, ynew)
        }

        if (done)
            break;

        // If there were no failures compute a new h.
        if (nofailed)
        {
            // Note that absh may shrink by 0.8, and that err may be 0.
            double temp = 1.25 * pow(err / rtol, _pow);
            if (temp > 0.2)
                absh = absh / temp;
            else
                absh = 5.0 * absh;
        }
    }

    delete[] f1;
    delete[] f2;
    delete[] f3;
    delete[] f4;
    delete[] f5;
    delete[] f6;
    delete[] f7;
    delete[] ynew;
}