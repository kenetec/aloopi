-- from https://github.com/kikito/middleclass
local get_time = os.clock or tick;

return function(file, trials)
    trials = trials or 10000;
    return function(title, f)
        collectgarbage()

        local startTime = get_time()

        for i=0,trials do f() end

        local endTime = get_time()

        local str = title .. '\n\t' .. tostring(endTime - startTime) .. 's\n';
        print(str);

        file:write(str);
    end
end