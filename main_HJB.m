clear all
close all
format short 
clc
% =========================================================================
% Parameters of the PDE
% Constants
rho1 = 0.0255;
rho2 = 0.0211;
theta = -2;
q1 = 1;
q2 = 10;
sigma = .5 ;
% Diffusion term and Hamiltonian
sigmafun = @(x) sigma*x.*(1-x);% Diffusion term
Hfun = @(t, x) pi*cos(pi*x).*sin(pi*t) + 0.5*(sigmafun(x)*pi).^2.*cos(pi*x).*cos(pi*t);
% =========================================================================
% Excat solution to be approximated
Vfun = @(t, x) cos(pi*x).*cos(pi*t);
% =========================================================================
% Parameters of the dscretization
L = 1000; M = 100;
t = linspace(0, 1, L)'; dt = t(2) - t(1);
x = linspace(0, 1, M); dx = x(2) - x(1);
% Paths of the process Xt moving away from x at time t-dt;
Xr = x +  sigmafun(x)*sqrt(dt);
Xl = x - sigmafun(x)*sqrt(dt);
% =========================================================================
% pre-allocation
V = zeros(L, M); H = V; Vexact = Vfun(t, x);
%
% Initialization
V(end, :) = Vexact(end, :);
H = Hfun(t, x);
% =========================================================================
% The calculations begin here
tic
disp('Computations ongoing!');
for i = L:-1:2
    V(i-1, :) = (0.5)*(interp1(x, V(i,:), Xl) + interp1(x, V(i,:), Xr)) + dt*H(i-1, :);
    % interp1 (1-D data interpolation)
    % Vector x contains the sample points, and V contains the corresponding
    % values, V(x). Vector X contains the coordinates of the query points.
end
disp('Computation over!');
toc
% The calculations end here
% =========================================================================
% Saving steps
% The computed solution will be stored in a *.mat file
filename = 'MyValueFunction.mat';
%
disp('Saving....');
save(filename, 'Vexact', 'V', 't', 'x')
clear all
disp('Complete.');