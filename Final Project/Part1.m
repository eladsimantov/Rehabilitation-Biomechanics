clearvars; close all; clc;
% -------------- INPUTS -------------- %
% GAIT_DATA_FOLDER = "/MATLAB Drive/Biomechanics Final Project/Data - VICON and EMG/";
GAIT_DATA_FOLDER = "C:\Users\Elad\MATLAB Drive\Biomechanics\Final Project\Data - VICON and EMG\";
LEFT_COLOR = [0.6350 0.0780 0.1840]; % RED for Left limbs 
RIGHT_COLOR = [0.4660 0.6740 0.1880]; % GREEN for Right limbs

BF_normal_1_away = gait_preprocess(GAIT_DATA_FOLDER + "BF_normal_1_away.csv", ...
    [4,24], [31, 11568], [11575, 12215], [12222, 12862]);
BF_normal_2_toward = gait_preprocess(GAIT_DATA_FOLDER + "BF_normal_2_toward.csv", ...
    [4, 19], [30, 11225], [11232, 11853], [11860, 12481]);
BF_normal_3_away = gait_preprocess(GAIT_DATA_FOLDER + "BF_normal_3_away.csv", ...
    [4, 20], [27, 9764], [9771, 10311], [10318, 10858]);
BF_normal_4_toward = gait_preprocess(GAIT_DATA_FOLDER + "BF_normal_4_toward.csv", ...
    [4, 23], [30, 11315], [11322, 11948], [11955, 12581]);

trials = [BF_normal_1_away, BF_normal_2_toward, BF_normal_3_away, BF_normal_4_toward];
clearvars("BF_normal_1_away", "BF_normal_2_toward", "BF_normal_3_away", "BF_normal_4_toward")
%% (a) Loop over four trials
close all;
for idx = 1:4
    trial = trials(idx);
    % (i) normalize the time vector per table
    devices_t = trial.get_devices_timevec(2160);

    % (ii) plot raw Z-axis force plate data w/ points of gait events marked
    % (x) for FS and (o) for FO 
    % BF normal 1 away	    L	R
    % BF normal 2 toward	R	L
    % BF normal 3 away	    R	L
    % BF normal 4 toward	L	R
    left_Z_Force = table2array(trial.Devices_Table(:, "Fz"));
    right_Z_Force = table2array(trial.Devices_Table(:, "Fz1"));     
    FP_LR_TOGGLE = [0; 1; 1; 0]; % WHY WASTE MY TIME ON THIS CRAP GOD DAMNIT.
    if FP_LR_TOGGLE(idx) == 1
        right_Z_Force = table2array(trial.Devices_Table(:, "Fz"));
        left_Z_Force = table2array(trial.Devices_Table(:, "Fz1"));     
    end
    newfigure("Trial " + idx + " Raw Z-axis FP with Gait events", "time [s]", "Force [N]")
    plot(devices_t, left_Z_Force, "DisplayName", "L", "Color", LEFT_COLOR)
    plot(devices_t, right_Z_Force, "DisplayName", "R", "Color", RIGHT_COLOR)
    % show events on plot
    scatter(trial.left_FS, ...
        left_Z_Force( ...
        ismembertol(trial.left_FS, devices_t, 1e-4)), ...
        "MarkerEdgeColor", LEFT_COLOR, "MarkerFaceColor", LEFT_COLOR, ...
        "Marker", 'x', "HandleVisibility", "off");
    scatter(trial.left_FO, ...
        left_Z_Force( ...
        ismembertol(trial.left_FO, devices_t, 1e-4)), ...
        "MarkerEdgeColor", LEFT_COLOR,  ...
        "Marker", 'o', "HandleVisibility", "off");
    scatter(trial.right_FS, ...
        right_Z_Force( ...
        ismembertol(trial.right_FS, devices_t, 1e-4)), ...
        "MarkerEdgeColor", RIGHT_COLOR, "MarkerFaceColor", RIGHT_COLOR, ...
        "Marker", 'x', "HandleVisibility", "off");
    scatter(trial.right_FO, ...
        right_Z_Force( ...
        ismembertol(trial.right_FO, devices_t, 1e-4)), ...
        "MarkerEdgeColor", RIGHT_COLOR,  ...
        "Marker", 'o', "HandleVisibility", "off");
end
clearvars("idx", "right_Z_Force", "left_Z_Force", "trial")
% for i=1:4
% saveas(i, string(i)+".png")
% end

