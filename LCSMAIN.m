%% Clear

clear; clc; close all;

%% Model

% Defining our constants (and spaces)
mod.r = 7.6; % cm
mod.d = 17.2; % cm
mod.l = 25.35; % cm
mod.omega = 5; % rad / s
mod.angle = linspace(0, 12 * pi, 2000); % rad

% Modeling velocity
mod.v = LCSMODEL(mod.r, mod.d, mod.l, mod.angle, mod.omega); % cm / s

%% Import Real Data

[exp.angle, exp.omega, exp.v, exp.time] = LCSDATA("Test1_05pt5V");

%% Plotty

% Velocity plotted as a function of angle
figure();

hold on;
plot(mod.angle, mod.v);
plot(exp.angle, exp.v);

% Graph metadata
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");