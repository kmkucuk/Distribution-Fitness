# Distribution-Fitness

Here i used "VariableExtractionFor_Fitness" code for extracting relevant variables from an Excel file for using in MATLAB. 

Then within those variables, i used the desired one for conducting a goodness of fit analysis. 

This analysis involved both Lognormal and Gamma Distributions. Reason was my research subject. 
I had to fit relevant variables into these two distributions for validity purposes in my research and these were coded in Excel as:
'TL_Lattice', 'BR_Lattice','BL_Cube', 'TR_Cube','Hor_endo','Ver_endo','EndoPressCount','LatticePressCount','CubePressCount'

You can change the names of these variables in "VariableExtractionFor_Fitness" file and add your own variable names coded in Excel. 
Directories have to change as well.

If you somehow managed to import your variables to MATLAB then you can type FitYourDistribution("Yourvariablename", "0 (no graphs) or 1 (with graphs)").
Than code will fit your values into both Gamma and Lognormal distributions, compare their root mean squared errors and type whichever is best for you.

[RmseValues,TheoreticalDistributionValues,DistributionParameters]=FitYourDistribution(x,y)

RmseValues = are root means squared errors for Lognormal and Gamma respectively.

TheoreticalDistributionValues = [ (1) your variables' raw values; 
                                  (2) expected lognormal distribution pdf; 
                                  (3) observed lognormal distribution pdf;
                                  (4) expected gamma distribution pdf;
                                  (5) observed gamma distribution pdf]
                                  
DistributionParameters = [ (1) alpha of lognormal dist;
                           (2) sigma of lognormal dist;
                           (3) alpha of gamma dist;
                           (4) sigma of gamma dist]

