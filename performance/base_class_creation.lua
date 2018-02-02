local aloopi = require 'aloopi'

-- BASE CLASS CREATION TESTS --
-- no typing, just public and private instance and static members --
return function(time)
	time('Creating a minimal class', function()
		-- Create with the bare minimum.
		aloopi.class() {
			__type = '';
			init = function() end;
		}
	end)

	-- static class
	time('Creating a SC', function()
		aloopi.class() {
			__type = '';

			-- public static variable
			A = 1;
			-- private static variable
			_B = 2;
			-- public static function
			PrintA = function()end;
			-- private static function
			_PrintB = function()end;
		}
	end)

	-- instance class
	time('Creating an IC', function()
		aloopi.class(){
			__type = '';
			__init = function(self)
				-- public instance variable
				self.a = 1;
				-- private instance variable
				self._b = 2;
			end;

			-- public instance function
			print_a = function()end;
			-- private instance function
			print_b = function()end;
		}
	end)
end


-- time('Creating a class w/ static, instance funcs, meta', function()
-- 	aloopi.class() {
-- 		__type = 'complex';

-- 		-- public static variable
-- 		A = 1;
-- 		-- private static variable
-- 		_B = 2;

-- 		-- init
-- 		__init = function()end;

-- 		-- meta member
-- 		__tostring = function()end;
		
-- 		-- public instance function
-- 		print_a = function()end;
-- 		-- private instance function
-- 		print_b = function()end;

-- 		-- public static function
-- 		PrintA = function()end;
-- 		-- private static function
-- 		_PrintB = function()end;
-- 	}
-- end)

-- time('Creating a class with every type of variable', function()
-- 	aloopi.class() {
-- 		__type = 'complex';

-- 		-- private static variable
-- 		['_A: str'] = '';

-- 		-- private meta member
-- 		['__init(num)'] = function(self, num)
-- 			self['const n: num'] = num;
-- 		end;
		
-- 		-- public instance function
-- 		print_num = function(self)end;
-- 		-- private instance function
-- 		['_add(num)'] = function(self, num) end;

-- 		-- public static function
-- 		['Print(str...)'] = function(...)end;
-- 		['PrintDict(tab<any, any>)'] = function(dt)end;
-- 	}
-- end)
