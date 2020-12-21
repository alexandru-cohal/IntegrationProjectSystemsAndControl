# IntegrationProjectSystemsAndControl
### The project developed for the *"Integration Project Systems and Control"* course within the *"Systems and Control"* Masters of *"Gheorghe Asachi" Technical University of Iași, Romania*
- **Date**: May 2016
- **Purpose**: The purpose of this project is to develop a program which can generate the motion steps of a two-link arm robots from a start point to a goal point without colliding into obstacles
- **Programming Language**: MATLAB
- **Team**: Individual project
- **Inputs** (information given by the user):
  - the environment bounds
  - the set of vertices of each obstacle
  - the position of the base A of the robot
  - the link lengths L<sub>1</sub> and L<sub>2</sub>
  - the initial configuration of the robot (𝜃<sub>10</sub> and 𝜃<sub>20</sub>) chosen such that the robot does not collide with any obstacle
  - the final (desired) position of the effector C, denoted by (x<sub>C_final</sub> and y<sub>C_final</sub>)
- **Outputs** (information to be determined):
  - a control sequence for inputs (𝜔<sub>1</sub> and 𝜔<sub>2</sub>) such that the effector C reaches the desired position and the robot body does not collide with any obstacles while moving
- **Solution**:
  - For the solution's core, two algorithms were used and compared: *Grassfire Algorithm* and *Dijkstra's Algorithm*
  - For more information about the solution, implementation, results, conclusions and improvements see [this document](documentation/Documentation.pdf) document and [this presentation](documentation/Presentation.pptx)
- **Results**:
  - The solution found by the *Dijkstra’s Algorithm* is better (shorter length of the path, smaller execution time), due to the fact that 8 directions are considered, instead of 4 directions considered by the *Grassfire Algorithm*), but the memory used is higher (32 Kbytes instead of 528 Kbytes for a resolution of the Configuration Space of 0.1 rad)
  - For the visual results see [this](documentation/Grassfire_Fast.mp4) and [this](documentation/Grassfire_Motion_Fast.mp4) videos for the *Grassfire Algorithm* and [this](documentation/Dijkstra_Fast.mp4) and [this](documentation/Dijkstra_Motion_Fast.mp4) videos for the *Dijkstra’s Algorithm*
