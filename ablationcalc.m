%% Ablation Sim

% Code for analyzing ablation. First implementation - just a basic analysis
% of charing rate. Future expansion - low pressur ablation analysis, etc. 

%% Constant Declaration

Tw = KtoR(2500); %Tabulated values relate to rankine temp because sad. 

% For silica-phenolic 
% a = 0.11;
a = 1.96e8;
% b = 2;
b = 0;
c = 10^5;

burntime = 11; %s

%% Calculate

rdot = a * (Tw^b) * exp(-c/Tw)

burn = burntime*rdot

burn_cm = burn*2.54




function R = KtoR(K)
    R = (K - 273.15)*1.8000 + 491.67;
end