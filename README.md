# SurveySelect
Creating an R package to implement complex sampling methods, similar to SAS's PROC SURVEYSELECT.

The goals of this project are to create one package to draw samples, calculate design weights, and allocate sample sizes.

The planned sampling methods to be included are:
* Stratification
  + Any other sampling method can be done within strata
  + Sample allocation including proportional, fixed, and Neyman are to be included
* Simple random sampling without replacement
* Unrestricted Random Sampling aka simple random sampling with replacement
* Systematic sampling
* Probability Proportional to Size (PPS) Sampling
  + PPS without replacement
  + Brewer PPS
  + Murthy PPS
  + Samford PPS
  + Chromy PPS aka Sequential PPS
  + Systematic PPS

Serpentine sorting will be incorporated for systematic sampling and implicit stratification. 