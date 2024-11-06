function new_plotter(points, orientations, plot_title, axis_len)
%NEW_PLOTTER is the correct way to plot.

    % Compute positions of each joint
    P0 = points(1:3, 1); % Base position (P)
    P1 = points(1:3, 2); % hip
    P2 = points(1:3, 3); % knee
    P3 = points(1:3, 4); % ankle
    P4 = points(1:3, 5); % toe
    
    O0 = orientations(1:3, 1:3); % orientation of (P)
    O1 = orientations(1:3, 4:6); % orientation of (h)
    O2 = orientations(1:3, 7:9); % orientation of (k) 
    O3 = orientations(1:3, 10:12); % orientation of (a) 
    O4 = orientations(1:3, 13:15); % orientation of (t) 
    
    % Plot the segments
    figure("Color","white");
    plot3([P0(1), P1(1)], [P0(2), P1(2)], [P0(3), P1(3)], 'b', 'LineWidth', 2);
    hold on;
    plot3([P1(1), P2(1)], [P1(2), P2(2)], [P1(3), P2(3)], 'g', 'LineWidth', 2);
    plot3([P2(1), P3(1)], [P2(2), P3(2)], [P2(3), P3(3)], 'r', 'LineWidth', 2);
    plot3([P3(1), P4(1)], [P3(2), P4(2)], [P3(3), P4(3)], 'k', 'LineWidth', 2);

    % Plot joints
    plot3(P0(1), P0(2), P0(3), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    plot3(P1(1), P1(2), P1(3), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    plot3(P2(1), P2(2), P2(3), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    plot3(P3(1), P3(2), P3(3), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    plot3(P4(1), P4(2), P4(3), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');

    % Plot coordinate systems
    % X, Y, Z axis directions
    x0 = axis_len*O0(:, 1); y0 = axis_len*O0(:, 2); z0 = axis_len*O0(:, 3);
    x1 = axis_len*O1(:, 1); y1 = axis_len*O1(:, 2); z1 = axis_len*O1(:, 3);
    x2 = axis_len*O2(:, 1); y2 = axis_len*O2(:, 2); z2 = axis_len*O2(:, 3);
    x3 = axis_len*O3(:, 1); y3 = axis_len*O3(:, 2); z3 = axis_len*O3(:, 3);
    x4 = axis_len*O4(:, 1); y4 = axis_len*O4(:, 2); z4 = axis_len*O4(:, 3);

    % Plot the coordinate axes    
    plot_coordinate_system(P0, x0, y0, z0);
    plot_coordinate_system(P1, x1, y1, z1);
    plot_coordinate_system(P2, x2, y2, z2);
    plot_coordinate_system(P3, x3, y3, z3);
    plot_coordinate_system(P4, x4, y4, z4);    

    % Set plot properties
    grid on;
    axis equal;
    xlabel('X', "Interpreter","latex");
    ylabel('Y', "Interpreter","latex");
    zlabel('Z', "Interpreter","latex");
    title(string(plot_title), "Interpreter","latex");    

end

function plot_coordinate_system(position, x_axis, y_axis, z_axis)
    % Plot the coordinate axes
    quiver3(position(1), position(2), position(3), x_axis(1), x_axis(2), x_axis(3), 'r', 'LineWidth', 1);
    quiver3(position(1), position(2), position(3), y_axis(1), y_axis(2), y_axis(3), 'g', 'LineWidth', 1);
    quiver3(position(1), position(2), position(3), z_axis(1), z_axis(2), z_axis(3), 'b', 'LineWidth', 1);
end

