function [ sys ] = systemResponse( beta,Cd,E,R )
% Author: Rajitha Meka
% System Response for Wind Turbine

%% System Parameters
V = 18; %Wind Speed
V_d = 16; %Disturbance will be (Alpha/Jr)*Delta_v where Delta_v = 18-16 = 2
Delta_v = abs(V-V_d);
Tg = 2130; %Generator Torque
Jg = 10; %Generator Inertia
Jr = 90000; %Rotor Inertia
Dg = 0.005; %Generator Friction Coefficient
Dr = 0.14; %Rotor Friction Coefficient
rho = 1.2; %Air Density
Omega = 4.3; %Rotor speed
L = (Omega*R)/V; % Tip speed ratio
Li = 1/(L+0.08*beta)-0.035/(beta^2+1); 
Cp = 0.22*((116*Li)-(0.4*beta)-5)*exp(-22.5*Li); %Power Conversion Coefficient
%Torque gained from wind energy
Tr = (0.5*pi*rho*(R^2)*Cp*(V^2))/L;
%At Operating conditions V,beta and Omega
%G = derivative of Tr w.r.t to Omega
G = ((0.5*pi*rho*(R^2)*(V^2))/L)*(0.22*(((116/(((Omega*R)/V)+(0.08*beta)))-4.06/(beta^2+1))...
    *exp((-22.5/(((Omega*R)/V)+(0.08*beta)))+0.788/(beta^2+1))...
    *(22.5/(((Omega*R)/V)))*(R/V))+...
    0.22*(exp((-22.5/(((Omega*R)/V)+(0.08*beta)))+0.788/(beta^2+1))*...
    (-116/(((Omega*R)/V)^2)*(R/V))));
%Z = derivative of Tr w.r.t to beta
Z = ((0.5*pi*rho*(R^2)*(V^2))/L)*(0.22*(((116/(((Omega*R)/V)+(0.08*beta)))-4.06/(beta^2+1)-(0.4*beta)-5)...
    *exp((-22.5/(((Omega*R)/V)+(0.08*beta)))+0.788/(beta^2+1))...
    *((1.8/(((Omega*R)/V)^2))-((1.575*beta)/((beta^2+1)^2))))+...
    0.22*(exp((-22.5/(((Omega*R)/V)+(0.08*beta)))+0.788/(beta^2+1))*...
    (116*(-0.08/(((Omega*R)/V)^2))+((0.07*beta)/((beta^2+1)^2))-0.4)));
%Alpha = derivative of Tr w.r.t to V
Alpha = (pi*rho*(R^2)*Cp*V_d)/L;
%% State Space Model
A = [(G-Cd-Dr)/Jr -1/Jr Cd/Jr;E 0 -E;Cd/Jg 1/Jg -Cd-Dg/Jg];
B = [Z/Jr;0;0];
C = [0 0 1];
D = 0;
F = [Alpha/Jr;0;0]; %Disturbance
sys = ss(A,B,C,D);


end

