function RANK_VEL = estimate_gait_speed(t_cycle, RANK_X, RANK_Y, RANK_Z)
    dt = t_cycle(2)-t_cycle(1); % it is a fixed space delta t.
    calc_dist = @(x1,y1,z1,x2,y2,z2)(((x2-x1)^2+(y2-y1)^2+(z2-z1)^2)^0.5);
    ds = zeros(100, 1);
    for i=2:100
        ds(i) = calc_dist(RANK_X(i),RANK_Y(i),RANK_Z(i),RANK_X(i-1),RANK_Y(i-1),RANK_Z(i-1));
    end
    RANK_VEL = ds/dt; 
    RANK_VEL(1) = RANK_VEL(2); % so that the speed is not zero.
end
