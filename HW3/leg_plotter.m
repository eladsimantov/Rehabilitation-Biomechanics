function leg_plotter(lengths, directions, include_coords)
    % Lengths of the segments
    L1 = lengths(1);
    L2 = lengths(2);
    L3 = lengths(3);
    L4 = lengths(4);

    % Compute positions of each joint
    P0 = transpose(directions(1,1:3)); % Base position
    P1 = P0 + L1 * transpose(directions(2,1:3));
    P2 = P1 + L2 * transpose(directions(3,1:3));
    P3 = P2 + L3 * transpose(directions(4,1:3));
    P4 = P3 + L4 * transpose(directions(5,1:3));
    
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

    if include_coords
        % Plot coordinate systems
        plot_coordinate_system(P0);
        plot_coordinate_system(P1);
        plot_coordinate_system(P2);
        plot_coordinate_system(P3);    
    end
   

    % Set plot properties
    grid on;
    axis equal;
    xlabel('X', "Interpreter","latex");
    ylabel('Y', "Interpreter","latex");
    zlabel('Z', "Interpreter","latex");
    title('Standing', "Interpreter","latex");
    


    % % Add segment labels around their centers
    % text(mean([P0(1), P1(1)]), mean([P0(2), P1(2)])+0.1, mean([P0(3), P1(3)]), '(P)', 'Interpreter', 'latex', 'FontSize', 12);
    % text(mean([P1(1), P2(1)])+0.1, mean([P1(2), P2(2)]), mean([P1(3), P2(3)]), '(T)', 'Interpreter', 'latex', 'FontSize', 12);
    % text(mean([P2(1), P3(1)])+0.1, mean([P2(2), P3(2)]), mean([P2(3), P3(3)]), '(S)', 'Interpreter', 'latex', 'FontSize', 12);
    % text(mean([P3(1), P4(1)])+0.1, mean([P3(2), P4(2)]), mean([P3(3), P4(3)]), '(F)', 'Interpreter', 'latex', 'FontSize', 12);
    
    hold off;
end

