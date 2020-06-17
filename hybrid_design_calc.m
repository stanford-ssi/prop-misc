%% Hybrid Design Script

clc;
close all;
clear all;

% This script is based on Greg Zilliac's approach to Hybrid Design in the
% AA 284A class. 

%% Inputs

max_od = 0.171; % m
T_avg = 4448; %N
t_burn = 15; %s
p_amb = 101325;
gc = 9.81; %m/s^2
roh_f = 1042; %kg/m^3


%% Step One: Chamber Pressure 

pcc = 2.4e6; %Pa (350psi)

%% Step Two: Optimize with CEA

OF = 3.15;
Isp = 248.3;
gamma = 1.135;
cstar = 1737.8;

% Regression Constants
a = 0.000272;
n = 0.5;


%% Step 3: Find nozzle exit pressure

epsilon = 3.55;

syms p2
eqn1 = 0 == (((gamma + 1)/2)^(1/(gamma - 1)))*((p2/pcc)^(1/gamma))*sqrt(((gamma+1)/(gamma-1))*(1-(p2/pcc)^((gamma - 1)/gamma))) - 1/epsilon;

p_exit = vpasolve(eqn1, p2)

%% Step 4: Thrust Coefficient

Cf = sqrt(((2*gamma^2)/(gamma - 1))*(2/(gamma + 1))^((gamma + 1)/(gamma - 1))*(1 - (p_exit/pcc)^((gamma - 1)/gamma))) + epsilon*(p_exit - p_amb)/pcc

%% Step 5: Efficiencies

nozz_eff = 0.992;
c_star_eff = 0.85;

%% Step 6: Initial Throat Area

At = T_avg/(nozz_eff*Cf*pcc)


%% Step 7: Mass Flow Rates

mdot = (gc*pcc*At)/(10*c_star_eff*cstar) %???
mdot_f = mdot/(OF + 1)
mdot_o = mdot_f*OF

%% Step 8: Get Inner Radius to Start

syms Ri
Rf = max_od/2;

eqn2 = t_burn == (Rf^(2*n + 1) - Ri^(2*n + 1))/(a*(2*n + 1)*(mdot_o/pi)^n);

Ri = vpasolve(eqn2);

Ri = Ri(2)


%% Step 9: Grain Length


Rdot = a*(mdot_o/(pi*Ri^2))^n

Rdot = simplify(Rdot)

L = mdot_f/(2*pi*Ri*roh_f*Rdot);

L = simplify(L)

%% Step 10: Find ox fuel

mox = mdot_o * t_burn






