function [ ] = drawRobotPointsGiven( x, y )

    %% Define the initial position of the robot
    fprintf('The initial position of the robot given by 3 points \n (the third point corresponds to the end-effector) \n');
    
    [xA yA] = ginput(1);
    [xB yB] = ginput(1);
    [xC yC] = ginput(1);
       
    Robot.coordinates = [xA xB xC; yA yB yC];
    
    Robot.angles = [atan2(yB - yA, xB - xA), atan2(yC - yB, xC - xB)];

    %% Draw the robot
    
    hold on;
    
    plot(x, y, 'c', 'LineWidth', 3);
    plot(x(1), y(1), 'Marker' , 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');
    plot(x(2), y(2), 'Marker' , 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');
    plot(x(3), y(3), 'Marker' , 'h', 'MarkerSize', 15, 'MarkerFaceColor', 'red');

end

