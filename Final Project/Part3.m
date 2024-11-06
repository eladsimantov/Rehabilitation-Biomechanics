clearvars; close all; clc;

PEDAR_DATA_FOLDER = "C:\Users\Elad\MATLAB Drive\Biomechanics\Final Project\Data - Pedar\";
LEFT_COLOR = [0.6350 0.0780 0.1840]; % RED for Left limbs 
RIGHT_COLOR = [0.4660 0.6740 0.1880]; % GREEN for Right limbs

% Load tables
Sandals_fast_1_table = readtable(PEDAR_DATA_FOLDER+"Sandals_fast_1.xlsx","NumHeaderLines",7,"FileType","spreadsheet", 'VariableNamingRule','preserve');
Sandals_fast_2_table = readtable(PEDAR_DATA_FOLDER+"Sandals_fast_2.xlsx","NumHeaderLines",7,"FileType","spreadsheet", 'VariableNamingRule','preserve');
Sandals_slow_1_table = readtable(PEDAR_DATA_FOLDER+"Sandals_slow_1.xlsx","NumHeaderLines",7,"FileType","spreadsheet", 'VariableNamingRule','preserve');
Sandals_slow_2_table = readtable(PEDAR_DATA_FOLDER+"Sandals_slow_2.xlsx","NumHeaderLines",7,"FileType","spreadsheet", 'VariableNamingRule','preserve');

% Rename columns
Sandals_fast_1_table = renamevars(Sandals_fast_1_table, ["time[secs]","force[N]","x[mm]","y[mm]","Var5","force[N]_1","x[mm]_1","y[mm]_1"],["time","Lforce","Lx","Ly","Var5","Rforce","Rx","Ry"]);
Sandals_fast_2_table = renamevars(Sandals_fast_2_table, ["time[secs]","force[N]","x[mm]","y[mm]","Var5","force[N]_1","x[mm]_1","y[mm]_1"],["time","Lforce","Lx","Ly","Var5","Rforce","Rx","Ry"]);
Sandals_slow_1_table = renamevars(Sandals_slow_1_table, ["time[secs]","force[N]","x[mm]","y[mm]","Var5","force[N]_1","x[mm]_1","y[mm]_1"],["time","Lforce","Lx","Ly","Var5","Rforce","Rx","Ry"]);
Sandals_slow_2_table = renamevars(Sandals_slow_2_table, ["time[secs]","force[N]","x[mm]","y[mm]","Var5","force[N]_1","x[mm]_1","y[mm]_1"],["time","Lforce","Lx","Ly","Var5","Rforce","Rx","Ry"]);

%% Q1
fs = 1/(Sandals_fast_1_table.time(2) - Sandals_fast_1_table.time(1))

%% Q2 
clc; close all;
% search for indeces where the GRF changes from low to high and is
% or from high to low. Then add to table the start and end of stance phase indeces
lowthreshold = 100; % some parameter for the threshold of a low value
window = 10; % a window for an RMS envelope to filter out rapid changes

[Sandals_fast_1_table.SP_start, Sandals_fast_1_table.SP_end, fast_1_start_end] = get_stance_phase_indeces(Sandals_fast_1_table.Rforce, lowthreshold, window);
[Sandals_fast_2_table.SP_start, Sandals_fast_2_table.SP_end, fast_2_start_end] = get_stance_phase_indeces(Sandals_fast_2_table.Rforce, lowthreshold, window);
[Sandals_slow_1_table.SP_start, Sandals_slow_1_table.SP_end, slow_1_start_end] = get_stance_phase_indeces(Sandals_slow_1_table.Rforce, lowthreshold, window);
[Sandals_slow_2_table.SP_start, Sandals_slow_2_table.SP_end, slow_2_start_end] = get_stance_phase_indeces(Sandals_slow_2_table.Rforce, lowthreshold, window);

