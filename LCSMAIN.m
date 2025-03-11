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

%sub = sqrt(1-(mod.d-sin(mod.angle)*mod.r)^2);
[r_error_05] = calculate_r(mod.angle05,mod.r,mod.d,mod.l,mod.omega05);
[r_error_06] = calculate_r(mod.angle06,mod.r,mod.d,mod.l,mod.omega06);
[r_error_07] = calculate_r(mod.angle07,mod.r,mod.d,mod.l,mod.omega07);
[r_error_08] = calculate_r(mod.angle08,mod.r,mod.d,mod.l,mod.omega08);
[r_error_09] = calculate_r(mod.angle09,mod.r,mod.d,mod.l,mod.omega09);
[r_error_10] = calculate_r(mod.angle10,mod.r,mod.d,mod.l,mod.omega10);
function r_error = calculate_r(theta, d, r, l,w)
    % Calculate the components of the expression
    term1 = -cos(theta) .* (d - sin(theta) .* r) ./ (l .* sqrt(1 - (d - sin(theta) .* r).^2 ./ l.^2));
    
    term2 = cos(theta) .* sin(theta) .* r ./ (l .* sqrt(1 - (d - sin(theta) .* r).^2 ./ l.^2));
    
    term3 = cos(theta) .* sin(theta) .* r .* (d - sin(theta) .* r).^2 ./ (l.^3 .* (1 - (d - sin(theta) .* r).^2 ./ l.^2).^(3/2));
    
    term4 = -sin(theta);

    r_error = w.*(term1+term2+term3+term4);
    
    % Combine all terms to form w
    %w = [term1; term2; term3; term4];
end

[d_error_05] = calculate_d(mod.angle05,mod.r,mod.d,mod.l,mod.omega05);
[d_error_06] = calculate_r(mod.angle06,mod.r,mod.d,mod.l,mod.omega06);
[d_error_07] = calculate_r(mod.angle07,mod.r,mod.d,mod.l,mod.omega07);
[d_error_08] = calculate_r(mod.angle08,mod.r,mod.d,mod.l,mod.omega08);
[d_error_09] = calculate_r(mod.angle09,mod.r,mod.d,mod.l,mod.omega09);
[d_error_10] = calculate_r(mod.angle10,mod.r,mod.d,mod.l,mod.omega10);
function d_error = calculate_d(theta, d, r, l,w)
    % Calculate the components of the expression
    numerator = -r .* w .* cos(theta);
    denominator = l .* (1 - (d - r .* sin(theta)).^2 ./ l.^2).^(3/2);
    
    result = numerator ./ denominator;
    d_error = result;
    
end
[l_error_05] = calculate_l(mod.angle05,mod.r,mod.d,mod.l,mod.omega05);
[l_error_06] = calculate_r(mod.angle06,mod.r,mod.d,mod.l,mod.omega06);
[l_error_07] = calculate_r(mod.angle07,mod.r,mod.d,mod.l,mod.omega07);
[l_error_08] = calculate_r(mod.angle08,mod.r,mod.d,mod.l,mod.omega08);
[l_error_09] = calculate_r(mod.angle09,mod.r,mod.d,mod.l,mod.omega09);
[l_error_10] = calculate_r(mod.angle10,mod.r,mod.d,mod.l,mod.omega10);
function l_error = calculate_l(theta, d, r, l,w)
    % Calculate the components of the expression
    terml1 = (l^2 .* sqrt(1 - (d - sin(theta) .* r).^2 ./ l^2));
    
    terml2 = r.*cos(theta) .*(d-r.*sin(theta));
    
    terml3 = l^3.*(1 - (d - sin(theta) .* r).^2 ./ l^2).^3/2;

    terml4 = l^4 .* (1 - (d - sin(theta) .* r).^2 ./ l^2).^3/2;
    l_error = w.*((terml2./terml1)+(terml3./terml4));
    
end

r_uncertainity = 0.05;
d_uncertainity = 0.05;
l_uncertainity = 0.05;
sigma_full_05=sqrt(((r_error_05.^2).*(r_uncertainity^2))+((d_error_05.^2).*(d_uncertainity^2))+((l_error_05.^2).*(l_uncertainity^2)));
sigma_full_06=sqrt(((r_error_06.^2).*(r_uncertainity^2))+((d_error_06.^2).*(d_uncertainity^2))+((l_error_06.^2).*(l_uncertainity^2)));
sigma_full_07=sqrt(((r_error_07.^2).*(r_uncertainity^2))+((d_error_07.^2).*(d_uncertainity^2))+((l_error_07.^2).*(l_uncertainity^2)));
sigma_full_08=sqrt(((r_error_08.^2).*(r_uncertainity^2))+((d_error_08.^2).*(d_uncertainity^2))+((l_error_08.^2).*(l_uncertainity^2)));
sigma_full_09=sqrt(((r_error_09.^2).*(r_uncertainity^2))+((d_error_09.^2).*(d_uncertainity^2))+((l_error_09.^2).*(l_uncertainity^2)));
sigma_full_10=sqrt(((r_error_10.^2).*(r_uncertainity^2))+((d_error_10.^2).*(d_uncertainity^2))+((l_error_10.^2).*(l_uncertainity^2)));
%% Plot - Test 05

% Velocity plotted as a function of angle
figure();

hold on;
plot(mod.angle05, mod.v05);
plot(exp05.angle, exp05.v);
plot(mod.angle05,mod.v05+sigma_full_05, 'g--');
plot(mod.angle05,mod.v05-sigma_full_05,'g--');

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
plot(mod.angle06,mod.v06+sigma_full_06, 'g--');
plot(mod.angle06,mod.v06-sigma_full_06,'g--');

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
plot(mod.angle07,mod.v07+sigma_full_07, 'g--');
plot(mod.angle07,mod.v07-sigma_full_07,'g--');

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
plot(mod.angle08,mod.v08+sigma_full_08, 'g--');
plot(mod.angle08,mod.v08-sigma_full_08,'g--');

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
plot(mod.angle09,mod.v09+sigma_full_09, 'g--');
plot(mod.angle09,mod.v09-sigma_full_09,'g--');

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
plot(mod.angle10,mod.v10+sigma_full_10, 'g--');
plot(mod.angle10,mod.v10-sigma_full_10,'g--');

% Graph metadata
title("Modeled vs experimental locomotive crank movement - Test 10");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");


figure();
hold on;

subplot(2,3,1)
hold on;
plot(mod.angle05, mod.v05);
plot(exp05.angle, exp05.v);
title("Collar Velocity vs Theta - 5.5 Voltage");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

subplot(2,3,2)
hold on;
plot(mod.angle06, mod.v06);
plot(exp06.angle, exp06.v);
title("Collar Velocity vs Theta - 6.5 Voltage");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

subplot(2,3,3)
hold on;
plot(mod.angle07, mod.v07);
plot(exp07.angle, exp07.v);
title("Collar Velocity vs Theta - 7.5 Voltage");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

subplot(2,3,4)
hold on;
plot(mod.angle08, mod.v08);
plot(exp08.angle, exp08.v);
title("Collar Velocity vs Theta - 8.5 Voltage");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

subplot(2,3,5)
hold on;
plot(mod.angle09, mod.v09);
plot(exp09.angle, exp09.v);
title("Collar Velocity vs Theta - 9.5 Voltage");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");

subplot(2,3,6)
hold on;
plot(mod.angle10, mod.v10);
plot(exp10.angle, exp10.v);
title("Collar Velocity vs Theta - 10.5 Voltage");
legend("Model", "Experimental")
xlabel("\theta (rad)");
ylabel("Velocity (cm/s)");
