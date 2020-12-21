function [ path ] = dijkstra( lengthAdjCost, adjacency, cost, start, goal, angle_step )

    tic

    fprintf('\n');
    fprintf('Applying Dijkstra''s Algorithm ... \n') 

    distance = ones(size(lengthAdjCost, 1), 1) * Inf;
    precedent = zeros(size(lengthAdjCost, 1), 1);
    path.element = [];
    
    queue = start;
    noNodesVisited = 1;
    distance(start) = 0;
    minDistance2Goal = Inf;
    
    while ( size(queue) ~= 0 )
        element = queue(1);
        queue(1) = [];
        
        if distance(element) < minDistance2Goal
            for k = 1 : lengthAdjCost(element)
                neighbour = adjacency(element, k);
                if distance(neighbour) > distance(element) + cost(element, k)
                    distance(neighbour) = distance(element) + cost(element, k);
                    precedent(neighbour) = element;
                    queue = [queue neighbour];
                    noNodesVisited = noNodesVisited + 1;

                    %if mod(noNodesVisited, 100) == 0
                        pause(0.001);
                    %end;

                    if neighbour ~= start && neighbour ~= goal(1) && neighbour ~= goal(2)
                        [row, column] = ind2sub([sqrt(size(lengthAdjCost, 1)), sqrt(size(lengthAdjCost, 1))], neighbour);
                        plot((row - 1) * angle_step , (column - 1) * angle_step, 'Marker' , 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'cyan', 'MarkerEdgeColor', 'cyan');
                    else
                        if neighbour == goal(1) || neighbour == goal(2)
                            minDistance2Goal = min(minDistance2Goal, distance(neighbour));
                        end;
                    end;
                end;
            end;
        end;
    end;

    if distance(goal(1)) < distance(goal(2)) 
        element = goal(1);
        path.goalPointReached = 1;
        cost = distance(goal(1));
    else
        element = goal(2);
        path.goalPointReached = 2;
        cost = distance(goal(2));
    end;
    
    lengthShortestPath = 0;
    while element ~= 0   
        [row, column] = ind2sub([sqrt(size(lengthAdjCost, 1)), sqrt(size(lengthAdjCost, 1))], element);
        path.element = [[row; column] path.element];
        
        if element ~= start && element ~= goal(1) && element ~= goal(2)
            plot((row - 1) * angle_step , (column - 1) * angle_step, 'Marker' , 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'yellow', 'MarkerEdgeColor', 'yellow');
        end;
              
        element = precedent(element);
        lengthShortestPath = lengthShortestPath + 1;
    end;
    
    fprintf('Distance = %g \n', lengthShortestPath);
    fprintf('Number of visited Nodes = %g \n', noNodesVisited);
    fprintf('Cost = %g \n', cost);
    
    fprintf('End of Dijkstra''s Algorithm. \n');
    
    toc
end

