%% Ablation Sim

% Code for analyzing ablation. First implementation - just a basic analysis
% of charing rate. Future expansion - low pressur ablation analysis, etc. 

%% Constant Declaration

Tw = KtoR(2500); %Tabulated values relate to rankine temp because sad. 

% For silica-phenolic 
a = 0.11;
b = 2;
c = 10^5;

burntime = 20; %s

%% Calculate

rdot = a * (Tw^b) * exp(-c/Tw)

burn = burntime*rdot














function R = KtoR(K)
    R = (K - 273.15)*1.8000 + 491.67;
end