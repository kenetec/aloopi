local aloopi = require 'aloopi'

return function(time)
	local A = aloopi.class '' () {
		__init = function() end;
	}

	time('Creating a minimal child class', function()
		aloopi.class ''  (A) {
			__init = function() end;
		}
	end)

	local AA = aloopi.class ''  (A) {
		__init = function() end;
	}

	time('Creating a minimal child class of child class', function()
		aloopi.class ''  (AA) {
			__init = function() end;
		}
	end)
end