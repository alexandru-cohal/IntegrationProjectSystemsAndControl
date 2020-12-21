function [ limits ] = my_define_environment( )

    fprintf('Limits of the environment \n');
    xMin = input('x Min: ');
    xMax = input('x Max: ');
    yMin = input('y Min: ');
    yMax = input('y Max: ');

    figure(1);
    axis([xMin xMax yMin yMax]);
    grid;
         
    limits = [xMin xMax; yMin yMax];
    
end

