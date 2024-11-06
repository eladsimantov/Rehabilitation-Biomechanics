function R = euler2rotm_extended(euler_angles, euler_seq, rot_type)
% Enter angles in RAD. 
% who the f*** uses DEG what am I in highschool?
    
% Extract Euler angles
    theta1 = euler_angles(1);
    theta2 = euler_angles(2);
    theta3 = euler_angles(3);

    % Define rotation matrices for basic rotations
    R_x = @(theta) [
        1 0 0; 
        0 cos(theta) -sin(theta);
        0 sin(theta) cos(theta)];
    R_y = @(theta) [
        cos(theta) 0 sin(theta);
        0 1 0;
        -sin(theta) 0 cos(theta)];
    R_z = @(theta) [
        cos(theta) -sin(theta) 0;
        sin(theta) cos(theta) 0;
        0 0 1];
    
    % Determine the order of rotations. 
    % This is so useless but you asked for it.
    % Given for example [t1 t2 t3] and 'ABC':
    % intrinsic would be A(t1)*B(t2)*C(t3)
    % extrinsic would be C(t3)*B(t2)*A(t1)
    switch euler_seq
        case 'XYZ'
            if rot_type == "int"
                R = R_x(theta1) * R_y(theta2) * R_z(theta3);
            elseif rot_type == "ext"
                R = R_z(theta3) * R_y(theta2) * R_x(theta1);
            else 
                error("enter ext or int for rot_type")
            end
        case 'XYX'
            if rot_type == "int"
                R = R_x(theta1) * R_y(theta2) * R_x(theta3);
            elseif rot_type == "ext"
                R = R_x(theta3) * R_y(theta2) * R_x(theta1);
            else 
                error("enter ext or int for rot_type")
            end
        case 'XZY'
            if rot_type == "int"
                R = R_x(theta1) * R_z(theta2) * R_y(theta3);
            elseif rot_type == "ext"
                R = R_y(theta3) * R_z(theta2) * R_x(theta1);
            else 
                error("enter ext or int for rot_type")
            end
        case 'XZX'
            if rot_type == "int"
                R = R_x(theta1) * R_z(theta2) * R_x(theta3);
            elseif rot_type == "ext"
                R = R_x(theta3) * R_z(theta2) * R_x(theta1);
            else 
                error("enter ext or int for rot_type")
            end
        case 'YXZ'
            if rot_type == "int"
                R = R_y(theta1) * R_z(theta2) * R_x(theta3);
            elseif rot_type == "ext"
                R = R_x(theta3) * R_z(theta2) * R_y(theta1);
            else 
                error("enter ext or int for rot_type")
            end    
        case 'YXY'
            if rot_type == "int"
                R = R_y(theta1) * R_x(theta2) * R_y(theta3);
            elseif rot_type == "ext"
                R = R_y(theta3) * R_x(theta2) * R_y(theta1);
            else 
                error("enter ext or int for rot_type")
            end 
        case 'YZX'
            if rot_type == "int"
                R = R_y(theta1) * R_z(theta2) * R_x(theta3);
            elseif rot_type == "ext"
                R = R_x(theta3) * R_z(theta2) * R_y(theta1);
            else 
                error("enter ext or int for rot_type")
            end 
        case 'YZY'
            if rot_type == "int"
                R = R_y(theta1) * R_z(theta2) * R_y(theta3);
            elseif rot_type == "ext"
                R = R_y(theta3) * R_z(theta2) * R_y(theta1);
            else 
                error("enter ext or int for rot_type")
            end         
        case 'ZXY'
            if rot_type == "int"
                R = R_z(theta1) * R_x(theta2) * R_y(theta3);
            elseif rot_type == "ext"
                R = R_y(theta3) * R_x(theta2) * R_z(theta1);
            else 
                error("enter ext or int for rot_type")
            end
        case 'ZXZ'
            if rot_type == "int"
                R = R_z(theta1) * R_x(theta2) * R_z(theta3);
            elseif rot_type == "ext"
                R = R_z(theta3) * R_x(theta2) * R_z(theta1);
            else 
                error("enter ext or int for rot_type")
            end         
        case 'ZYX'
            if rot_type == "int"
                R = R_z(theta1) * R_y(theta2) * R_x(theta3);
            elseif rot_type == "ext"
                R = R_x(theta3) * R_y(theta2) * R_z(theta1);
            else 
                error("enter ext or int for rot_type")
            end 
        case 'ZYZ'
            if rot_type == "int"
                R = R_z(theta1) * R_y(theta2) * R_z(theta3);
            elseif rot_type == "ext"
                R = R_z(theta3) * R_y(theta2) * R_z(theta1);
            else 
                error("enter ext or int for rot_type")
            end 
        otherwise
            error('Use lower case Euler sequences');
    end
end