%% (b)
% Split data into gait cycles according to FS2FS.
% take the model table and loop over all four experiments
TOL = 1e-3;
close all;
for idx = 1:4
    trial = trials(idx);
    model_t = trial.get_model_timevec(120);

    % Left Pelvis angles = X17 Y17 Z17, 3 plots
    [~,data_cycles,n_cycles] = interp_split_gait(model_t, trial.Model_Table.X17, trial.left_FS, TOL);
    newfigure("Left Pelvis FE Trial "+ idx + " Avg " + n_cycles + " Cycles", "Gait Cycle [\%]", "Angle [deg]")
    errorbar(1:1:100, mean(data_cycles, 2), std(data_cycles, 0, 2), 'x', 'Color', LEFT_COLOR);  % Plot Gait Cycle with error bars
    legend('hide')

    [~,data_cycles,n_cycles] = interp_split_gait(model_t, trial.Model_Table.Y17, trial.left_FS, TOL);
    newfigure("Left Pelvis AA Trial "+ idx + " Avg " + n_cycles + " Cycles", "Gait Cycle [\%]", "Angle [deg]")
    errorbar(1:1:100, mean(data_cycles, 2), std(data_cycles, 0, 2), 'x', 'Color', LEFT_COLOR);  % Plot Gait Cycle with error bars
    legend('hide')

    [~,data_cycles,n_cycles] = interp_split_gait(model_t, trial.Model_Table.Z17, trial.left_FS, TOL);
    newfigure("Left Pelvis IER Trial "+ idx + " Avg " + n_cycles + " Cycles", "Gait Cycle [\%]", "Angle [deg]")
    errorbar(1:1:100, mean(data_cycles, 2), std(data_cycles, 0, 2), 'x', 'Color', LEFT_COLOR);  % Plot Gait Cycle with error bars
    legend('hide')

    % Right Pelvis angles = X35 Y35 Z35, 3 plots
    [~,data_cycles,n_cycles] = interp_split_gait(model_t, trial.Model_Table.X35, trial.right_FS, TOL);
    newfigure("Right Pelvis FE Trial "+ idx + " Avg " + n_cycles + " Cycles", "Gait Cycle [\%]", "Angle [deg]")
    errorbar(1:1:100, mean(data_cycles, 2), std(data_cycles, 0, 2), 'x', 'Color', RIGHT_COLOR);  % Plot Gait Cycle with error bars
    legend('hide')
    
    [~,data_cycles,n_cycles] = interp_split_gait(model_t, trial.Model_Table.Y35, trial.right_FS, TOL);
    newfigure("Right Pelvis AA Trial "+ idx + " Avg " + n_cycles + " Cycles", "Gait Cycle [\%]", "Angle [deg]")
    errorbar(1:1:100, mean(data_cycles, 2), std(data_cycles, 0, 2), 'x', 'Color', RIGHT_COLOR);  % Plot Gait Cycle with error bars
    legend('hide')
    
    [~,data_cycles,n_cycles] = interp_split_gait(model_t, trial.Model_Table.Z35, trial.right_FS, TOL);
    newfigure("Right Pelvis IER Trial "+ idx + " Avg " + n_cycles + " Cycles", "Gait Cycle [\%]", "Angle [deg]")
    errorbar(1:1:100, mean(data_cycles, 2), std(data_cycles, 0, 2), 'x', 'Color', RIGHT_COLOR);  % Plot Gait Cycle with error bars
    legend('hide')
end
clearvars("idx", "data_cycles", "n_cycles", "trial")

% for i=1:24
% saveas(i, string(i)+".png")
% end

%% Ground Reaction Forces (GRF)
close all; clc;
clearvars('-except', "GAIT_DATA_FOLDER", "RIGHT_COLOR", "LEFT_COLOR", "trials")
% All normal speed data for both BF and Heels ONLY right leg.
% BF normal 1 away	    L	R
% BF normal 2 toward	R	L
% BF normal 3 away	    R	L
% BF normal 4 toward	L	R
% Heels normal 1 away	L	R
% Heels normal 2 toward	R	L
% Heels normal 3 away	L	R
% Heels normal 4 toward	R	L
FP_LR_TOGGLE = [0; 1; 1; 0; 0; 1; 0; 1]; % this says if it is LR or RL order.

% Load all Heels normal trials
Heels_normal_1_away = gait_preprocess(GAIT_DATA_FOLDER + "Heels_normal_1_away.csv", ...
    [4,17], [24, 7763], [7770, 8199], [8206, 8635]);
Heels_normal_2_toward = gait_preprocess(GAIT_DATA_FOLDER + "Heels_normal_2_toward.csv", ...
    [4, 19], [26, 9133], [9140, 9645], [9652, 10157]);
Heels_normal_3_away = gait_preprocess(GAIT_DATA_FOLDER + "Heels_normal_3_away.csv", ...
    [4, 17], [24, 7565], [7572, 7990], [7997, 8415]);
Heels_normal_4_toward = gait_preprocess(GAIT_DATA_FOLDER + "Heels_normal_4_toward.csv", ...
    [4, 19], [26, 8845], [8852, 9341], [9348, 9837]);

trials(1,5:8) = [Heels_normal_1_away, Heels_normal_2_toward, Heels_normal_3_away, Heels_normal_4_toward];
clearvars("Heels_normal_1_away", "Heels_normal_2_toward", "Heels_normal_3_away", "Heels_normal_4_toward")


