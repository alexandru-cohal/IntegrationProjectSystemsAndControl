function [ position ] = angles2position( theta1, theta2, robot )

    % Compute the position of the robot knowing the angles of the joints

    l1 = robot.arm_length(1);
    l2 = robot.arm_length(2);
    
    x1 = robot.coordinates(1,1);
    y1 = robot.coordinates(2,1);
    
    x2 = x1 + l1 * cos(theta1);
    y2 = y1 + l1 * sin(theta1);
            
    x3 = x2 + l2 * cos(theta1 + theta2);
    y3 = y2 + l2 * sin(theta1 + theta2);
        
    x = [x1 x2 x3];
    y = [y1, y2, y3];

    position = [x; y];
    
end

