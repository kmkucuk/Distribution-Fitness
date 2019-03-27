function [ObservedProbabilityLog,ExpectedProbabilityLog,Logdist,RandLog]=LogFit(x,emp_x_axis)

%%% Observed and Expected Probability variables registers Y axis of both
%%% observed and randomly created lognormal distributions. They can be
%%% indexed for plotting use.
xLength=length(x);
 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Observational Lognormal Distribution %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Creates a Probability Density Function from observed
        %%% variable. This transforms our raw frequency data into probabilistic
        %%% values that correspond to our observed data such as: 5 presses
        %%% happens %10 of the time. While raw data says 5 presses happened 4
        %%% times within our sample.
        
        Logdist=fitdist(x,'Lognormal');
        %%% Y Axis for observed distribution
        
        obs_y_axis=pdf(Logdist,emp_x_axis);
        ObservedProbabilityLog=obs_y_axis;
        
        %%% Parameters of lognormal distribution obtained from data.
        %%% mean and standard deviation
        
        LogMean=Logdist.mu;
        LogSD=Logdist.sigma;    
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Expected Lognormal Distribution %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Creates a random lognormal distribution from the
        %%% mean and sd of our observed variable
        
        RandLog=lognrnd(LogMean,LogSD,[xLength 1]);        %%%Create ideal lognormal values from observed values
        TheoryLogDist=fitdist(RandLog,'Lognormal');        %%%Fit ideal lognormal values into distribution
        expect_y_axis=pdf(TheoryLogDist,emp_x_axis);        %%%Create probability density functions from ideal lognormal values
        
        %%% Y axis for expected distribution
        ExpectedProbabilityLog=expect_y_axis;
        
        assignin('base','RandLogValues',RandLog);
end
        
        

