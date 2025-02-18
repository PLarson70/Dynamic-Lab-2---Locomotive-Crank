%% clear the shit

clear; clc; close all;

%% Import Data

folderPath = "physical_data";

files = dir(fullfile(folderPath, '*'));
data = struct();

for i = 1 : length(files)
    try
        loop.name = files(i).name;
        loop.filepath = fullfile(folderPath, loop.name);
        loop.data = readtable(loop.filepath, 'Delimiter', '\t', 'ReadVariableNames', true, 'Format', 'auto', 'HeaderLines', 0);

        varName = matlab.lang.makeValidName(loop.name(1:end-4));

        data.(varName) = loop.data;

    catch

    end
end

clear files folderPath i loop varName;
save('data');