function [ output ] = inside_boundaries(x1, x2, x3, min, max)

    if (min <= x1 && x1 <= max)
        if (min <= x2 && x2 <= max)
            if (min <= x3 && x3 <= max)
                output = true;
                return
            end;
        end;
    end;

    output = false;

end

