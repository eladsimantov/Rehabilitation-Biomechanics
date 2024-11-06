clearvars; close all; clc;
%% Question 1
% There are 4 segments - (pelvis), (thigh), (shank) and (foot).
% There are 3 joints - (hip) Spherical, (knee) Revolute and (ankle) Cardan. 

%% Question 2 - 5
lengths = [0.3,1,1,0.3]; % [pelvis, thigh, shank, foot]
% Directions of segments with respect to their frame
directions = [
    0, 0, 2; % pelvis frame (P) initial position (P)
    1, 0, 0; % pelvis direction w.r.t xyz frame (P)
    0, 0, -1; % thigh direction w.r.t xyz frame (P)
    0, 0, -1; % shank direction w.r.t xyz frame (P)
    0, 1, 0 % foot direction w.r.t xyz frame
];

% leg_plotter(lengths, directions, true) 

%% Question 6 - 11
% standing
[pos_rot,coo_sys_rot] = trans_vec([0;0;0;0;0;0], "int", directions, lengths);
new_plotter(pos_rot, coo_sys_rot, "Standing", 0.1)

% sitting
[pos_rot,coo_sys_rot] = trans_vec([pi/2;0;0;-pi/2;0;0], "int", directions, lengths);
new_plotter(pos_rot, coo_sys_rot, "Sitting", 0.1)

% butterfly
[pos_rot,coo_sys_rot] = trans_vec([pi/2;-pi/2;-pi/2;-0.9*pi;0;0], "int", directions, lengths);
new_plotter(pos_rot, coo_sys_rot, "Butterfly", 0.1)

% Squat
[pos_rot,coo_sys_rot] = trans_vec([pi/2;-deg2rad(20);0;-pi/2-0.3;0.3;0], "int", directions, lengths);
new_plotter(pos_rot, coo_sys_rot, "Squat", 0.1)

%% Extrinsic rotations
% standing
[pos_rot,coo_sys_rot] = trans_vec([0;0;0;0;0;0], "ext", directions, lengths);
new_plotter(pos_rot, coo_sys_rot, "Standing", 0.1)

% sitting
[pos_rot,coo_sys_rot] = trans_vec([pi/2;0;0;-pi/2;0;0], "ext", directions, lengths);
new_plotter(pos_rot, coo_sys_rot, "Sitting", 0.1)

% butterfly
[pos_rot,coo_sys_rot] = trans_vec([pi/2;-pi/2;-pi/2;-0.9*pi;0;0], "ext", directions, lengths);
new_plotter(pos_rot, coo_sys_rot, "Butterfly", 0.1)

% Squat
[pos_rot,coo_sys_rot] = trans_vec([pi/2;-deg2rad(20);0;-pi/2-0.3;0.3;0], "ext", directions, lengths);
new_plotter(pos_rot, coo_sys_rot, "Squat", 0.1)

