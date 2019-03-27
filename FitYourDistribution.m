function [RmseValues,CompleteDistributionValues]=FitYourDistribution(x,y)

    rng('shuffle');
    
    format long
    
    if ~isvector(x)
        error('Input must be a vector')
    end
    
    %%% Setting Figure Name and X axis for distributions%%%
    %%% X Axis is based on the maximum value of the observed values,
    %%% otherwise distribution ends prematurely or extends unnecessaryly
    
    VarName=inputname(1);  
    emp_x_axis=sort(x).';
    
        %%% Call distribution fitting functions
    
        [ObservedProbabilityLog,ExpectedProbabilityLog,Logdist,RandLogValues]=LogFit(x,emp_x_axis);

        [ObservedProbabilityGamma,ExpectedProbabilityGamma,Gammadist,RandGammaValues]=GammaFit(x,emp_x_axis);
        
        %%% Plot Theoretical and Observed Distributions %%%
        %%% Star plots are our observed data, while line is our ideal
        %%% lognormal distribution. Same logic applies to gamma
        %%% distribution
        
        if y==1
            figure('Name',VarName,'NumberTitle','off');
            subplot(2,1,1);
            plot(emp_x_axis,ObservedProbabilityLog,'*',emp_x_axis,ExpectedProbabilityLog)
            title('Lognormal Distribution');

            subplot(2,1,2);
            plot(emp_x_axis,ObservedProbabilityGamma,'*',emp_x_axis,ExpectedProbabilityGamma)
            title('Gamma Distribution');
        else
        end
        
        %%% Chi Square Goodness of fit analyses
        %%% 
       [ChiTestParameters]=ChiSqTest(x,Gammadist,Logdist);
       
       fprintf('\n %s \n %f \n %s \n %f \n \n','ChiSqGamma',ChiTestParameters(1,:),'ChiSqLog',ChiTestParameters(2,:));
        
        
        %%% Goodness of fit with Root-mean squared values between
        %%% probability values of expected and observed CDFs      
        
        MSELogFitness=goodnessOfFit(x,RandLogValues,'MSE');
        MSEGammaFitness=goodnessOfFit(x,RandGammaValues,'MSE');
        
        rmseLog=sqrt(MSELogFitness);
        rmseGamma=sqrt(MSEGammaFitness);
        
        if MSELogFitness<MSEGammaFitness
            fprintf('%s %s\n  %s\n %s %f\n %s %f', 'Lognormal distribution yields a better fit for ',VarName,'Root mean squared value:', 'Lognormal Distribution: ',round(rmseLog,5),'Gamma Distribution:     ',round(rmseGamma,5));
        else 
            fprintf('%s %s\n  %s\n %s %f\n %s %f', 'Gamma distribution yields a better fit for ',VarName,'Root mean squared value:', 'Lognormal Distribution: ',round(rmseLog,5),'Gamma Distribution:     ',round(rmseGamma,5));
        end

        CompleteDistributionValues=[emp_x_axis;ExpectedProbabilityLog;ObservedProbabilityLog;ExpectedProbabilityGamma;ObservedProbabilityGamma];
        
        RmseValues=[rmseLog;rmseGamma];
        
       end
    