% Plot forces for all trials for Right foot only
newfigure("Fast 1 Right GRFs over time","time [s]", "Force [N]"); legend('off')
plot(Sandals_fast_1_table.time, Sandals_fast_1_table.Rforce, Color=RIGHT_COLOR, DisplayName="Right")
xline(Sandals_fast_1_table.time.*Sandals_fast_1_table.SP_start, "-")
xline(Sandals_fast_1_table.time.*Sandals_fast_1_table.SP_end,"--")

newfigure("Fast 2 Right GRFs over time","time [s]", "Force [N]"); legend('off')
plot(Sandals_fast_2_table.time, Sandals_fast_2_table.Rforce, Color=RIGHT_COLOR, DisplayName="Right")
xline(Sandals_fast_2_table.time.*Sandals_fast_2_table.SP_start, "-")
xline(Sandals_fast_2_table.time.*Sandals_fast_2_table.SP_end,"--")

newfigure("Slow 1 Right GRFs over time","time [s]", "Force [N]"); legend('off')
plot(Sandals_slow_1_table.time, Sandals_slow_1_table.Rforce, Color=RIGHT_COLOR, DisplayName="Right")
xline(Sandals_slow_1_table.time.*Sandals_slow_1_table.SP_start, "-")
xline(Sandals_slow_1_table.time.*Sandals_slow_1_table.SP_end,"--")

newfigure("Slow 2 Right GRFs over time","time [s]", "Force [N]"); legend('off')
plot(Sandals_slow_2_table.time, Sandals_slow_2_table.Rforce, Color=RIGHT_COLOR, DisplayName="Right")
xline(Sandals_slow_2_table.time.*Sandals_slow_2_table.SP_start, "-")
xline(Sandals_slow_2_table.time.*Sandals_slow_2_table.SP_end,"--")

% for i=1:4
% saveas(i, string(i)+".png")
% end

%% Q4 Plot COPx vs. COPy
close all; clc; clearvars("window", "LEFT_COLOR", "lowthreshold", "PEDAR_DATA_FOLDER")

[f1SP, ~] = size(fast_1_start_end);
[f2SP, ~] = size(fast_2_start_end);
[s1SP, ~] = size(slow_1_start_end);
[s2SP, ~] = size(slow_2_start_end);

% Loop over all stance phases
newfigure("Fast 1 Right COPx vs COPy", "COPx [mm]", "COPy [mm]")
for i=1:f1SP
    idx_to_use = fast_1_start_end(i, 1):fast_1_start_end(i, 2);
    plot(Sandals_fast_1_table.Rx(idx_to_use), Sandals_fast_1_table.Ry(idx_to_use), DisplayName="SP"+i)
end
xlim([20, 80])

% Loop over all stance phases
newfigure("Fast 2 Right COPx vs COPy", "COPx [mm]", "COPy [mm]")
for i=1:f2SP
    idx_to_use = fast_2_start_end(i, 1):fast_2_start_end(i, 2);
    plot(Sandals_fast_2_table.Rx(idx_to_use), Sandals_fast_2_table.Ry(idx_to_use), DisplayName="SP"+i)
end
xlim([20, 80])

% Loop over all stance phases
newfigure("Slow 1 Right COPx vs COPy", "COPx [mm]", "COPy [mm]")
for i=1:s1SP
    idx_to_use = slow_1_start_end(i, 1):slow_1_start_end(i, 2);
    plot(Sandals_slow_1_table.Rx(idx_to_use), Sandals_slow_1_table.Ry(idx_to_use), DisplayName="SP"+i)
end
xlim([20, 80])

% Loop over all stance phases
newfigure("Slow 2 Right COPx vs COPy", "COPx [mm]", "COPy [mm]")
for i=1:s2SP
    idx_to_use = slow_2_start_end(i, 1):slow_2_start_end(i, 2);
    plot(Sandals_slow_2_table.Rx(idx_to_use), Sandals_slow_2_table.Ry(idx_to_use), DisplayName="SP"+i)
end
xlim([20, 80])


% for i=1:4
% saveas(i, string(i)+".png")
% end