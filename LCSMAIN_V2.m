%% Clear
clear; clc; close all;

%% Import Real Data

voltages = ["05pt5", "06pt5", "07pt5", "08pt5", "09pt5", "10pt5"];
numTests = length(voltages);

for i = 1:numTests
    testName = "Test1_" + voltages(i) + "V";
    [exp(i).angle, exp(i).omega, exp(i).v, exp(i).time] = LCSDATA(testName);
end

%% Model

% Define constants
mod.r = 7.6;        % cm
mod.d = 17.2;       % cm
mod.l = 25.35;      % cm

for i = 1:numTests

    mod.omega{i} = exp(i).omega;
    mod.angle{i} = linspace(0, 12 * pi, length(mod.omega{i}))'; % rad
    mod.v{i} = LCSMODEL(mod.r, mod.d, mod.l, mod.angle{i}, mod.omega{i});

end

%% Plot

for i = 1:numTests

    figure();
    hold on;
    
    plot(mod.angle{i}, mod.v{i});
    plot(exp(i).angle, exp(i).v);
    
    % Graph metadata
    title("Modeled vs experimental locomotive crank movement - Test " + voltages(i));
    legend("Model", "Experimental");
    xlabel("\theta (rad)");
    ylabel("Velocity (cm/s)");

end
