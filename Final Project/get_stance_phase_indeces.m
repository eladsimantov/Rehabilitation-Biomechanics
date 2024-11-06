function [stance_phase_start, stance_phase_end, start_end_indeces] = get_stance_phase_indeces(forces, threshold, window)
    stance_phase_start = zeros(length(forces), 1);
    stance_phase_end = zeros(length(forces), 1);
    start_end_indeces = [0, 0];
    env = @(data,window)(sqrt(movmean(data.^2, window))); % RMS moving average envelope to filter out rapid changes
    forces = env(forces, window);
    cycle_cnt = 0; % this will make sure that there will not be an end without a start
    for i=2:length(forces)-1
        now_high = forces(i) >= threshold;
        prev_low = forces(i-1) < threshold;
        now_low = forces(i) < threshold;
        prev_high = forces(i-1) >= threshold;
        if now_high && prev_low 
            stance_phase_start(i) = 1;
            cycle_cnt = cycle_cnt + 1;
            start_end_indeces(cycle_cnt, 1) = i;
        elseif now_low && prev_high && cycle_cnt > 0
            stance_phase_end(i) = 1;
            start_end_indeces(cycle_cnt, 2) = i;
        end
    end
    % Make sure there are not more starts than ends
    if sum(stance_phase_start) > sum(stance_phase_end)
        stance_phase_start(start_end_indeces(end, 1)) = 0; % reset the last start that has no end
    end
    if start_end_indeces(end, 2) == 0
        start_end_indeces = start_end_indeces(1:end-1, :); % remove the last start that has no end from the indeces table
    end
end
