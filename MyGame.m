clear all
close all
format short 
clc

C = Myconstants

% Parameters of the pde
L = 10000; M = 10000;
t = linspace(0, 1, L); dt = t(2) - t(1);
x = linspace(0, 1, M); dx = x(2) - x(1);
%
% pre-allocation for efficiency********************************************
V = zeros(L, M);
%
% Initialization
V(end, :) = (1/C.theta)*C.q2;
filename = 'MyValueFunction.mat';
%
% Paths of the process Xt moving away from x at time t-dt;
Xr  = x + bfun(x, C)*dt + sigfun(x, C)*sqrt(dt);
Xl  = x + bfun(x, C)*dt - sigfun(x, C)*sqrt(dt);
%
% Calcul proprement dit----------------------------------------------------
disp('Computation ongoing!');
tic
for i = L:-1:2
    Z         = (0.5/sqrt(dt))*(interp1(x, V(i,:), Xr)...
                                                -  interp1(x, V(i,:), Xl));
    V(i-1, :) = (0.5)*(interp1(x, V(i,:), Xl) + interp1(x, V(i,:), Xr))...
                                                        + dt*Hfun(x, Z, C);
    % interp1 (1-D data interpolation)
    % Vector x contains the sample points, and V contains the corresponding
    % values, V(x). Vector X contains the coordinates of the query points.
end
toc
disp('Computation over!');
disp('Saving....');
save(filename, 'V', 't', 'x')
clear all
disp('Solution saved.');


%--------------------------------------------------------------------------
%
% visu
%
function output = Gfun(x, C)           % Terminal condition
    output= cos(2*pi*x);
end
%
function output = bfun(x, C)           % Drift
    output = (0.5)*(C.rho1*(1 - x)).^2 + (0.5*C.theta)*(C.rho2*x).^2;
end
function output = sigfun(x, C)         % Diffusion
    output = (C.sigma)*x.*(1-x);
end
%
function output = Hfun(x, z, C)        % Hamiltonian
output = (0.25)*(2*z - 1).*( (C.rho1*(1-x)).^2 + (C.rho2*x).^2)...
    + (C.q1 - C.q2/C.theta)*x;
end
 