local aloopi = require 'aloopi'
local class = aloopi.class;
local typeof = aloopi.typeof;

local Food = class () {
    __type = 'Food';

	-- static constant
	['const EDIBLE'] = true;

	['__init(str, num)'] = function(self, name, healthinessLevel)
		self['name: str'] = name;
        self._healthinessLevel = healthinessLevel
	end;

    what_are_you = function(self)
		print('I am known as ' .. self.name .. ' and I have a healthiness level of ' .. tostring(self._healthinessLevel))
    end;
    
    ['const PrintFood([]str)'] = function(foods)
        print 'Here are the foods:'
        for i, v in next, foods do print('', v) end
        print '\nyum!'
    end;

    ['Num: num'] = 5;
}

--local p1 = Person(1, 'Kendall Hester') -- -> Error
-- Food:PrintFood({'apple', 'burger', 'juice'})
-- Food.Num = 6

-- local food = Food('Peanut', 6)
-- food.what_are_you() --> 'I am known as Peanut and I have a healthiness level of 6'
-- food.name = 'Eapple'
-- food:what_are_you()

-- print(typeof(food))

local RGB = class () {
	__type = 'RGB',
	['__init(num, num, num)'] = function(self, r, g, b)
		self['const r: num'] = r;
		self['const g: num'] = g;
		self['const b: num'] = b;
	end;

	__tostring = function(self)
		return string.format('rgb(%d, %d, %d)', self.r, self.g, self.b)
		--return tostring(self);
	end;
}

local Fruit;
Fruit = class (Food) {
	__type = 'Fruit',

	['__init(str,, RGB)'] = function(self, name, healthinessLevel, fruitColor)
		self.super(name, healthinessLevel)
        self['_fruitColor: RGB'] = fruitColor
	end;

	what_are_you = function(self)
		print(Fruit._YUMMY, Fruit.Yes) --> true	false
		print('I am a ' .. self.name .. '. I have a healthiness level of ' .. tostring(self._healthinessLevel) .. ' and my color is ' .. tostring(self._fruitColor))
	end;
	
	['PrintDict(tab<RGB,num>)'] = function(self, dict)
		Fruit._YUMMY = false;
		Fruit.Yes = true;
		for k, v in next, dict do print(k, v) end
	end;

	['_YUMMY'] = true;
	['Yes'] = false;
	
	['Print(num, []str?...)'] = function(self, ...)
		print(...)
	end;
}

-- local apple = Fruit('Apple', 10, RGB(220, 0, 100))
-- apple.what_are_you()
Fruit.Print(1, 2)

-- Fruit.PrintDict {
-- 	[RGB(1, 1, 1)] = 1;
-- 	[RGB(5, 10, 10)] = 2;
-- 	[RGB(100, 100, 100)] = 3;
-- }
-- Fruit.PrintDict {}--{1, 2, 3, 4, 5, 0}

--print(apple._healthinessLevel) --> 'nil'

local Orange = class (Fruit) {
	__type = 'Orange';
	['__init(str, num, RGB, num)'] = function(self, name, healthinessLevel, fruitColor, sweetness)
		self.super(name, healthinessLevel, fruitColor)
		self['sweetness: num'] = sweetness;
	end;

	how_sweet = function(self)
		self.what_are_you()
		return self.sweetness > 0.5 and 'very sweet' or 'eh not really sweet'
	end
}

local o = Orange('annoying orange', 10, RGB(100, 40, 170), 8);
print(o.how_sweet())