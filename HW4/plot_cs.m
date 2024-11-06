function plot_cs(position, x_axis, y_axis, z_axis)
    % Plot the coordinate axes
    quiver3(position(1), position(2), position(3), x_axis(1), x_axis(2), x_axis(3), 'r', 'LineWidth', 1);
    quiver3(position(1), position(2), position(3), y_axis(1), y_axis(2), y_axis(3), 'g', 'LineWidth', 1);
    quiver3(position(1), position(2), position(3), z_axis(1), z_axis(2), z_axis(3), 'b', 'LineWidth', 1);
end