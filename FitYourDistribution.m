function [RmseValues,TheoreticalDistributionValues,DistributionParameters]=FitYourDistribution(x,y)

    rng('default');

    format long

    if ~isvector(x)
        error('Input must be a vector')
    end

    %%% Setting Figure Name and X axis for distributions%%%
    %%% X Axis is based on the maximum value of the observed values,
    %%% otherwise distribution ends prematurely or extends unnecessaryly
    VarName=inputname(1);
    xLength=round(max(x));
    emp_x_axis=sort(x).';

    %%% Creating 2 plots at the same time, first one is at the top, second
    %%% one is at the bottom


        %%% Observational Lognormal Distribution %%%
        %%% Creates a Probability Density Function from our observed
        %%% variables. This transforms our raw frequency data into probabilistic
        %%% values that correspond to our observed data such as: 5 presses
        %%% happens %10 of the time. While raw data says 5 presses happened 4
        %%% times within our sample.
        Logdistvariables=fitdist(x,'Lognormal');
        LogAlpha=Logdistvariables.mu;
        LogSigma=Logdistvariables.sigma;
        emp_y_axis=pdf(Logdistvariables,emp_x_axis);

        Log_CurvePDF=emp_y_axis;

        %%% Theoretical Lognormal Distribution %%%
        %%% Creates a theoretical, in other words ideal, lognormal
        %%% distribution from the mean and sd of our observed variable

        IdealLog=lognrnd(LogAlpha,LogSigma,[xLength 1]); %%%Create ideal lognormal values from observed values
        TheoryLogDist=fitdist(IdealLog,'Lognormal');    %%%Fit ideal lognormal values into distribution
        dist_y_axis=pdf(TheoryLogDist,emp_x_axis);       %%%Create probability density functions from ideal lognormal values

        Log_TheoValues=dist_y_axis;






        Gammadistvariables=fitdist(x,'Gamma');
        GammaAlpha=Gammadistvariables.a;
        GammaSigma=Gammadistvariables.b;
        emp_y_axis=pdf(Gammadistvariables,emp_x_axis); %#ok<*NASGU>

        Gamma_CurvePDF=emp_y_axis;

        %%% Theoretical Gamma Distribution %%%

        IdealGamma=gamrnd(GammaAlpha,GammaSigma,[xLength 1]);

        TheoryGammaDist=fitdist(IdealGamma,'Lognormal');
        dist_y_axis=pdf(TheoryGammaDist,emp_x_axis);

        %%% Curve values for fitting observed and ideal line
        Gamma_TheoValues=dist_y_axis;

        %%% Plot Theoretical and Observed Distributions %%%
        %%% Star plots are our observed data, while line is our ideal
        %%% lognormal distribution. Same logic applies to gamma
        %%% distribution

        if y==1
            figure('Name',VarName,'NumberTitle','off');
            subplot(2,1,1);
            plot(emp_x_axis,emp_y_axis,'*',emp_x_axis,Log_TheoValues)
            title('Lognormal Distribution');

            subplot(2,1,2);
            plot(emp_x_axis,emp_y_axis,'*',emp_x_axis,Gamma_TheoValues)
            title('Gamma Distribution');
        else
        end


        %%% Goodness of Fit between Theoretical and Emprical Distribution
        %%% Values

        MSELogFitness=goodnessOfFit(Log_CurvePDF,Log_TheoValues,'MSE');
        MSEGammaFitness=goodnessOfFit(Gamma_CurvePDF,Gamma_TheoValues,'MSE');

        rmseLog=sqrt(MSELogFitness);
        rmseGamma=sqrt(MSEGammaFitness);

        if MSELogFitness<MSEGammaFitness
            fprintf('%s %s\n  %s\n %s %f\n %s %f', 'Lognormal distribution yields a better fit for ',VarName,'Goodness of fit values:', 'Lognormal Distribution: ',round(rmseLog,5),'Gamma Distribution:     ',round(rmseGamma,5));
        else
            fprintf('%s %s\n  %s\n %s %f\n %s %f', 'Gamma distribution yields a better fit for ',VarName,'Goodness of fit values:', 'Lognormal Distribution: ',round(rmseLog,5),'Gamma Distribution:     ',round(rmseGamma,5));
        end

        TheoreticalDistributionValues=[emp_x_axis;Log_TheoValues;Log_CurvePDF;Gamma_TheoValues;Gamma_CurvePDF];
        DistributionParameters=[LogAlpha,LogSigma,GammaAlpha,GammaSigma];
        RmseValues=[rmseLog;rmseGamma];
end
