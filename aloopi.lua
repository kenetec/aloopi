--[[
    aloopi by Kendall Hester
    
    
    Another Lua OOP Implementation

    Uses:
    + Implementing an API.
    
    This module provides:
    + Fully featured class system.
        + Inheritance
        + Public and private members
        + Static members
        + Custom meta for objects
            + except for __index, __newindex, and __metatable
    + Static typing for members
        + Supports multidimensional arrays
            + 'f([,]num)' -> two-dimensional array of infinite numbers
        + Supports custom class types
        + Supports dictionaries
            + 'tab<str, num>' -> dictionary with string keys and number values
    
    
    This module returns:
        
        BaseClass   class(BaseClass super_class) -> (table members)
        string      typeof(any object)
            - retrieves __type from given class or type(object)/typeof(object)
        bool        instanceof(Object object, BaseClass parent)
            - returns true if object is an instance of parent


    Member access:
        + lowercase for instance members
            + instance members can access instance members(and static by referencing the actual class not self)
        + Uppercase for static members
            + static members can only access other static members
        + 'const' for constants
        + '_' prefix for private members
        + '__' prefix for meta.

        OR
        [possibility]
        - all members are public instance members by default
        - '-' for private members
        - 'stat' for static members
        - 'inst' for instance members
        - 'const' for constant members
        - optional '+' for public members
    
    Type declarations:
    
    + ['FAVORITE_NUM'] = 5
        + constants cannot be statically typed b/c they cannot change to begin with
        + you can define functions as const
            + 'const f(num)'

    + ['name: str'] = ''
        + 'name' is the name of the variable
        + ':' operator to set type
        + 'str' is shorthand for the datatype 'string'

    + ['f(str, num)'] = function(name, age)
        + 'f' is the name of the function
        + parenthesis are required to identify type declaration for function
        + 'str' is a datatype
        + 'num' is a datatype
    
    + You can leave a parameter undefined by adding a comma: 
        + 'f(str,,num) = function(name, any, age)'
            + this is shorthand for 'f(str, any, num)'
    + Define an array
        + 'f([]str)' -> array of infinite string
        + 'f([5]num)' -> array of five numbers
        + 'f([,]num)' -> two-dimensional array of infinite numbers
        + 'f(tab<num>)' -> one-dimensional array of infinite numbers
    + Define dictionaries
        + 'tab<str, num>' -> keys: string, values: numbers
    + Define variable arguments
        + 'f(str...)' -> variable arguments of type string
        + 'f(num, []bool...)' -> number, infinite arrays of infinite bools
--]]
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO: Implement dictionaries:  'table<str, str>' | alt declaration for arrays, 'table<num>'
    -- DONE
-- BUG: Shared self-pointer, needs to be individualized.
    -- SOLVED: deep copy instance_members to make a completely independent copy
-- TODO: static members' self pointer (access to public & private static members)
    -- DONE
-- TODO: Implement varargs: 'str...' | '[]num...' | '...'
    -- DONE
-- TODO: Add '?' operator: 'str?' = string or nil
    -- DONE
-- TODO: Make an proper error system.
-- TODO: function overloading?
-- TODO: Add optional 'public', 'private', and 'static' modifiers?
-- TODO: Implement interfaces?
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for defining utility functions.
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    table   copy_t(table)
    - Shallow copies table
--]]
local function copy_t(t)
    local T = {};
    for i, v in next, t do
        T[i] = v;
    end
    return T;
end

--[[
    table   deep_copy_t(table)
    - Recursive copy
--]]
local function deep_copy_t(arg)
    local function recurse(t)
        local res = {}
        for i, v in next, t do
            if type(v) == 'table' then
                res[i] = deep_copy_t(v)
            else
                res[i] = v;
            end
        end
        return res;
    end

    return recurse(arg);
end

--[[
    table   copy_into(table into, table from)
    - Shallow copies [from] to [into]
--]]
local function copy_into(into, from) 
    local T = into or {}; 
    for i, v in next, from do 
        T[i] = v; 
    end 
    return T; 
end

--[[
    table   merge(table into, table from)
    - Shallow merges [from] to [into]
--]]
local function merge(into, from)
    local T = into or {};
    for i, v in next, from do 
        if type(into[i]) == 'nil' then 
            T[i] = v; 
        end 
    end 
    return T;
end

--[[
    bool   n_of_items_in(table)
    - Gets number of items in table
--]]
local function n_of_items_in(t)
    local i = 0;
    for _, v in next, t do
        i = i + 1;
    end
    return i;
end

--[[
    table   print_t(table)
    - Shallow prints table
--]]
local function print_t(t)
    for i, v in next, t do
        print(i, v)
    end
