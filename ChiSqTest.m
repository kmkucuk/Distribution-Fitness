function [ChiSquareParameters]=ChiSqTest(x,Gammadist,Logdist)

%%% Chi Square goodness of fit for both lognormal and gamma distributions
[LogHypothesis,LogSignificance,LogStats]=chi2gof(x,'CDF',Logdist); 
[GammaHypothesis,GammaSignificance,GammaStats]=chi2gof(x,'CDF',Gammadist); 

%%% Chi Square test statistics and more parameters
ChiStatsGamma=GammaStats.chi2stat;
ChiStatsLog=LogStats.chi2stat;

%%% Grouping parameters for saving into workspace

ChiGamma=[GammaHypothesis,GammaSignificance,ChiStatsGamma];

ChiLog=[LogHypothesis,LogSignificance,ChiStatsLog];

ChiSquareParameters=[ChiGamma;ChiLog];

%%% Save Parameters into base workspace

assignin('base','ChiTestParameters',ChiSquareParameters);
end