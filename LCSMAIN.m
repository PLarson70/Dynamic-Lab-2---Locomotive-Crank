%% Clear

clear; clc; close all;

%% Import Real Data (No Need to Loop)

[exp05.angle, exp05.omega, exp05.v, exp05.time] = LCSDATA("Test1_05pt5V");
[exp06.angle, exp06.omega, exp06.v, exp06.time] = LCSDATA("Test1_06pt5V");
[exp07.angle, exp07.omega, exp07.v, exp07.time] = LCSDATA("Test1_07pt5V");
[exp08.angle, exp08.omega, exp08.v, exp08.time] = LCSDATA("Test1_08pt5V");
[exp09.angle, exp09.omega, exp09.v, exp09.time] = LCSDATA("Test1_09pt5V");
[exp10.angle, exp10.omega, exp10.v, exp10.time] = LCSDATA("Test1_10pt5V");

%% Model

% Defining our constants (and spaces)
mod.r = 7.6; % cm
mod.d = 17.2; % cm
mod.l = 25.35; % cm

% Getting omega from data files
mod.omega05 = exp05.omega; % rad / s
mod.omega06 = exp06.omega; % rad / s
mod.omega07 = exp07.omega; % rad / s
mod.omega08 = exp08.omega; % rad / s
mod.omega09 = exp09.omega; % rad / s
mod.omega10 = exp10.omega; % rad / s

% Creating angle based on omega length
mod.angle05 = linspace(0, 12 * pi, length(mod.omega05))'; % rad
mod.angle06 = linspace(0, 12 * pi, length(mod.omega06))'; % rad
mod.angle07 = linspace(0, 12 * pi, length(mod.omega07))'; % rad
mod.angle08 = linspace(0, 12 * pi, length(mod.omega08))'; % rad
mod.angle09 = linspace(0, 12 * pi, length(mod.omega09))'; % rad
mod.angle10 = linspace(0, 12 * pi, length(mod.omega10))'; % rad

% Modeling velocity
mod.v05 = LCSMODEL(mod.r, mod.d, mod.l, mod.angle05, mod.omega05); % cm / s
mod.v06 = LCSMODEL(mod.r, mod.d, mod.l, mod.angle06, mod.omega06); % cm / s
mod.v07 = LCSMODEL(mod.r, mod.d, mod.l, mod.angle07, mod.omega07); % cm / s
mod.v08 = LCSMODEL(mod.r, mod.d, mod.l, mod.angle08, mod.omega08); % cm / s
mod.v09 = LCSMODEL(mod.r, mod.d, mod.l, mod.angle09, mod.omega09); % cm / s
mod.v10 = LCSMODEL(mod.r, mod.d, mod.l, mod.angle10, mod.omega10); % cm / s

%% Plot - Test 05

% Velocity plotted as a function of angle
figure();

hold on;
plot(mod.angle05, mod.v05);
plot(exp05.angle, exp05.v);

% Graph metadata
title("Modeled vs experimental locomotive crank movement - Test 05");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

%% Plot - Test 06

% Velocity plotted as a function of angle
figure();

hold on;
plot(mod.angle06, mod.v06);
plot(exp06.angle, exp06.v);

% Graph metadata
title("Modeled vs experimental locomotive crank movement - Test 06");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

%% Plot - Test 07

% Velocity plotted as a function of angle
figure();

hold on;
plot(mod.angle07, mod.v07);
plot(exp07.angle, exp07.v);

% Graph metadata
title("Modeled vs experimental locomotive crank movement - Test 07");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

%% Plot - Test 08

% Velocity plotted as a function of angle
figure();

hold on;
plot(mod.angle08, mod.v08);
plot(exp08.angle, exp08.v);

% Graph metadata
title("Modeled vs experimental locomotive crank movement - Test 08");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

%% Plot - Test 09

% Velocity plotted as a function of angle
figure();

hold on;
plot(mod.angle09, mod.v09);
plot(exp09.angle, exp09.v);

% Graph metadata
title("Modeled vs experimental locomotive crank movement - Test 09");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

%% Plot - Test 10

% Velocity plotted as a function of angle
figure();

hold on;
plot(mod.angle10, mod.v10);
plot(exp10.angle, exp10.v);

% Graph metadata
title("Modeled vs experimental locomotive crank movement - Test 10");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");