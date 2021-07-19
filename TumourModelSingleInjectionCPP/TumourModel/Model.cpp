#include "Model.h"

Pancreas* SeedAndGrowToStartVolume(double p0, double psc, int dmax, int gage, int page, double startVolume)//, void(*render)(int, int, Pancreas*, int))
{
	Params* parameters = new Params(p0, psc, dmax, gage, page);
	vector<Cell*> empty;
	Pancreas* pancreas = new Pancreas(empty, parameters);
	// start with just one infected cancer cell nearest to (0, 0)
	pancreas->CreateInitialTumour();

	// pre-observation phase - run until tumour reaches start volume
	double volume = 0;
	int days = 0;
	while (volume < startVolume && days < 200)
		volume = pancreas->SimulateOneDay(days++);//, render);

	// who disposes parameters???
	return pancreas;
}

void SimulateWholeExperiment(double p0, double psc, int dmax, int gage, int page, double startVolume, int timeSteps, double volumes[])//, void(*render)(int, int, Pancreas*, int))
{
	Pancreas* pancreas = SeedAndGrowToStartVolume(p0, psc, dmax, gage, page, startVolume);//, render);

	volumes[0] = pancreas->TumourVolume();

	int xloc = 0;
	int yloc = 50;
	double conc = 100.0;
	
	pancreas->InjectDrug(xloc, yloc, conc);

	for (int day = 1; day < timeSteps; day++)
	{
		volumes[day] = pancreas->SimulateOneDay(day);//, render);

		if (volumes[day] > 10000) // terminate early if growth is out of control
		{
			for (int i = day + 1; i < timeSteps; i++)
				volumes[i] = 1000000;
			break;
		}
	}

	delete pancreas;
}

void PerformMultipleRuns(double p0, double psc, int dmax, int gage, int page, double startVolume, int timeSteps, int iterations, double volumes[])//, void(*render)(int, int, Pancreas*, int))
{
	for (int j = 0; j < timeSteps; j++)
		volumes[j] = 0;

	for (int i = 0; i < iterations; i++)
	{
		double* v = new double[timeSteps];
		SimulateWholeExperiment(p0, psc, dmax, gage, page, startVolume, timeSteps, v);//, render);
		for (int j = 0; j < timeSteps; j++)
			volumes[j] += v[j];

		delete[] v;
	}

	for (int j = 0; j < timeSteps; j++)
		volumes[j] /= iterations;
}

Pancreas* CreateNewParticle(double p0, double psc, int dmax, int gage, int page, Pancreas* pancreas)
{
	return pancreas->CreateNewParticle(new Params(p0, psc, dmax, gage, page));
}
