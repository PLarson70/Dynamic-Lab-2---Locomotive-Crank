function [theta_exp, omega_exp, v_exp, time] = LCSDATA(filename)
    
    % Note: this is where we stored our data for our repository!
    folderPath = "data_extraction/physical_data";
    
    % Store path to file and read single data
    pathToFile = fullfile(folderPath, filename);
    singleData = readtable(pathToFile, 'Delimiter', '\t', 'ReadVariableNames', true, 'Format', 'auto', 'HeaderLines', 0, 'VariableNamingRule', 'modify');

    % Converting units
    time = singleData.Time_s_ / 1000;                       % s
    v_exp = (singleData.SlideSpeed_mm_s_) / 10;             % cm / s
    omega_exp = deg2rad(singleData.WheelSpeed_deg_s_);      % rad / s
    theta_exp = deg2rad(singleData.WheelPosition_deg_);     % rad
    
    % Removing first number of rotations
    full_rotations = round(theta_exp(1) / (2 * pi));
    theta_exp = theta_exp - (full_rotations * (2 * pi));

    % Limit all arrays to six rotations
    theta_exp_copy = theta_exp;
    
    theta_exp(theta_exp_copy >= (12 * pi)) = [];
    omega_exp(theta_exp_copy >= (12 * pi)) = [];
    time(theta_exp_copy >= (12 * pi)) = [];
    v_exp(theta_exp_copy >= (12 * pi)) = [];

end