% Get access to right leg only for all trials
for idx=1:8
    trial = trials(idx);
    devices_t = trial.get_devices_timevec(2160);
    
    % Access GRF data for right side only
    right_X_Force = table2array(trial.Devices_Table(:, "Fx1"));     
    if FP_LR_TOGGLE(idx) == 1
        right_X_Force = table2array(trial.Devices_Table(:, "Fx"));
    end
    right_Y_Force = table2array(trial.Devices_Table(:, "Fy1"));     
    if FP_LR_TOGGLE(idx) == 1
        right_Y_Force = table2array(trial.Devices_Table(:, "Fy"));
    end
    right_Z_Force = table2array(trial.Devices_Table(:, "Fz1"));     
    if FP_LR_TOGGLE(idx) == 1
        right_Z_Force = table2array(trial.Devices_Table(:, "Fz"));
    end
    GRF_MAG = @(a,b,c)((a.^2+b.^2+c.^2).^0.5);
    Total_GRF = GRF_MAG(right_X_Force, right_Y_Force, right_Z_Force);
    idx_to_disp = ["BF 1", "BF 2", "BF 3", "BF 4", "Heels 1", "Heels 2", "Heels 3", "Heels 4"];
    newfigure(string(idx_to_disp(idx)) + " Right Total GRF", "time [s]", "Force [N]")
    plot(devices_t, Total_GRF, "Color", RIGHT_COLOR)
    legend("off")
end

% for i=1:8
% saveas(i, string(i)+".png")
% end

%% Estimation of spatiotemporal parameters
close all; clc;
clearvars('-except', "GAIT_DATA_FOLDER", "RIGHT_COLOR", "LEFT_COLOR", "trials")
BF_fast_1_toward = gait_preprocess(GAIT_DATA_FOLDER + "BF_fast_1_toward.csv", ...
    [4,19], [26, 8323], [8330, 8790], [8797, 9257]);
BF_fast_2_away = gait_preprocess(GAIT_DATA_FOLDER + "BF_fast_2_away.csv", ...
    [4, 17], [24, 6827], [6835, 7211], [7218, 7595]);
BF_fast_3_away = gait_preprocess(GAIT_DATA_FOLDER + "BF_fast_3_away.csv", ...
    [4, 17], [24, 6791], [6798, 7173], [7180, 7555]);
BF_fast_4_toward = gait_preprocess(GAIT_DATA_FOLDER + "BF_fast_4_toward.csv", ...
    [4, 19], [26, 7243], [7250, 7650], [7657, 8057]);
Heels_slow_1_away = gait_preprocess(GAIT_DATA_FOLDER + "Heels_slow_1_away.csv", ...
    [4,19], [26, 9781], [9788, 10329], [10336, 10877]);
Heels_slow_2_toward = gait_preprocess(GAIT_DATA_FOLDER + "Heels_slow_2_toward.csv", ...
    [4, 21], [28, 11151], [11158, 11775], [11782, 12399]);
Heels_slow_3_away = gait_preprocess(GAIT_DATA_FOLDER + "Heels_slow_3_away.csv", ...
    [4, 19], [26, 9565], [9572, 10101], [10108, 10637]);
Heels_slow_4_toward = gait_preprocess(GAIT_DATA_FOLDER + "Heels_slow_4_toward.csv", ...
    [4, 21], [28, 10647], [10654, 11243], [11250, 11839]);
ALL_TRIALS(1, 1:4) = [BF_fast_1_toward, BF_fast_2_away, BF_fast_3_away, BF_fast_4_toward];
ALL_TRIALS(1, 5:12) = trials;
ALL_TRIALS(1, 13:16) = [Heels_slow_1_away, Heels_slow_2_toward, Heels_slow_3_away, Heels_slow_4_toward];
TOL = 1e-3;
RANK_vel = zeros(16, 5);
for idx = 1:16
    trial = ALL_TRIALS(idx);
    devices_t = trial.get_devices_timevec(2160);
    model_t = trial.get_traj_timevec(120);

    % Get only right leg data - interpolate and make gait cycle
    [tx_cycle,RANK_X,nx_cycles] = interp_split_gait(model_t, trial.Trajectories_Table.X13, trial.right_FS, TOL);
    [ty_cycle,RANK_Y,ny_cycles] = interp_split_gait(model_t, trial.Trajectories_Table.Y13, trial.right_FS, TOL);
    [tz_cycle,RANK_Z,nz_cycles] = interp_split_gait(model_t, trial.Trajectories_Table.Z13, trial.right_FS, TOL);
    for cycle=1:nz_cycles
        % convert to m/s by div by 1000
        RANK_vel(idx, cycle) = mean(estimate_gait_speed(tz_cycle, RANK_X(:, cycle), RANK_Y(:, cycle), RANK_Z(:, cycle)))/1000;
    end
end
AVG_RANK_vel = mean(RANK_vel, 2); 

clearvars('-except', "RANK_vel", "ALL_TRIALS", "GAIT_DATA_FOLDER", "AVG_RANK_vel", "RIGHT_COLOR", "LEFT_COLOR")

