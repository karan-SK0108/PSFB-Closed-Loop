%Phase shift full bridge DCDC converter
%Step- Up & Down operation
%Bi-Directional - Mosfets at both briges

clc;
 
%Input Parameters
Vin = 24; %Input Voltage (V)
Vout = 800; %Expected Output Voltage (V)
Vout_max = 815; %Expected MAX Output Voltage (V) due to voltage drop
Vout_min = 795; %Expected MAX Output Voltage (V) due to voltage drop
Pout = 5500; %Rated Output Power W
fs = 140e3; %Operating Switching Frequency (Hz)

%Assumed Parameters

% I_ripple 20% of Iout
% V_ripple 1% of Vout
% Transformer - Variable-Ratio Transformer Model Block is used
% D = 0.5 % PWM Duty Cycle = 50%

%Transformer Design Calculation
N = Vout_max/Vin; %Transformer Turns Ratio : Ns/Np = Vo/Vi

%Duty Ratio Calculation
D=(Vout/Vout_max)*(0.5);
d=Vout/(Vin*N);

Ts = 1/fs;

%Load Output Parameters Calculation
Iout = Pout/Vout;
Iout_max = Pout/Vout_max;
Iout_min = Pout/Vout_min;

I_ripple = (20/100)*Iout; % I_ripple 20% of Iout
Iout_peak = Iout*(1+I_ripple);

V_ripple = (1/100)*Vout; % V_ripple 1% of Vout

R_load = (Vout^2) / Pout;

%Voltage Across Filter Inductor Calculation
V_L_Cal = (Vin*N) - Vout;

%Filter Inductance Calculation at Secondary Bridge
L_filter = (V_L_Cal*D*Ts)/I_ripple;
L_filter_req = (Vin*Vout*N)/(8*fs*Pout); %From DAB Calculation

%Filter Capacitance Calculation at Secondary Bridge 
C_filter = (I_ripple*D*Ts)/V_ripple;
C_filter_req = (I_ripple*Ts)/(16*V_ripple)


% Re-Check the Calculation
Pout_Cal = (Vin*Vout*N*Ts*D*(1-D))/(2*L_filter_req)

L_battery = (Vout*D*Ts)/I_ripple;

L_input = (Vin*Vout*N)/(8*fs*Pout);