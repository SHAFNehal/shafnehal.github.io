%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Project Name: Optimization of Wind Turbine Disturbance Using Design of Experiments Methodology
%	Author:	Rajitha Meka, Syed Hasib Akhter Faruqui
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear Previous Data
clc;
clear;

%% Main Code
count=1;  % Storage Count
% Change "Pitch_Angle" value over the loop
for Pitch_Angle=19:1:20
    % Change "Damping Coefficient" value over the loop
    for Cd=60000:10000:80000
        % Change "Elastic coefficient" value over the loop
        for E=60000:10000:80000
            % Change "Radius of Rotor " value over the loop
            for R= 10:1:12
                % Calculate necessary Information
                [ sys ] = systemResponse( Pitch_Angle,Cd,E,R );
                StepInfo=stepinfo(sys);
                
                % Store the information in Data Storage
                Data(count,1)=Pitch_Angle;
                Data(count,2)=Cd;
                Data(count,3)=E;
                Data(count,4)=R;
                Data(count,5)=StepInfo.Overshoot;
                Data(count,6)=StepInfo.SettlingTime;
                
                % Change the count for storage
                count=count+1;
            end
        end
    end
end

%% Convert Data to Table
DataTable=array2table(Data);
DataTable.Properties.VariableNames = {'Pitch_Angle','Damping_Coefficient'...
                                       ,'Elastic_coefficient','Rotor_Radius','Overshoot','Settling_Time'};