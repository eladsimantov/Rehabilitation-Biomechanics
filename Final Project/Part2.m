clearvars; close all; clc;
GAIT_DATA_FOLDER = "C:\Users\Elad\MATLAB Drive\Biomechanics\Final Project\Data - VICON and EMG\";
LEFT_COLOR = [0.6350 0.0780 0.1840]; % RED for Left limbs 
RIGHT_COLOR = [0.4660 0.6740 0.1880]; % GREEN for Right limbs

% Load files data into objects
BF_normal_1_away = gait_preprocess(GAIT_DATA_FOLDER + "BF_normal_1_away.csv", ...
    [4,24], [31, 11568], [11575, 12215], [12222, 12862]);
BF_normal_2_toward = gait_preprocess(GAIT_DATA_FOLDER + "BF_normal_2_toward.csv", ...
    [4, 19], [30, 11225], [11232, 11853], [11860, 12481]);
BF_normal_3_away = gait_preprocess(GAIT_DATA_FOLDER + "BF_normal_3_away.csv", ...
    [4, 20], [27, 9764], [9771, 10311], [10318, 10858]);
BF_normal_4_toward = gait_preprocess(GAIT_DATA_FOLDER + "BF_normal_4_toward.csv", ...
    [4, 23], [30, 11315], [11322, 11948], [11955, 12581]);
Heels_normal_1_away = gait_preprocess(GAIT_DATA_FOLDER + "Heels_normal_1_away.csv", ...
    [4,17], [24, 7763], [7770, 8199], [8206, 8635]);
Heels_normal_2_toward = gait_preprocess(GAIT_DATA_FOLDER + "Heels_normal_2_toward.csv", ...
    [4, 19], [26, 9133], [9140, 9645], [9652, 10157]);
Heels_normal_3_away = gait_preprocess(GAIT_DATA_FOLDER + "Heels_normal_3_away.csv", ...
    [4, 17], [24, 7565], [7572, 7990], [7997, 8415]);
Heels_normal_4_toward = gait_preprocess(GAIT_DATA_FOLDER + "Heels_normal_4_toward.csv", ...
    [4, 19], [26, 8845], [8852, 9341], [9348, 9837]);

Trials = [
    BF_normal_1_away; BF_normal_2_toward; BF_normal_3_away; BF_normal_4_toward; 
    Heels_normal_1_away; Heels_normal_2_toward; Heels_normal_3_away; Heels_normal_4_toward];
clearvars('-except', "Trials", "LEFT_COLOR", "RIGHT_COLOR")

%% Load EMG data
close all; clc;
% ------------------------- INPUTS ------------- %
fs          =       2160; 
fcuthpf     =       10; 
fcutlpf     =       200; 
window      =       50;
idx2title    =      ["BF 1"; "BF 2"; "BF 3"; "BF 4"; "Heels 1"; "Heels 2"; "Heels 3"; "Heels 4"];
% ---------------------------------------------- %
for idx=1:8
    trial = Trials(idx);
    devices_t = trial.get_devices_timevec(2160);

    % EMG1
    EMG1 = table2array(trial.Devices_Table(:, "EMG1"));
    [EMG1_rect, EMG1_env] = sEMG_signal_processing(EMG1, fs, fcutlpf, fcuthpf, 3, window, false);
    
    newfigure(idx2title(idx)+" EMG1 Data", "time [s]", "EMG Signal [V]")
    plot(devices_t, EMG1, "DisplayName", "Raw")
    plot(devices_t, EMG1_rect, "DisplayName","Rect")
    area(devices_t, EMG1_env,"DisplayName","Env","FaceAlpha",0.3)
    xlim([devices_t(1), devices_t(end)])
    % Show Gait events
    xline(trial.left_FS, "Color",LEFT_COLOR, "LineStyle","-", "HandleVisibility", "off")
    xline(trial.right_FS, "Color",RIGHT_COLOR, "LineStyle","-", "HandleVisibility", "off")
    xline(trial.left_FO, "Color",LEFT_COLOR, "LineStyle","--", "HandleVisibility", "off")
    xline(trial.right_FO, "Color",RIGHT_COLOR, "LineStyle","--", "HandleVisibility", "off")
    set(gcf, 'Position',  [100, 100, 1200, 300])
    legend("Location","eastoutside")
    
    % EMG2
    EMG2 = table2array(trial.Devices_Table(:, "EMG5"));
    [EMG2_rect, EMG2_env] = sEMG_signal_processing(EMG2, fs, fcutlpf, fcuthpf, 4, window, false);

    newfigure(idx2title(idx)+" EMG2 Data", "time [s]", "sEMG Signal [V]")
    plot(devices_t, EMG2, "DisplayName", "Raw")
    plot(devices_t, EMG2_rect, "DisplayName","Rect")
    area(devices_t, EMG2_env,"DisplayName","Env","FaceAlpha",0.3)
    xlim([devices_t(1), devices_t(end)])
    % Show Gait events
    xline(trial.left_FS, "Color",LEFT_COLOR, "LineStyle","-", "HandleVisibility", "off")
    xline(trial.right_FS, "Color",RIGHT_COLOR, "LineStyle","-", "HandleVisibility", "off")
    xline(trial.left_FO, "Color",LEFT_COLOR, "LineStyle","--", "HandleVisibility", "off")
    xline(trial.right_FO, "Color",RIGHT_COLOR, "LineStyle","--", "HandleVisibility", "off")
    set(gcf, 'Position',  [100, 100, 1200, 300])
    legend("Location","eastoutside")
end

% for i=1:16
% saveas(i, string(i)+".png")
% end
