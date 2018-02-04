local aloopi = require 'aloopi'

return function(time)
    time('SC with one typed variable', function()
        aloopi.class '' (){
            -- public static variable
            ['A: num'] = 1;
        }
    end)

    time('SC with two typed variables', function()
        aloopi.class '' (){
            -- public static variable
            ['A: num'] = 1;
            -- private static variable
            ['_B: num'] = 2;
        }
    end)

    time('SC w/ 2 typed vars and 2 single param funcs', function()
        aloopi.class '' () {
            -- public static variable
            ['A: num'] = 1;
            -- private static variable
            ['_B: num'] = 2;
            -- public static function
            ['PrintA(str)'] = function()end;
            -- private static function
            ['PrintB(str)'] = function()end;
        }
    end)
end