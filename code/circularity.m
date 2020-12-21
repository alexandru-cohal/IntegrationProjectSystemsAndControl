function [ position ] = circularity( position, maxDimension )

    % Circularity of the row number
    if (position(1) == 0)
        position(1) = maxDimension;
    else
        if (position(1) == maxDimension + 1)
            position(1) = 1;
        end;
    end;

    % Circularity of the column number
    if (position(2) == 0)
        position(2) = maxDimension;
    else
        if (position(2) == maxDimension + 1)
            position(2) = 1;
        end;
    end;

end

