function [pos_rot,coo_sys_rot] = trans_vec(rot_angles, rot_type, seg_vec, seg_len)
% TRANS_VEC 
% -------- inputs ------
% rot_angles - Rotation angles vector 6x1 (hip=3x1, knee=1x1, ankle=2x1)
% rot_type - intrinsic / extrinsic rotations ("int" or "ext")
% seg_vec - segment vectors with respect to their frame (hip, knee, ankle)
% seg_len - segment lengths (pelvis, thigh, shank, foot)
% ------- output -------
% pos_rot - rotated joints positions (d_P, d_hip, d_knee, d_ankle, d_toes) w.r.t (P)
% coo_sys_tor - rotated joint frames (R_P, R_hip, R_knee, R_ankle, R_toes) w.r.t (P)

% compute rotation matrices
R_hip = euler2rotm_extended(rot_angles(1:3, 1), "XYZ", rot_type);
R_knee = euler2rotm_extended( ...
    [rot_angles(4, 1); 0; 0], "XYZ", rot_type);
R_ankle = euler2rotm_extended([rot_angles(5, 1); rot_angles(5, 1); 0], "XYZ", rot_type);

% get segment lengths
L_pelvis=seg_len(1); L_thigh=seg_len(2); L_shank=seg_len(3); L_foot=seg_len(4);

% get segment directions (ROW VECTORS)
v_pelvis=seg_vec(2,:); v_thigh=seg_vec(3,:); v_shank=seg_vec(4,:); v_foot=seg_vec(5,:);

% calc segment directions
v_pelvis = v_pelvis'; % from now on COLUMN vectors
v_thigh = R_hip*v_thigh'; 
v_shank = R_hip*R_knee*v_shank';
v_foot = R_hip*R_knee*R_ankle*v_foot';

d_P = seg_vec(1,:)'; % base position
d_hip = d_P + L_pelvis * v_pelvis; % position of (h) w.r.t (P)
d_knee = d_hip + L_thigh * v_thigh; % position of (k) w.r.t (P)
d_ankle = d_knee + L_shank * v_shank; % position of (s) w.r.t (P)
d_toe = d_ankle + L_foot * v_foot; % position of (toe) w.r.t (P)

pos_rot = [d_P d_hip d_knee d_ankle d_toe]; % 3x5 matrix 
coo_sys_rot = [eye(3,3) R_hip R_hip*R_knee R_hip*R_knee*R_ankle R_hip*R_knee*R_ankle]; % 3*15 matrix

end
