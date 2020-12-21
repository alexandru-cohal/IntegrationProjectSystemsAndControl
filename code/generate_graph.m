function [ lengthAdjCost, adjacency, cost ] = generate_graph( Cspace )

    fprintf('\n');
    fprintf('Generating the Graph ... \n');

    step1 = [0, -1, 0, 1;...
             -1, 0, 1, 0];
    cost1 = 1;
    step2 = [-1, -1, 1, 1;...
             -1, 1, 1, -1];
    cost2 = sqrt(2);
    
    lengthAdjCost = zeros(Cspace.dimension * Cspace.dimension, 1);
    adjacency = zeros(Cspace.dimension * Cspace.dimension, 8);
    cost = zeros(Cspace.dimension * Cspace.dimension, 8);
    
    for i = 1 : Cspace.dimension
        for j = 1 : Cspace.dimension
                          
            % If it is a valid position
            if (Cspace.matrix(i, j) == 0)
                
                currentElementIndex = sub2ind([Cspace.dimension, Cspace.dimension], i, j);
                
                % Directions: Left, Up, Right, Down
                for k = 1 : 4
                    neighbour = [i; j] + step1(:, k);
                    neighbour = circularity(neighbour, Cspace.dimension);
                    
                    % If it is a valid neighbour
                    if (Cspace.matrix(neighbour(1), neighbour(2)) == 0)
                        neighbourIndex = sub2ind([Cspace.dimension, Cspace.dimension], neighbour(1), neighbour(2));
                        
                        lengthAdjCost(currentElementIndex) = lengthAdjCost(currentElementIndex) + 1;
                        adjacency(currentElementIndex, lengthAdjCost(currentElementIndex)) = neighbourIndex;
                        cost(currentElementIndex, lengthAdjCost(currentElementIndex)) = cost1;
                    end;
                    
                end;
                
                % Directions: Upper-Left, Upper-Right, Down-Right, Down-Left
                for k = 1 : 4
                    neighbour = [i; j] + step2(:, k);
                    neighbour = circularity(neighbour, Cspace.dimension);
                    
                    % If it is a valid neighbour
                    if (Cspace.matrix(neighbour(1), neighbour(2)) == 0)
                        neighbourIndex = sub2ind([Cspace.dimension, Cspace.dimension], neighbour(1), neighbour(2));
                        
                        lengthAdjCost(currentElementIndex) = lengthAdjCost(currentElementIndex) + 1;
                        adjacency(currentElementIndex, lengthAdjCost(currentElementIndex)) = neighbourIndex;
                        cost(currentElementIndex, lengthAdjCost(currentElementIndex)) = cost2;
                    end;
                    
                end;
                
            end;
        end;
    end;

    fprintf('Graph generated! \n');

end

