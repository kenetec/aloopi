local aloopi = require 'aloopi'

return function(time)
    time('Creating a class with no typing', function()
        aloopi.class '' () {
            -- public static variable
            A = 1;
            -- private static variable
            _B = 2;

            -- init
            __init = function()end;

            -- meta member
            __tostring = function()end;
            
            -- public instance function
            print_a = function()end;
            -- private instance function
            print_b = function()end;

            -- public static function
            PrintA = function()end;
            -- private static function
            _PrintB = function()end;
        }
    end)
end