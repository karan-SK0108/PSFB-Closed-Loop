%Phase shift full bridge DCDC converter
%step-down operation
%uni-directional

% clear;
% close all;
% clc;
 
%input parameters:
Vin = 800; %input voltage (v)
Vout = 24; %expected output voltage (v)
Vout_max = 25; %max output voltage (v) due to voltage drop
Pout = 5500; %output power (watts)
fs = 140e3; %switching frequency (hz)
%I_ripple 20% of Iout
%V_ripple 1% of Vout

N = Vout_max/Vin; %turns ratio Ns/Np = Vo/Vi

Iout = Pout/Vout;
R_load = (Vout^2) / Pout;
V_L = (Vin*N) - Vout;

%Duty ratio calculation:
D=(Vout/Vout_max)*(0.5);
Ts = 1/fs;

I_ripple = (20/100)*Iout;
V_ripple = (1/100)*Vout;

% %inductance calculation
% L = (V_L*D*Ts)/I_ripple;
% L_battery = (Vout*D*Ts)/I_ripple;
% 
% L_input = (Vin*Vout*N)/(8*fs*Pout);
% 
% %capacitance calculation
% C = (I_ripple*D*Ts)/V_ripple;
% C_battery = 200e-06;
