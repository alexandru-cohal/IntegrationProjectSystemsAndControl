function [ intersect ] = intersect_obstacles( xArm, yArm, obstacle )
    
    intersect = false;

    for indexObstacle = 1 : size(obstacle, 2)
        
        xObstacle = obstacle(indexObstacle).vertices(1, :);
        yObstacle = obstacle(indexObstacle).vertices(2, :);
        
        if size(polyxpoly(xArm, yArm, xObstacle, yObstacle), 1) ~= 0 
            intersect = true;
            return
        end;
            
    end;

end

