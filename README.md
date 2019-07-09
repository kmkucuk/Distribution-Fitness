# Distribution-Fitness

FitYourDistribution(x,[0 or 1]) fits your values into both gamma and lognormal distributions. At the same time it analyses the fit of your values into these distributions by conducting a Chi-Square goodness of fit analysis. Parameters of the Chi-Square test are saved into your workspace as "ChiSquareParameters". Also these parameters are printed in your command window. 

***You have to import your own values into workspace for this analysis (x). Make sure that values in the variable consitute a column vector (e.g. x(n,1) where n is row numbers and 1 is the maximum column number). If you chose 0 as the second parameter of this function, then you won't have graph. If you choose 1, then a theoretical distribution will be created and plotted together with your data.

First row of ChiSquareParameters belongs to goodness of fit of gamma distribution. 
ChiSquareParameters(1,1)= First value represents the hypothesis of "your values constitute a gamma distribution". If this value is 0 than this hypothesis is not rejected, indicating that it is a good fit.
ChiSquareParameters(1,2)=Second value is your "p" value. If this is below .05, traditionally your fit is not good. 
ChiSquareParameters(1,3)=Third value is your Chi-Square statistics.

Same order for parameters apply to second row which belongs to goodness of fit parameters for lognormal distribution.


                                 

