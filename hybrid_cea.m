clc;
close all;
clear all;

iters = 10;


%% OF Ratio

% Declare the reactants for CEA to work with. 
reactants =   [                                         ...
       CEA.Reactant('C5 H8 O2','Type','Fuel','E', DimVar(430500, 'J/mol'), 'T',DimVar(298,'K'),'Q',DimVar(0.1,'kg')), ...
%         CEA.Reactant('C 7.3165 H 10.3360 O 0.1063','Type','Fuel','E', DimVar(1200, 'cal/mol'), 'T',DimVar(298,'K'),'Q',DimVar(0.1,'kg'))       
%        CEA.Reactant('Paraffin','Type','Fuel', 'T',DimVar(298,'K'),'Q',DimVar(0.1,'kg')), ...   
        CEA.Reactant('O2 (g)','Type','ox','T',DimVar(0,'K'), 'Q',DimVar(0.1,'kg')) ...
            ];       
        
OF = linspace(1, 20, iters);
test_p = 350; % psi
        
for i = 1:iters

    data =  CEA.Run(reactants,                                ...
            'ProblemType','Rocket',                         ...
            'Flow','eq',                                    ...
            'Pc',DimVar(test_p,'psi'),                           ...
            'OF',OF(i)^-1,                                         ...
            'Outputs',{'isp'});
    isp(i) = data.isp(2).Value;
        
end 

plot(OF, isp)
