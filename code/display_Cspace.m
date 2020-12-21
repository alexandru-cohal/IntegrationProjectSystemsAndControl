function [ ] = display_Cspace( Cspace )

    tic

    fprintf('\n');
    fprintf('Displaying the Configuration Space ... \n');

    figure();
    xlabel('\theta_1 [rad]');
    ylabel('\theta_2 [rad]');

    for i = 1 : Cspace.dimension
        for j = 1 : Cspace.dimension
            xPlot = (i - 1) * Cspace.angle_step;
            yPlot = (j - 1) * Cspace.angle_step;
            
            hold on;
            if (Cspace.matrix(i, j) == -1)
                plot(xPlot, yPlot, '.r');
            else
                plot(xPlot, yPlot, '.b');
            end;
        end;
    end;

    xPlot = (Cspace.start(1) - 1) * Cspace.angle_step;
    yPlot = (Cspace.start(2) - 1) * Cspace.angle_step;
    hold on;
    plot(xPlot, yPlot, 'Marker' , 'h', 'MarkerSize', 8, 'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'magenta');
    
    xPlot = (Cspace.goal(1,1) - 1) * Cspace.angle_step;
    yPlot = (Cspace.goal(2,1) - 1) * Cspace.angle_step;
    hold on;
    plot(xPlot, yPlot, 'Marker' , 'h', 'MarkerSize', 8, 'MarkerFaceColor', 'green', 'MarkerEdgeColor', 'green');
      
    xPlot = (Cspace.goal(1,2) - 1) * Cspace.angle_step;
    yPlot = (Cspace.goal(2,2) - 1) * Cspace.angle_step;
    hold on;
    plot(xPlot, yPlot, 'Marker' , 'h', 'MarkerSize', 8, 'MarkerFaceColor', 'green', 'MarkerEdgeColor', 'green');
    
    fprintf('Displaying the Configuration Space ended! \n');
    
    toc
    
    fprintf('Pause! Press any key to continue! \n');
    pause;
    
end
