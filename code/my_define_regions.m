function [ R ] = my_define_regions()

    fprintf('\n');
    fprintf('Obstacles \n');
    noRegions = input('Number of regions: ');
    
    %% Define the regions
    for index = 1 : noRegions
        
        fprintf('\n', index);
        fprintf('Region %g \n', index);
        fprintf('Left click - add a point, Right click - finish adding points \n');
        
        x = [];
        y = [];
        
        % Read the first vertex
        [xRead, yRead, button] = ginput(1);
        
        % While the right-button is not pressed
        while button == 1
            % Add the vertex to the vertex list
            x = [x xRead];
            y = [y yRead];
            
            % Plot the vertex
            hold on;
            plot(xRead, yRead, 'Marker' , 'x', 'MarkerSize', 10, 'MarkerEdgeColor', 'red');
            
            % Read the next vertex
            [xRead, yRead, button] = ginput(1);
        end;
               
        % Compute the Convex Hull
        indicesConvHull = convhull(x', y');
        
        % Store only the coordinates from the convex hull in the cell R
        R(index).vertices = [x(:, indicesConvHull); y(:, indicesConvHull)];
        
        % Draw the region
        fill(R(index).vertices(1, :), R(index).vertices(2, :), 'red', 'FaceAlpha', 0.5);
    end;
       
end