#pragma once

#include "Pancreas.hpp"

#ifdef WAK_EXPORT
#define WAK_API __declspec(dllexport)
#else
#define WAK_API __declspec(dllimport)
#endif

extern "C"
{
	WAK_API Pancreas* SeedAndGrowToStartVolume(double p0, double psc, int dmax, int gage, int page, double startVolume);//, void (*render)(int, int, Pancreas*, int));
	WAK_API void SimulateWholeExperiment(double p0, double psc, int dmax, int gage, int page, double startVolume, int timeSteps, double volumes[]);//, void (*render)(int, int, Pancreas*, int));
	WAK_API void PerformMultipleRuns(double p0, double psc, int dmax, int gage, int page, double startVolume, int timeSteps, int iterations, double volumes[]);//, void(*render)(int, int, Pancreas*, int));
	WAK_API Pancreas* CreateNewParticle(double p0, double psc, int dmax, int gage, int page, Pancreas* pancreas);
}
