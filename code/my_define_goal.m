function [ Goal ] = my_define_goal( robot )

 %% Define the goal position of the robot's end-effector
    fprintf('\n');
    fprintf('The goal position of the robot''s end-effector \n');
    
    [x, y] = ginput(1);
       
    Goal.coordinates = [x; y];
    
    % Draw the goal position
    
    hold on;
    
    plot(x, y, 'Marker' , 'h', 'MarkerSize', 15, 'MarkerFaceColor', 'green');
    
    % Compute goal's angles - Inverse kinematics
    
    l1 = robot.arm_length(1);
    l2 = robot.arm_length(2);
    
    x = x - robot.coordinates(1,1);
    y = y - robot.coordinates(2,1);
    aux = (x^2 + y^2 - l1^2 - l2^2) / (2 * l1 * l2);
    
    
    theta21 = atan2(-sqrt(1-aux^2), aux);
    if theta21 < 0
        theta21 = theta21 + 2*pi;
    end;
    theta11 = atan2(y,x) - atan2(l2*sin(theta21), l1+l2*cos(theta21));
    if theta11 < 0
        theta11 = theta11 + 2*pi;
    end;
    Goal.angles = [theta11; theta21];
    
    
    theta22 = atan2(sqrt(1-aux^2), aux);
    if theta22 < 0
        theta22 = theta22 + 2*pi;
    end;
    theta12 = atan2(y,x) - atan2(l2*sin(theta22), l1+l2*cos(theta22));
    if theta12 < 0
        theta12 = theta12 + 2*pi;
    end;
    Goal.angles = [Goal.angles, [theta12; theta22] ];
        
end

