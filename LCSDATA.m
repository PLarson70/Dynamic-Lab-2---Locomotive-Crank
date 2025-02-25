function [theta_exp, omega_exp, v_exp, time] = LCSDATA(filename)
    
    % Note: this is where we stored our data for our repository!
    folderPath = "data_extraction/physical_data";
    
    pathToFile = fullfile(folderPath, filename);
    singleData = readtable(pathToFile, 'Delimiter', '\t', 'ReadVariableNames', true, 'Format', 'auto', 'HeaderLines', 0, 'VariableNamingRule', 'modify');

    time = singleData.Time_s_ / 1000;                       % s
    v_exp = (singleData.SlideSpeed_mm_s_) / 10;             % cm / s

    omega_exp = deg2rad(singleData.WheelSpeed_deg_s_);      % rad / s
    omega_exp = omega_exp - mod(omega_exp, 2 * pi);

    theta_exp = deg2rad(singleData.WheelPosition_deg_);     % rad

end