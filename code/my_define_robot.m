function [ Robot ] = my_define_robot()

    %% Define the initial position of the robot
    fprintf('\n');
    fprintf('The initial position of the robot given by 3 points \n');
    
    [xA, yA] = ginput(1);
    plot(xA, yA, 'Marker' , 'x', 'MarkerSize', 10, 'MarkerEdgeColor', 'blue');
    [xB, yB] = ginput(1);
    plot(xB, yB, 'Marker' , 'x', 'MarkerSize', 10, 'MarkerEdgeColor', 'blue');
    [xC, yC] = ginput(1);
    plot(xC, yC, 'Marker' , 'x', 'MarkerSize', 10, 'MarkerEdgeColor', 'blue');
       
    Robot.coordinates = [xA xB xC; yA yB yC];
    
    Robot.angles = [atan2(yB - yA, xB - xA), atan2(yC - yB, xC - xB) - atan2(yB - yA, xB - xA)];
    
    Robot.arm_length = [sqrt((xA-xB)^2 + (yA-yB)^2) sqrt((xB-xC)^2 + (yB-yC)^2)];

    % Draw the robot
    
    hold on;
    
    hBody = plot(Robot.coordinates(1, :), Robot.coordinates(2, :), 'c', 'LineWidth', 3);
    hBasePoint = plot(xA, yA, 'Marker' , 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');
    hMiddlePoint = plot(xB, yB, 'Marker' , 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');
    hEndPoint = plot(xC, yC, 'Marker' , 'h', 'MarkerSize', 15, 'MarkerFaceColor', 'magenta');
    
    Robot.handlers = [hBody; hBasePoint; hMiddlePoint; hEndPoint];

end