end

--[[
    table   new_ekv_table(table)
    - Creates an 'equal key value' table (keys equal the values given in table)
--]]
local function new_ekv_table(t)
    local T = {};
    for i, v in next, t do
        T[v] = v;
    end
    return T
end

--[[
    table   slice_t(table t, number slice_start, number slice_end)
    - Returns a sliced copy of [t].
--]]
local function slice_t(t, slice_start, slice_end)
    local T = {}
    local Ti = 1;
    for i = slice_start, slice_end do
        T[Ti] = t[i]
        Ti = Ti + 1;
    end
    return T
end

--[[
    bool   is_alpha(string s)
    - Returns true if [s] matches '^[a-zA-Z_]$'
--]]
local function is_alpha(v)
    if v then
        if v:match('^[a-zA-Z_]$') then
            return true;
        end
    end
    return false
end

--[[
    bool   is_alpha_numerical(string s)
    - Returns true if [s] matches '^[a-zA-Z_0-9]$'
--]]
local function is_alpha_numerical(v)
    if v then
        if v:match('^[a-zA-Z_0-9]$') then
            return true;
        end
    end
    return false
end

--[[
    bool   is_whitespace(string s)
    - Returns true if [s] matches '^[ \t\n]$'
--]]
local function is_whitespace(v)
    if v then
        if v:match('^[ \t\n]$') then
            return true
        end
    end
    return false
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for auxiliary functionss
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- lua vanilla datatypes
local primitive_dts = new_ekv_table {
    'string',
    'number',
    'function',
    'table',
    'boolean',
    'userdata',
    'thread',
    'nil',
    -- not vanilla but who cares?
    'any'
}

local function _typeof(o)
    -- see if typeof is already defined(ROBLOX)
    local type = typeof and typeof or type;
    local t = type(o)

    if t == 'table' then
        local success, meta = pcall(function() return getmetatable(o) end)
        if success then
            if type(meta) == 'table' then
                if meta.__type then
                    return meta.__type
                end
            end
        end
    end

    return primitive_dts[t] or t
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for parsing keys.
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Container
--     - a container that describes any modifiers apply to the value via key


