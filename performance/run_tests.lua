local file = io.open('./performance/results/' .. os.time() .. '.txt', 'w');

local time = require 'performance.time' (file, 10000);

local tests = {
    'base_class_creation',
    'static',
    'complex_classes',
    'inheritance'
}

for _, filename in next, tests do
    file:write('\n\t\t\t\t\t' .. filename .. ':\n\n')
    require('performance.' .. filename)(time)
end

file:flush();
