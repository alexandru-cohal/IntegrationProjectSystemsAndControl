clear;
clc;
close all;

%% Constants
angle_step = 0.1; % in radians

%% Define environment
boundaries = my_define_environment();

%% Define obstacles
obstacle = my_define_regions();

%% Define robot
robot = my_define_robot();

%% Define goal position of robot's end-effector
goal = my_define_goal(robot);

% Verify if the goal position can be reached, excluding the obstacles
if ( sqrt((goal.coordinates(1) - robot.coordinates(1,1))^2 + (goal.coordinates(2) - robot.coordinates(2,1))^2) > robot.arm_length(1) + robot.arm_length(2) )
    fprintf('\n');
    fprintf('NO SOLUTION! The goal is too far from the robot''s base point! \n');
    return;
end;

%% Generate C-space
Cspace = generate_Cspace(boundaries, obstacle, robot, goal, angle_step);

% Verify if the goal position can be reached
if (Cspace.matrix( Cspace.goal(1,1), Cspace.goal(2,1) ) == -1 && Cspace.matrix( Cspace.goal(1,2), Cspace.goal(2,2) ) == -1)
    fprintf('\n');
    fprintf('NO SOLUTION! The goal cannot be reached! \n');
    return;
end;

fprintf('Pause! Press any key to continue! \n');
pause;

%% Grassfire Algorithm (Fill Algorithm) (Breadth-First Search Algorithm)
display_Cspace(Cspace);
title({'Configuration Space of Grassfire Algorithm'; '(blue - valid configuration; red - invalid configuration;'; 'cyan - visited node; yellow - shortest path)'});
pause;
pathGrassfire = grassfire(Cspace);

fprintf('Pause! Press any key to continue! \n');
pause;

move_robot(pathGrassfire, goal, robot, angle_step, 1);

fprintf('Pause! Press any key to continue! \n');
pause;

%% Dijkstra's Algorithm
display_Cspace(Cspace);
title({'Configuration Space of Dijkstra''s Algorithm'; '(blue - valid configuration; red - invalid configuration;'; 'cyan - visited node; yellow - shortest path)'});
[lengthAdjCost, adjacency, cost] = generate_graph(Cspace);
startInd = sub2ind([Cspace.dimension, Cspace.dimension], Cspace.start(1), Cspace.start(2));
goalInd = [sub2ind([Cspace.dimension, Cspace.dimension], Cspace.goal(1,1), Cspace.goal(2,1)), sub2ind([Cspace.dimension, Cspace.dimension], Cspace.goal(1,2), Cspace.goal(2,2))];
pathDijkstra = dijkstra(lengthAdjCost, adjacency, cost, startInd, goalInd, Cspace.angle_step);
move_robot(pathDijkstra, goal, robot, angle_step, 0);

%%
fprintf('\n');
fprintf('Program execution completed ! \n');