-- example:
--     '__init(str, num, [,5]num)'
--         __init = {
--             type = 'fn',
--             val = f,

--             params = {           <-- Containers
--                 {
--                     type = 'datatype'
--                     dt = 'string'
--                 },
--                 {
--                     type = 'datatype'
--                     dt = 'number'
--                 },
--                 {
--                     type = 'array'
--                     dt = 'number'
--                     dimensions = {
--                         [1] = -1 -- -1 is infinite
--                         [2] = 5 -- size
--                     }
--                 }
--         }
local Container = {
    mt = {__type = 'Container'};
    base = {
            -- types
            --     fn
            --     var
            --     array
            --     datatype
            --     dictionary
        type = '';
        dt = 'any';
        -- value itself
        val = nil;
        -- unparsed string
        raw_key = '';
    };
}

function Container.new()
    return setmetatable(Container.base, Container.mt)
end

function Container.copy(base)
    local copy = copy_t(base);
    return setmetatable(copy, Container.mt);
end

-- BASE CONTAINERS
function Container.fn(base)
    return setmetatable(merge({
        type = 'fn';
        dt = 'function';
        params = {};
    }, base and base or Container.base), 
    Container.mt);
end

function Container.var(base)
    return setmetatable(merge({
        type = 'var';
    }, base and base or Container.base), 
    Container.mt);
end

function Container.datatype(base)
    return setmetatable(merge({
        type = 'datatype';
    }, base and base or Container.base), 
    Container.mt);
end

function Container.array(base)
    return setmetatable(merge({
        type = 'array',
        dt = 'table';
        val_dt = '';
        val_optional = false;
        dimensions = {
            -- [1] = (size)
        }
    }, base and base or Container.base), 
    Container.mt);
end

function Container.dictionary(base)
    return setmetatable(merge({
        type = 'dictionary',
        dt = 'table',

        key_dt = '';
        key_optional = false;
        val_dt = '';
        val_optional = false;
    }, base and base or Container.base), 
    Container.mt);
end

-- Modifiers (ones that don't change the type)
function Container.vargs(base)
    return setmetatable(merge({
        vargs = true,
    }, base and base or Container.base), 
    Container.mt);
end


function Container.const(base)
    return setmetatable(merge({
        const = true;
    }, base and base or Container.base), 
    Container.mt);
end

function Container.optional(base)
    return setmetatable(merge({
        optional = true;
    }, base and base or Container.base), 
    Container.mt);
end

local function check_array(container, arg)
    if _typeof(arg) == 'table' then
        -- verify number of dimensions
        local num_of_dims = n_of_items_in(container.dimensions)

        local function recurse(dim, lvl)
            -- verify size of dimension
            local dim_size = container.dimensions[lvl]

            if dim_size > 0 then
                if n_of_items_in(dim) ~= dim_size then
                    -- error 
                    error('Array does not contain ' .. (dim_size > 0 and dim_size or 'any') .. ' items');
                end
            end

            -- enter next dimension or read values
            for k, v in next, dim do
                if _typeof(k) ~= 'number' then
                    error('Element in dimension \'' .. lvl .. '\' does not have numerical keys.')
                end

                if lvl < num_of_dims then
                    -- get next dimension
                    if _typeof(v) == 'table' then
                        -- check next dimension
                        recurse(v, lvl+1)
                    else
                        error('Expected item in dimension ' .. tostring(num_of_dims) .. ', got ' .. _typeof(v) .. ' instead.')
                    end
                else
                    for i, v in next, dim do
                        if _typeof(v) ~= container.val_dt then
                            if _typeof(v) == 'nil' and container.val_optional then
                                -- pass
                            else
                                -- check datatypes of items
                                error('Element in dimension \'' .. lvl .. '\' at index \'' .. i .. '\' is not of datatype \'' .. container.val_dt .. '\'')
                            end
                        end
                    end
                end
            end
        end

        recurse(arg, 1);
    else
        error('Got: \'' .. _typeof(arg) .. '\' instead of an array of \'' .. container.dt .. '\' in \'' .. container.raw_key .. '\'')
    end
end

local function check_dictionary(container, arg)
    local ct = container.type;

    local kdt = container.key_dt;
    local k_optional = container.key_optional;

    local vdt = container.val_dt;
    local v_optional = container.val_optional;

    if _typeof(arg) == 'table' then
        for k, v in next, arg do
            if _typeof(k) ~= kdt then
                if _typeof(k) == 'nil' and v_optional then
                    -- pass
                else
                    -- key error
                    error('Keys\' datatype is \'' .. _typeof(k) .. '\', not datatype \'' .. kdt .. '\' in \'' .. container.raw_key ..'\'')
                end
            end

            if _typeof(v) ~= vdt then
                if _typeof(v) == 'nil' and v_optional then
                    -- pass
                else
                    -- value error
                    error('Values\' datatype is \'' .. _typeof(k) .. '\', not datatype \'' .. kdt .. '\' in \'' .. container.raw_key ..'\'')
                end
            end
        end
    else
        error('Got: \'' .. _typeof(arg) .. '\' instead of a dictionary of \'' .. kdt .. '\' to \'' .. vdt .. '\' in \'' .. container.raw_key .. '\'')
    end
end

local function check_type(container, arg)
    local ct = container.type;
    local dt = container.dt;
    local at = _typeof(arg);

    if at == dt then
        if ct == 'array' then
            check_array(container, arg)
        elseif ct == 'dictionary' then
            check_dictionary(container, arg)
        end
    elseif at == 'nil' and container.optional then
        -- pass
    elseif dt == 'any' then
        -- pass
    else
        error('Got: \'' .. at .. '\' instead of \'' .. dt .. '\' in \'' .. container.raw_key .. '\'')
    end
end

local function check_vargs(container, args)
    for arg_i, arg in next, args do
        check_type(container, arg)
    end
end

local function get_container_value(ignore_self, container, on_fn_clear)
    if _typeof(container.val) == 'function' then
        -- wrap function to check for args datatypes
        return function(...)
            -- check if called with ':'
            local args = {...}

            if #args > 0 then
                -- remove pointer provided
                if ignore_self then
                    if args[1] == ignore_self then args = slice_t(args, 2, #args) end
                end

                if container.type == 'fn' then
                    -- check arg types
                    for i, param in next, container.params do
                        if param.vargs == true then
                            check_vargs(param, slice_t(args, i, #args))
                            break;
                        else
                            check_type(param, args[i])  
                        end      
                    end
                end
            end

            return on_fn_clear(container, args)
        end
    end
    return container.val
end

local function set_container_value(container, val)
    local new_container = Container.copy(container);
    if container.const then
        error('Cannot change value of a constant!')
    else
        -- check type
        check_type(container, val)
        -- set value
        new_container.val = val;
    end

    return new_container
end

local function get_raw_val(o)
    if _typeof(o) == 'Container' then
        return o.val;
    end
    return o;
end

local function determine_access(key)
    if (key:sub(1, 1) == '_') then
        -- Is private
        return 'private'
    else
        return 'public'
    end
end


-- token_types:
--     'ID'
--     'NUMBER'

-- tokens that are keywords or special characters will have the same type as their name
local parse_key;
local parse_keys;
do
    -- LEXER --

    -- accept these symbols
    local symbols = new_ekv_table {
        '(',
        ')',
        '[',
        ']',
        ',',
        ':',
        '<',
        '>',
        '.',
        '?'
    }

    local keywords = new_ekv_table {
        'const',
        --'public',
        --'private',
        --'static'
    }

    local Token = {}
    function Token.new(type, lexme, literal)
        return setmetatable({
            type = type;
            lexme = lexme;
            literal = literal;
        }, {
            __tostring = function(self)
                return self.type .. '\t' .. self.lexme .. '\t' .. tostring(literal)
            end
        })
    end



    local tokenize_key;
    do
        local pos = 0
        local chars = {}
        local tokens = {}

        local function next_char()
            if pos+1 <= #chars then
                pos = pos+1
                return chars[pos]
            end
        end

        local function peek()
            if pos+1 <= #chars then
                return chars[pos+1]
            end
        end

        local function create_token(type, lexme, lit)
            tokens[#tokens+1] = Token.new(type, lexme, lit)
        end

        tokenize_key = function(key)
            pos = 0
            chars = {}
            tokens = {}

            for c in key:gmatch('.') do
                chars[#chars+1] = c;
            end

            local char = next_char()
            -- tokenizer loop
            while char ~= nil do
                if not symbols[char] then
                    -- search for keyword
                    if is_alpha(char) then
                        local lexme = char;
                        -- identifier or keyword
                        if peek() then
                            if is_alpha_numerical(peek()) then
                                -- get complete word until it's no longer alpha_numerical
                                char = next_char()
                                while is_alpha_numerical(char) do
                                    lexme = lexme .. char
                                    char = next_char()
                                end
                            else
                                char = next_char()
                            end                     
                        end

                        -- now check lexme against keywords table
                        if keywords[lexme] then
                            -- create keyword token
                            create_token(lexme, lexme)
                        else
                            -- create identifier token
                            create_token('ID', lexme)
                        end
                    elseif tonumber(char) then
                        -- make number token
                        local lexme = char;
                        if peek() then
                            if tonumber(peek()) then
                                char = next_char()

                                while tonumber(char) do
                                    lexme = lexme .. char;
                                    char = next_char()
                                end
                            else
                                char = next_char()
                            end
                        end
                        create_token('NUMBER', lexme, tonumber(lexme))
                    elseif is_whitespace(char) then
                        char = next_char()
                    end
                elseif symbols[char] then
                    -- Create token
                    create_token(char, char)
                    char = next_char()
                else
                    error('Unknown character \'' .. char .. '\'.')
                end
            end

            --for i, v in next, tokens do print(i,v) end
        -- print()

            return tokens;
        end
    end



    -- PARSER --

    -- short hand datatype names
    local shorthand_dts = {
        ['str'] = 'string',
        ['num'] = 'number',
        ['fn'] = 'function',
        ['tab'] = 'table',
        ['bool'] = 'boolean',
        ['usd'] = 'userdata',
        ['thr'] = 'thread'
    }


    -- parse_key()
    do
        local pos = 0
        local tokens = {};
        --local ntokens = 0;
        local token;

        local raw_key = ''
        local new_key = ''
        local root_container;

        local function next_token()
            if pos+1 <= #tokens then
                pos = pos+1
                return tokens[pos]
            end
        end

        local function found(token_type)
            if token then
                if token.type == token_type then
                    return true
                end
            end
        end

        local function consume(token_type)
            if token.type == token_type then
                local t = token
                token = next_token()
                return t
            else
                error('Got \'' .. token.type .. '\' instead of \'' .. token_type .. '\' in \'' .. raw_key .. '\'')
            end
        end

        
        local function resolve_dt(dt)
            if primitive_dts[dt] or shorthand_dts[dt] then
                -- datatype name
                return primitive_dts[dt] or shorthand_dts[dt]
            end
            -- assume class name
            return dt
        end

            -- statement           = const_declaration   |
            --                       key_declaration
            
            -- const_declaration   =   'const' key_declaration

            -- key_declaration     =   var_declaration |
            --                         fn_declaration  

            -- var_declaration     =   ID ':' type_expression
            -- fn_declaration      =   ID '(' fn_type_expression... ')'

            -- fn_type_expression  =   type_expression ['...']

            -- type_expression     =   array_expression    |
            --                         table_expression    |
            --                         datatype

            -- array_expression    =   '[' [NUMBER ',']... ']' type_declaration
            -- table_expression    =   'table<' datatype [',' datatype] '>'
            -- datatype            =   ID ['?']


            -- * expressions return a container
        local type_expression;

        -- datatype    =   ID ['?']

        local function datatype(container)
            container = Container.datatype(container);

            local dt = resolve_dt(consume 'ID'.lexme);
            container.dt = dt;
 
            if found '?' then
                consume '?'
                container = Container.optional(container)
            end

            return container;
        end

        -- array_expression    =   '[' [NUMBER ',']... ']' type_expression
        local function array_expression(container)
            -- apply array modifier
            container = Container.array(container)
            container.raw_key = raw_key;

            consume '['

            -- current dimension
            local current_dim = 1;
            container.dimensions[current_dim] = -1 -- infinite size
            
            while true do
                if found 'NUMBER' then
                    -- dimension size
                    container.dimensions[current_dim] = tonumber(consume 'NUMBER'.lexme);
                elseif found ',' then
                    consume ','

                    current_dim = current_dim + 1;
                    container.dimensions[current_dim] = -1; -- infinite size
                elseif found ']' then
                    break
                else
                    error('Invalid array expression in \'' .. raw_key .. '\'')
                    break
                end
            end

            consume ']'

            return container
        end


        -- table_expression    =   'table<' type_expression [',' type_expression] '>'
        local function table_expression(container)
            -- 'table' in type_expression
            container.dt = resolve_dt(consume 'ID'.lexme);
            
            if found '<' then
                consume '<'
                -- get type name
                local dt = Container.datatype()
                dt.raw_key = raw_key;
                dt = type_expression(dt);

                -- check if there's another typename
                if found ',' then
                    -- is a dictionary
                    consume ','
                    container = Container.dictionary(container)
                    container.key_dt = dt.dt;
                    container.key_optional = dt.optional;

                    local val_dt = Container.datatype()
                    val_dt.raw_key = raw_key;
                    val_dt = type_expression(val_dt);

                    container.val_dt = val_dt.dt;
                    container.val_optional = val_dt.optional;
                else
                    -- is an 1D array
                    container = Container.array(container)
                    container.dt = dt.dt;
                    container.dimensions[1] = -1;
                end

                consume '>'
            end
            
            if found '?' then
                -- datatype()
                consume '?'
                container = Container.optional(container);
            end

            return container
        end

        -- type_expression     =   array_expression    |
        --                         table_expression    |
        --                         datatype
        type_expression = function(container)
            if found '[' then
                -- array --
                container = array_expression(container)

                -- get array datatype
                local val_dt = type_expression(container)
                container.val_dt = val_dt.dt;
                container.val_optional = val_dt.optional;
            elseif found 'ID' then
                -- check if id is 'table'
                if resolve_dt(token.lexme) == 'table' then
                    -- table expression
                    container = table_expression(container);
                else
                    -- resolve datatype
                    container = datatype(container)
                end
            else
                error('Expected a type_expression in \'' .. container.raw_key .. '\'')
            end
            return container
        end

        -- var_declaration     =   ID ':' type_expression
        local function var_declaration()
            consume ':'

            root_container = type_expression(root_container);

            -- apply var modifier
            root_container = Container.var(root_container)
        end

        -- fn_type_expression  =   type_expression ['...']
        local function fn_type_expression(container)
            container = type_expression(container);
            -- check for vargs
            if found '.' then
                consume '.'
                consume '.'
                consume '.'

                -- apply modifier
                container = Container.vargs(container)
            end

            return container;
        end

        -- fn_declaration      =   ID '(' fn_type_expression... ')'
        local function fn_declaration()
            consume '('

            -- apply fn modifier
            root_container = Container.fn(root_container)

            while not found ')' do
                if found 'ID' or found '[' then
                    -- param
                    local datatype = Container.datatype();
                    datatype.raw_key = raw_key;

                    local container = fn_type_expression(datatype);
                    root_container.params[#root_container.params+1] = container;

                    -- if there are variable arguments, there can be no more parameters.
                    if container.vargs then
                        if found ')' then
                            break;
                        else
                            error('Cannot have additional parameters after a variable argument declaration in \'' .. raw_key .. '\'')
                        end
                    end

                    if found ',' then
                        consume ','
                    elseif found 'ID' then
                        error('Was expecting \')\' not \'' .. token.lexme .. '\' in \'' .. raw_key)
                    end
                elseif found ',' then
                    -- for 'any' shorthand
                    consume ','
                    -- create a container for an undefined param
                    local container = Container.datatype()
                    container.raw_key = raw_key;
                    -- define as any
                    container.dt = 'any';

                    root_container.params[#root_container.params+1] = container
                elseif found '.' then
                    -- any argument varg
                    local container = Container.datatype();
                    container.raw_key = raw_key;

                    -- eat '...'
                    consume '.'
                    consume '.'
                    consume '.'

                    -- apply modifier
                    container = Container.vargs(container)

                    root_container.params[#root_container.params+1] = container
                    break;
                else
                    -- error b/c then there should be a ')'
                    error('Found \''.. token.lexme .. '\' instead of \')\' in \'' .. raw_key);
                end
            end

            consume ')'
        end

        -- key_declaration     =   var_declaration |
        --                         fn_declaration  
        local function key_declaration()
            new_key = consume 'ID' .lexme

            if found ':' then
                var_declaration()
            elseif found '(' then
                fn_declaration()
            end

            -- ret is already set to value so don't worry about handling if nothing's there, it'll return the original value.
        end

        -- const_declaration   =   'const' key_declaration
        local function const_declaration()
            consume 'const'
            
            key_declaration();

            -- apply modifiers
            root_container = Container.const(root_container)
        end

        -- statement           = const_declaration   |
        --                       key_declaration
        local function statement()
            if found 'const' then
                const_declaration()
            elseif found 'ID' then
                key_declaration()
            end
        end

        parse_key = function(key, val)
            if  key:find(':') or 
                key:find('%(') or 
                key:sub(1, 6) == 'const ' then
                pos = 0
                raw_key = key
                new_key = key

                root_container = Container.new();
                root_container.raw_key = raw_key;
                root_container.key = key;

                tokens = tokenize_key(key)
                --ntokens = n_of_items_in(tokens)
                token = next_token()
                if token then
                    -- start statement
                    statement()
                end

                -- check type
                check_type(root_container, val)
                -- set value
                root_container.val = val;

                return new_key, root_container
            else
                return key, val
            end
        end
    end


    --[[
        table<Container>    parse_keys(table members)
        - parses all keys within [members]
    --]]
    parse_keys = function(members)
        local new_members = {}
        for key, val in next, members do
            new_key, new_val = parse_key(key, val)
            new_members[new_key] = new_val;
        end
        return new_members;
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for sorting members
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
local sort_members;
do
    local instance_members
    local static_members
    local meta

    local function determine_inst_or_stat(key)
        local first = key:sub(1, 1)
        if first == first:upper() then
            return static_members
        else
            return instance_members
        end
    end

    local function determine(key, member)
        if key:sub(1, 2) == '__' then
            -- Is meta
            meta[key] = member;
        elseif key:sub(1, 1) == '_' then
            -- Is private
            determine_inst_or_stat(key:sub(2)).private[key] = member;
        else
            -- Is public
            determine_inst_or_stat(key).public[key] = member;
        end
    end

    sort_members = function(members)
        instance_members = {public = {}; private = {};}
        static_members = {public = {}; private = {};}
        meta = {}

        for key, member in next, members do
            determine(key, member)
        end

        return instance_members, static_members, meta
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for auxiliary class functions
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for constructing the instance
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
local function merge_members(members)
    return merge(members.public, members.private)
end

--[[
    Objects are created by calling [class]([class arguments]).


    - When an object is created, the super class is not instantiated until __init(self) calls
    self.super() for the first time.
        + Then self.super will refer to the super's instance.


--]]
local Object = {};

function Object.new(class, init_args, child_pointer)
    -- shared variables
    local class_hierarchy = rawget(class, '_hierarchy')
    local class_type = rawget(class, '_type')
    local meta = rawget(class, '_meta')
    local instance_members = rawget(class, '_instance_members')

    local super_class = rawget(class, '_super');

    -- members is a reference table of methods and variables from class and super classes.
    local members = merge_members(instance_members);

    -- self_pointer is the interface between the user and the object.
    local self_pointer;
    -- self_members holds all independent data for self.
    local self_members = {};

    local super_initialized = false;

    -- idea:
    -- the self_pointer is passed around administers alterations are made to self_members.
    -- this way, we don't have to whole new objects for super classes, just pass the child's
    -- self pointer through it
    -- this saves a ton of memory :)

    if child_pointer then
        -- merge child_pointer._members with our members
        rawset(child_pointer, '_members', merge(rawget(child_pointer, '_members'), members));

        -- set next super class
        rawset(child_pointer, '_next_super', super_class);

        -- call init
        if _typeof(meta.__init) == 'Container' then
            get_container_value(nil, meta.__init, function(container, args)
                container.val(child_pointer, unpack(args))
            end)(unpack(init_args))
        else
            meta.__init(child_pointer, unpack(init_args))
        end

        super_initialized = true;

        return;
    end

    -- Otherwise... --
    local function get_member(key)
        if _typeof(members[key]) ~= 'nil' then
            return members[key]
        elseif _typeof(self_members[key]) ~= 'nil' then
            return self_members[key]
        end
    end
 
    -- Create a self pointer for instance members
    local function on_pointer_index(pointer, key)
        if key ~= 'super' then
            local obj = get_member(key)
            local obj_t = _typeof(obj)

            if obj_t == 'Container' then
                return get_container_value(pointer, obj, function(container, args)
                    -- all args checked out, call function
                    return container.val(pointer, unpack(args))
                end)
            elseif obj_t == 'function' then
                return function(...)
                    local args = {...}
                    if args[1] == pointer then args = slice_t(args, 2, #args) end
            
                    return obj(pointer, unpack(args))
                end
            end
            return obj
        else
            return function(...)
                if rawget(pointer, '_next_super') then
                    if not super_initialized then
                        local super_args = {...}
                        if super_args[1] == self_pointer then super_args = slice_t(super_args, 2, #super_args) end

                        Object.new(rawget(pointer, '_next_super'), super_args, pointer)
            
                        -- done.
                        super_initialized = true;
                    else
                        -- Index super's get member
                        print 'index super'
                    end
                else
                    error('Class \'' .. class_type .. '\' does not have a super class!');
                end
            end
        end
    end

    local function on_pointer_newindex(pointer, key, val)
        local container = get_member(key)

        if _typeof(container) ~= 'Container' then
            -- parse key
            new_key, new_val = parse_key(key, val);

            -- set to self members
            self_members[new_key] = new_val;
        else
            -- set to self members
            self_members[key] = set_container_value(container, val);
        end
    end
    
    -- CREATE SELF OBJECT --
    self_pointer = setmetatable({
        _next_super = super_class;
        _members = members;
    }, {
        __index = on_pointer_index;
        __newindex = on_pointer_newindex;
    })

    -- call init
    if _typeof(meta.__init) == 'Container' then
        get_container_value(nil, meta.__init, function(container, args)
            container.val(self_pointer, unpack(args))
        end)(unpack(init_args))
    else
        meta.__init(self_pointer, unpack(init_args))
    end

    -- unpack all meta data from containers 
    -- (will make exceptions for comparison operations)
    do
        local temp_meta = {}
        for i, v in next, meta do
            temp_meta[i] = get_raw_val(v);
        end
        meta = temp_meta;
    end
    
    -- If there's no child_pointer, create a new object.

    return setmetatable({
        _hierarchy = rawget(class, '_hierarchy');
    }, merge({
        __type = class_type;
        __index = function(self, key)
            local obj 
            if key:sub(1, 1) ~= '_' then
                obj = get_member(key);
            end

            local obj_t = _typeof(obj)

            if obj_t == 'Container' then
                local val = get_container_value(self, obj, function(container, args)
                    return container.val(self_pointer, unpack(args))
                end)
                return val
            elseif obj_t == 'function' then
                return function(...)
                    local args = {...}
                    if args[1] == self then args = slice_t(args, 2, #args) end
                    
                    return obj(self_pointer, unpack(args))
                end
            end

            return obj
        end;

        __newindex = function(self, key, val)
            if key:sub(1, 1) ~= '_' then
                local obj = get_member(key)
                if _typeof(obj) == 'Container' then
                    self_members[key] = set_container_value(obj, val);
                else
                    self_members[key] = val;
                end
            else
                error('Cannot set a private value!')
            end
        end;

        __tostring = function(self)
            if _typeof(meta.__tostring) == 'function' then
                return meta.__tostring(self_pointer);
            end

            return class_type
        end;
    }, meta))
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for constructing the base class
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
    --[[
        BaseClass is a lua-class that contains skeleton for any type of class.
        
        - Private members are prefixed with one underscore '_'
        - Meta members are prefixed with two underscores '__'
        - Static members are capitalized
        - Instance members are uncapitalized
        - ':' or '.' works the same for calling methods
        - Type declarations occur in keys
            + function declarations do not cut undefined parameters
                * skip defining a type by adding a comma: 'f(num,,str)'

        - Instantiate by calling [class]([class args])



        BaseClass.new(members, super_class)
            members <- super_class' members (pre-formatted)
            parse_keys(members)
                returns table<new_key, Container | any>
            sort_members(table<new_key, Container | any>)
                - 

    --]]
local BaseClass = {}
function BaseClass.new(members, super_class)
    local hierarchy = '';

    if super_class then
        --[[
            for inheritancee

            on __init(), the super's __init() has to be called.
            then we when cant find a member in this class, just index super and it'll index its super and so on.
        --]]
        hierarchy = rawget(super_class, '_hierarchy') .. '.';
    end

    -- parse_keys() returns a table mixed with Containers and real values
    -- (from entries that didn't use static typing)
    members = parse_keys(members)
    -- now we sort the members into public and private instance or static members (also meta)
    local instance_members
    local static_members
    local meta 
    instance_members, static_members, meta = sort_members(members)
    -- NOW! We can finally use these objects 

    -- Lets make some checks
    if not meta.__type then error('__type is not defined in class.') end
    assert(_typeof(meta.__type) == 'string', '__type is not a string.')

    local class_type = meta.__type;
    hierarchy = hierarchy .. class_type;

    -- clear out some meta entries
    meta.__index = nil;
    meta.__newindex = nil;

    -- especially this one
    meta.__metatable = nil;

    -- create a pointer for static members
    local create_static_pointer;
    do
        local function get_member(key)
            if _typeof(static_members.public[key]) ~= 'nil' then
                return static_members.public[key]
            elseif _typeof(static_members.private[key]) ~= 'nil' then
                return static_members.private[key]
            end
        end

        local function on_pointer_index(pointer, key)
            if key == 'super' then
                if super_class then
                    if _typeof(super_class[key]) == 'function' then
                        return function(...)
                            local args = {...}
                            if args[1] == pointer then args = slice_t(args, 2, #args) end
                            -- replace super's self with self pointer
                            return super_class[key](pointer, unpack(args));
                        end
                    end

                    return super_class[key]
                else
                    error('Class \'' .. class_type .. '\' does not have a super class!');
                end
            else
                local obj = get_member(key)
                local obj_t = _typeof(obj)

                if obj_t == 'Container' then
                    return get_container_value(pointer, obj, function(container, args)
                        -- all args checked out, call function
                        return container.val(pointer, unpack(args))
                    end)
                elseif obj_t == 'function' then
                    return function(...)
                        local args = {...}
                        if args[1] == pointer then args = slice_t(args, 2, #args) end
                
                        return obj(pointer, unpack(args))
                    end
                end
                return obj
            end
        end

        -- everything set on pointer is an instance member
        local function on_pointer_newindex(pointer, key, val)
            local container = get_member(key)
            if _typeof(container) ~= 'Container' then
                -- parse key
                local new_key, root_container
                new_key, root_container = parse_key(key, val)
                -- determine access
                static_members[determine_access(new_key)][new_key] = root_container;
            else
                static_members[determine_access(key)][key] = set_container_value(container, val)
            end
        end
        
        create_static_pointer = function()
            return setmetatable({}, {
                __index = on_pointer_index;
                __newindex = on_pointer_newindex;
            })
        end
    end

    local static_pointer = create_static_pointer();

    local class = setmetatable({
        -- we define this stuff for the Object class (everything must be individualized)
        _super = super_class;
        _hierarchy = hierarchy;
        _type = class_type;
        _instance_members = instance_members;
        _static_members = static_members;
        _meta = meta;
    }, {
        __type = type;

        -- index will retrieve public static members
        __index = function(self, key)
            local obj = self._static_members.public[key]
            local obj_t = _typeof(obj)

            if obj_t == 'Container' then
                local val = get_container_value(self, obj, function(container, args)
                    return container.val(static_pointer, unpack(args))
                end)

                -- if no container, check super
                if _typeof(val) == 'nil' and super_class then
                    return super_class[key]
                end

                -- return val
                return val;
            elseif obj_t == 'function' then
                return function(...)
                    local args = {...}
                    if args[1] == self then args = slice_t(args, 2, #args) end

                    return obj(static_pointer, unpack(args))
                end
            end
            return obj
        end;

        __newindex = function(self, key, val)
            local obj_t = _typeof(self._static_members.public[key])
            if obj_t == 'Container' then
                -- set container value
                self._static_members.public[key] = set_container_value(self._static_members.public[key], val)
            else
                -- set value
                self._static_members.public[key] = val;
            end
        end;

        __call = function(self, ...)
            if not meta.__init then error('__init is not defined in class \'' .. class_type ..'\'') end

            return Object.new(self, {...})
        end;
    })

    return class
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for exporting.
------------------------------------------------------------------------------------------------------------------------------------------------------------
local export = {};

export.typeof = _typeof;

function export.class(superClass)
    return function(members)
        return BaseClass.new(members, superClass)
    end;
end

function export.instanceof(obj, class_type)

end

return export
------------------------------------------------------------------------------------------------------------------------------------------------------------