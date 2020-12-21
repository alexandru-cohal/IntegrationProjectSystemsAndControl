function [ ] = move_robot( path, goal, robot, angle_step, keepPreviousPosition )

    fprintf('\n');
    fprintf('Press any key to Start the motion of the Robot \n');
    pause();
    
    tic
    
    fprintf('Motion of the Robot started! \n');

    path.element = path.element * angle_step;

    figure(1);
        
    if keepPreviousPosition == 1
        plot(robot.handlers(1).XData, robot.handlers(1).YData, 'y', 'LineWidth', 3);
        plot(robot.handlers(2).XData, robot.handlers(2).YData, 'Marker' , 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');
        plot(robot.handlers(3).XData, robot.handlers(3).YData, 'Marker' , 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');
        plot(robot.handlers(4).XData, robot.handlers(4).YData, 'Marker' , 'h', 'MarkerSize', 15, 'MarkerFaceColor', 'magenta');
    end;
     
    for index = 1 : size(path.element, 2) 
        theta1 = path.element(1, index);
        theta2 = path.element(2, index);
        
        position = angles2position(theta1, theta2, robot);
              
        x = position(1, :);
        y = position(2, :);
        
        hold on;
        
        robot.handlers(1).XData = x;
        robot.handlers(1).YData = y;
        robot.handlers(3).XData = x(2);    
        robot.handlers(3).YData = y(2);
        robot.handlers(4).XData = x(3);    
        robot.handlers(4).YData = y(3);
        
        pause(0.1);
    end;

    theta1 = goal.angles(1, path.goalPointReached);
    theta2 = goal.angles(2, path.goalPointReached);
    
    position = angles2position(theta1, theta2, robot);
    
    x = position(1, :);
    y = position(2, :);
    
    hold on;
    
    robot.handlers(1).XData = x;
    robot.handlers(1).YData = y;
    robot.handlers(3).XData = x(2);
    robot.handlers(3).YData = y(2);
    robot.handlers(4).XData = x(3);
    robot.handlers(4).YData = y(3);
    
    fprintf('Motion of the Robot ended! Goal point reached! \n');
    
    toc
    
end

