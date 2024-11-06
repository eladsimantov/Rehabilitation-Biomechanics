function [t_cycles, data_cycles, n_cycles] = interp_split_gait(t, data, t_FS, TOL)
% This function splits data into gait cycles according to FS2FS event.
% Then it interpolates each splitted data into 100 equally spaced points
% and returnes all of the samples.
    % find out indeces of FS according to given TOL
    [~, idxFS] = ismembertol(t_FS, t, TOL);
    gait_cycles_idx = arrayfun(@(i) idxFS(i:i+1), 1:length(idxFS)-1, 'UniformOutput', false);
    % loop over all gait cycles to interpolate each one
    t_cycles = zeros(100, length(gait_cycles_idx));
    data_cycles = zeros(100, length(gait_cycles_idx));
    n_cycles = length(gait_cycles_idx);
    for cycle=1:n_cycles
        indeces = gait_cycles_idx{cycle}; % get the start and end index
        t_cycle = linspace(t(indeces(1)), t(indeces(2)), 100); % create 100 t values for gait cycle
        t_cycles(:, cycle) = t_cycle;
        data_cycles(:, cycle) = interp1(t, data, t_cycle, 'linear');
    end

end
