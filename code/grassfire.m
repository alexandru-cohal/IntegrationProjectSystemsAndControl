function [path] = grassfire( Cspace)

    tic

    fprintf('\n');
    fprintf('Applying Grassfire Algorithm ... \n');
    
    % Neighbour's offsets on rows and columns, respectively
    step = [0, -1, 0, 1; ...
           -1, 0, 1, 0];
%     step = [0, -1, -1, -1, 0, 1, 1, 1; ...
%             -1, -1, 0, 1, 1, 1, 0, -1];

    queue = Cspace.start;
    noNodesVisited = 1;

    while (size(queue) ~= 0)    
        % Store and Remove the first element from the queue
        element = queue(:, 1);
        queue(:,1) = [];

        % Determine its neghbours
        for k = 1 : size(step, 2)
            neighbour = element + step(:, k);
            neighbour = circularity(neighbour, Cspace.dimension);
            
            % Verify if one of the goal configration was reached
            if ((neighbour(1) == Cspace.goal(1,1) && neighbour(2) == Cspace.goal(2,1)) || (neighbour(1) == Cspace.goal(1,2) && neighbour(2) == Cspace.goal(2,2)))
                
                if (neighbour(1) == Cspace.goal(1,1) && neighbour(2) == Cspace.goal(2,1))
                    path.goalPointReached = 1;
                else
                    path.goalPointReached = 2;
                end;
                
                Cspace.matrix(neighbour(1), neighbour(2)) = Cspace.matrix(element(1), element(2)) + 1;
                % Display the statistics
                fprintf('Goal point reached! \n');
                fprintf('Distance = %g \n', Cspace.matrix(neighbour(1), neighbour(2)));
                fprintf('Number of visited Nodes = %g \n', noNodesVisited);
                
                % Display and store the path.element
                element = neighbour;
                              
                path.element = element;
                
                while (Cspace.matrix(element(1), element(2)) > 0)
                    
                    for p = 1 : size(step, 2)
                        neighbour = element + step(:, p);
                        neighbour = circularity(neighbour, Cspace.dimension);
                        
                        if (Cspace.matrix(neighbour(1), neighbour(2)) == Cspace.matrix(element(1), element(2)) - 1)
                            element = neighbour;
                            path.element = [element, path.element];
                            
                            if (Cspace.matrix(neighbour(1), neighbour(2)) > 0)
                                plot((element(1) - 1) * Cspace.angle_step , (element(2) - 1) * Cspace.angle_step, 'Marker' , 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'yellow', 'MarkerEdgeColor', 'yellow');
                            end;
                            
                            break;
                        end;
                    end;
                end;
        
                fprintf('End of Grassfire Algorithm. \n');
    
                toc
                
                return;
            end;

            % Verify if a valid configuration was reached
            if (Cspace.matrix(neighbour(1), neighbour(2)) == 0 && (neighbour(1) ~= Cspace.start(1) || neighbour(2) ~= Cspace.start(2)))
                % Store the neighbour in the queue and update the distance
                queue = [queue neighbour];
                Cspace.matrix(neighbour(1), neighbour(2)) = Cspace.matrix(element(1), element(2)) + 1;
                noNodesVisited = noNodesVisited + 1;

                pause(0.00001);
                hold on;
                plot((neighbour(1) - 1) * Cspace.angle_step , (neighbour(2) - 1) * Cspace.angle_step, 'Marker' , 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'cyan', 'MarkerEdgeColor', 'cyan');
            end;
        end;
    end;
end

