function [ObservedProbabilityGamma,ExpectedProbabilityGamma,Gammadist,RandGamma]=GammaFit(x,emp_x_axis)

%%% Observed and Expected Probability variables registers Y axis of both
%%% observed and randomly created gamma distributions. They can be
%%% indexed for plotting use.
xLength=length(x);
 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Observational Gamma Distribution %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Creates a Probability Density Function from observed
        %%% variable. This transforms our raw frequency data into probabilistic
        %%% values that correspond to our observed data such as: 5 presses
        %%% happens %10 of the time. While raw data says 5 presses happened 4
        %%% times within our sample.
        
        Gammadist=fitdist(x,'Gamma');
        %%% Y Axis for observed distribution
        
        obs_y_axis=pdf(Gammadist,emp_x_axis);
        ObservedProbabilityGamma=obs_y_axis;
        
        %%% Parameters of gamma distribution obtained from data.
        %%% mean and standard deviation
        
        GammaMean=Gammadist.a;
        GammaSD=Gammadist.b;    
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Expected Gamma Distribution %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Creates a random gamma distribution from the
        %%% mean and sd of our observed variable
        
        RandGamma=gamrnd(GammaMean,GammaSD,[xLength 1]);        %%%Create ideal gamma values from observed values
        TheoryGammaDist=fitdist(RandGamma,'Gamma');             %%%Fit ideal gamma values into distribution
        expect_y_axis=pdf(TheoryGammaDist,emp_x_axis);          %%%Create probability density functions from ideal gammavalues
        
        %%% Y axis for expected distribution
        ExpectedProbabilityGamma=expect_y_axis;
        
        assignin('base','RandGammaValues',RandGamma);
end
        
        

