function [ Cspace ] = generate_Cspace( boundaries, obstacle, robot, goal, angle_step )
% Generates the Configuration space
% Matrix Cspace - Theta1 on lines, Theta2 on columns - 0 is a valid configuration; -1 is an invalid configuration

    %% Generate the Configuration Space
      
    tic;
    
    fprintf('\n');
    fprintf('Generating Configuration Space ... \n');
      
    Cspace.angle_step = angle_step;
    
    l1 = robot.arm_length(1);
    l2 = robot.arm_length(2);
    
    x1 = robot.coordinates(1,1);
    y1 = robot.coordinates(2,1);
    
    figure(2);
    title({'Configuration Space'; '(blue - valid configuration; red - invalid configuration)'});
    xlabel('\theta_1 [rad]');
    ylabel('\theta_2 [rad]');
    
    % Initialize the matrix which will store the Configuration Space
    Cspace.dimension = floor(2*pi / angle_step + 1);
    Cspace.matrix = zeros( Cspace.dimension );
    
    % For each angle Theta1 between 0 and 2*pi
    for theta1 = 0 : angle_step : 2*pi
        
        % For each angle Theta2 between 0 and 2*pi
        for theta2 = 0 : angle_step : 2*pi
                    
            x2 = x1 + l1 * cos(theta1);
            y2 = y1 + l1 * sin(theta1);
            
            x3 = x2 + l2 * cos(theta1 + theta2);
            y3 = y2 + l2 * sin(theta1 + theta2);
            
            if inside_boundaries(x1, x2, x3, boundaries(1,1), boundaries(1, 2)) && inside_boundaries(y1, y2, y3, boundaries(2,1), boundaries(2, 2))
                % The robot is inside the boudaries
                
                flagIntersection = 0;
                
                for indexObstacle = 1 : size(obstacle, 2)
                    [x, y] = polyxpoly([x1 x2 x3], [y1 y2 y3], obstacle(indexObstacle).vertices(1,:), obstacle(indexObstacle).vertices(2,:));
                    
                    if size(x, 1) ~= 0
                        % Intersection with an obstacle - INVALID Configuration
                        hold on;
                        plot(theta1, theta2, '.r');
                        flagIntersection = 1;
                        
                        Cspace.matrix(round(theta1 / angle_step) + 1, round(theta2 / angle_step) + 1) = -1;
                        break;                      
                    end;
                end;
                
                if flagIntersection == 0
                    % No intersection with any obstacle - VALID Configuration
                    hold on;
                    plot(theta1, theta2, '.b');
                    
                    Cspace.matrix(round(theta1 / angle_step) + 1, round(theta2 / angle_step) + 1) = 0;
                end;
                
            else
                % The robot is not inside the boundaries - INVALID Configuration
                hold on;
                plot(theta1, theta2, '.r');
                
                Cspace.matrix(round(theta1 / angle_step) + 1, round(theta2 / angle_step) + 1) = -1;
            end;
            
        end;
    end;
    
    %% Plot start position
    xPlot = robot.angles(1);
    if xPlot < 0
        xPlot = xPlot + 2*pi;
    end;
    xPlot = angle_step * round(xPlot / angle_step);
    
    yPlot = robot.angles(2);
    if yPlot < 0
        yPlot = yPlot + 2*pi;
    end;
    yPlot = angle_step * round(yPlot / angle_step);
      
    hold on;
    plot(xPlot, yPlot, 'Marker' , 'h', 'MarkerSize', 8, 'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'magenta');
    
    Cspace.start = [round(xPlot / angle_step) + 1; round(yPlot / angle_step) + 1];
    
    %% Plot goal position
    theta11 = angle_step * round(goal.angles(1,1) / angle_step);    
    theta21 = angle_step * round(goal.angles(2,1) / angle_step);
    
    hold on;
    plot(theta11, theta21, 'Marker' , 'h', 'MarkerSize', 8, 'MarkerFaceColor', 'green', 'MarkerEdgeColor', 'green');
    
    
    theta12 = angle_step * round(goal.angles(1,2) / angle_step);
    theta22 = angle_step * round(goal.angles(2,2) / angle_step);
    
    hold on;
    plot(theta12, theta22, 'Marker' , 'h', 'MarkerSize', 8, 'MarkerFaceColor', 'green', 'MarkerEdgeColor', 'green');
    
    
    Cspace.goal = [round(theta11 / angle_step) + 1, round(theta12 / angle_step) + 1; round(theta21 / angle_step) + 1, round(theta22 / angle_step) + 1];
    
    %%  
    fprintf('Configuration Space generated! \n');
    
    toc;
