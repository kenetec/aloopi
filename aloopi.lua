--[[
    aloopi by Kendall Hester
    
    Another Lua OOP Implementation
--]]
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POSSIBLE OPTIMIZATIONS: 
    -- make new objects directly, don't call a function.
-- TODO: Allow for specific classes for optional optimization.
    -- 'aloopi.instance_class() {}'
    -- 'aloopi.static_class() {}'
    -- 'aloopi.abstract_class() {}'
-- TODO: Only lowercase named functions are instance members, everything else is static.
-- TODO: Optimize container system
    -- Removed classes
-- TODO: Optimize lexer
    -- Removed alot of functions
-- TODO: Optimize parser
    -- Made objects directly, removed Container class
-- TODO: Optimize checkers
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
    table   slice_t(table t, number slice_start, number slice_stop)
    - Returns a sliced copy of [t].
--]]
local function slice_t(t, slice_start, slice_stop)
    local T = {}
    local Ti = 1;
    for i = slice_start, slice_stop do
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

-- used to identify classes
local BaseClass = {}

local function is_a_class(o)
    local type = typeof and typeof or type;
    local t = type(o)

    if t == 'table' then
        -- check if is a class
        if rawget(o, '__baseclass') == BaseClass then
            return true
        end
    end
end

local function _typeof(o)
    -- see if typeof is already defined(ROBLOX)
    local type = typeof and typeof or type;
    local t = type(o)

    if t == 'table' then
        -- check if is a class
        if rawget(o, '__baseclass') == BaseClass then
            return rawget(o, '__name')
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
-- base container {
--     ct: string
--         type of container
--             types
--                 fn
--                 var
--                 array
--                 datatype
--                 dictionary
    
--     dt: string
--         datatype of value
-- }

-- [optionals]
--     optional: bool
--         if can be nil or not
    
--     const: bool
--         if cannot be re-set
    
--     vargs: bool
--         if has '...' suffix

-- [types of container]
    -- root_container
        -- val: any
        --     value

        -- raw_key: string
        --     unparsed key

    -- var
        -- ct = 'var'
    
    -- fn
        -- ct = 'fn'
        -- dt = 'function'

        -- params: table<Containers>
        --     array of other containers without a value
    
    -- datatype
        -- ct = 'datatype';
        -- dt = '';

        -- optional: bool
        --      if value can be nil or not   
        
    -- array(datatype)
        -- ct = 'array'
        -- dt = 'table'

        -- val_dt: string
        --     datatype of array values

        -- val_optional: bool
        --     if values can be nil or not

        -- dimensions: table<num, size_of_dimension>
        --     table of dimensions with sizes.

    -- dictionary(datatype)
        -- ct = 'dictionary'
        -- dt = 'table',

        -- key_dt: string
        --     keys' datatype

        -- key_optional: bool
        --     if keys can be nil or not

        -- val_dt: string
        --     values' datatype

        -- val_optional: bool
        --     if values can be nil or not
    


-- example:
--     '__init(str, num, [,5]num)'
--         __init = {
--             ct = 'fn',
--             val = f,

--             params = {           <-- Containers
--                 {
--                     ct = 'datatype'
--                     dt = 'string'
--                 },
--                 {
--                     ct = 'datatype'
--                     dt = 'number'
--                 },
--                 {
--                     ct = 'array'
--                     dt = 'number'
--                     dimensions = {
--                         [1] = -1 -- -1 is infinite
--                         [2] = 5 -- size
--                     }
--                 }
--         }
local function check_array(container, arg, raw_key)
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
        error('Got: \'' .. _typeof(arg) .. '\' instead of an array of \'' .. container.dt .. '\' in \'' .. raw_key .. '\'')
    end
end

local function check_dictionary(container, arg, raw_key)
    local ct = container.ct;

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
                    error('Keys\' datatype is \'' .. _typeof(k) .. '\', not datatype \'' .. kdt .. '\' in \'' .. raw_key ..'\'')
                end
            end

            if _typeof(v) ~= vdt then
                if _typeof(v) == 'nil' and v_optional then
                    -- pass
                else
                    -- value error
                    error('Values\' datatype is \'' .. _typeof(k) .. '\', not datatype \'' .. kdt .. '\' in \'' .. raw_key ..'\'')
                end
            end
        end
    else
        error('Got: \'' .. _typeof(arg) .. '\' instead of a dictionary of \'' .. kdt .. '\' to \'' .. vdt .. '\' in \'' .. container.raw_key .. '\'')
    end
end

local function check_type(container, arg, raw_key)
    local ct = container.ct;
    local dt = container.dt;
    local at = _typeof(arg);

    if at == dt then
        if ct == 'array' then
            check_array(container, arg, raw_key)
        elseif ct == 'dictionary' then
            check_dictionary(container, arg, raw_key)
        end
    elseif at == 'nil' and container.optional then
        -- pass
    elseif dt == 'any' then
        -- pass
    else
        error('Got: \'' .. at .. '\' instead of \'' .. dt .. '\' in \'' .. raw_key .. '\'')
    end
end

local function check_vargs(container, args, raw_key)
    for arg_i, arg in next, args do
        check_type(container, arg, raw_key)
    end
end

local function get_value(ignore_self, container, on_fn_clear)
    if container.ct == 'fn' then
        -- wrap function to check for args datatypes
        return function(...)
            -- check if called with ':'
            local args = {...}

            if #args > 0 then
                -- remove pointer provided
                if ignore_self then
                    if args[1] == ignore_self then args = slice_t(args, 2, #args) end
                end

                if container.params then
                    -- check arg types
                    for i, param in next, container.params do
                        if param.vargs == true then
                            check_vargs(param, slice_t(args, i, #args), container.raw_key)
                            break;
                        else
                            check_type(param, args[i], container.raw_key)  
                        end      
                    end
                end
            end

            return on_fn_clear(container, args)
        end
    end
    return container.val
end

local function set_value(container, val)
    if not container.const then
        if container.ct ~= '' then
            -- check type
            check_type(container, val)
        end

        -- set value
        container.val = val;
    else
        error('Cannot change value of a constant!')
    end

    return container
end

local function determine_access(key)
    if (key:sub(1, 1) == '_') then
        -- Is private
        return 'private'
    else
        return 'public'
    end
end

local function parseable_key(k)
    return 
    k:find(':') or 
    k:find('%(') or 
    k:sub(1, 6) == 'const '
end


-- token_types:
--     'ID'
--     'NUMBER'
--      those symbols

-- tokens that are keywords or special characters will have the same type as their name
local parse_key;
local parse_keys;
do
    -- LEXER --
    -- Needs to be optimized

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
        --'static'
    }

    -- Token = {
    --     type: string
    --         Token type
    --     lexme: string 
    --         actual string
    -- };

    local function tokenize_key(key)
        local pos = 1
        local tokens = {}

        -- tokenizer loop
        local char = key:sub(pos, pos)
        while pos <= key:len() do
            if not symbols[char] then
                -- search for keyword

                -- is_alpha
                if is_alpha(char) then
                    local lexme = char;
                    local peeked = key:sub(pos+1, pos+1)
                    -- identifier or keyword
                    if peeked then
                        if is_alpha_numerical(peeked) then
                            -- get complete word until it's no longer alpha_numerical
                            pos = pos + 1;
                            char = key:sub(pos, pos)

                            while is_alpha_numerical(char) do
                                lexme = lexme .. char

                                pos = pos + 1;
                                char = key:sub(pos, pos)
                            end
                        else
                            pos = pos + 1;
                            char = key:sub(pos, pos)
                        end                     
                    end

                    -- now check lexme against keywords table
                    if keywords[lexme] then
                        -- create keyword token
                        tokens[#tokens+1] = {
                            type = lexme,
                            lexme = lexme
                        }
                    else
                        -- create identifier token
                        tokens[#tokens+1] = {
                            type = 'ID',
                            lexme = lexme
                        }
                    end
                elseif tonumber(char) then
                    -- make number token
                    local lexme = char;
                    local peeked = key:sub(pos+1, pos+1)

                    if peeked then
                        if tonumber(peeked) then
                            pos = pos + 1;
                            char = key:sub(pos, pos)

                            while tonumber(char) do
                                lexme = lexme .. char;

                                pos = pos + 1;
                                char = key:sub(pos, pos)
                            end
                        else
                            pos = pos + 1;
                            char = key:sub(pos, pos)
                        end
                    end
                    -- create number token
                    tokens[#tokens+1] = {
                        type = 'NUMBER',
                        lexme = lexme
                    }
                elseif char:match('^[ \t\n]$') then
                    -- if whitespace, skip
                    pos = pos + 1;
                    char = key:sub(pos, pos)
                end
            elseif symbols[char] then
                -- Create token
                tokens[#tokens+1] = {
                    type = char,
                    lexme = char
                }

                pos = pos + 1;
                char = key:sub(pos, pos)
            else
                error('Unknown character \'' .. char .. '\'.')
            end
        end

        return tokens;
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

                if pos+1 <= #tokens then
                    pos = pos+1
                    token = tokens[pos]
                end

                return t
            else
                error('Got \'' .. token.type .. '\' instead of \'' .. token_type .. '\' in \'' .. raw_key .. '\'')
            end
        end

        
        local function resolve_dt(dt)
            return primitive_dts[dt] or shorthand_dts[dt] or dt
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

        -- array_expression    =   '[' [NUMBER ',']... ']' type_expression
        local function array_expression(container)
            -- apply array modifier
            container.ct = 'array';
            container.dimensions = {};

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
            -- 'table'
            container.dt = resolve_dt(consume 'ID'.lexme);
            
            if found '<' then
                consume '<'
                -- get type name
                local first_type_name = type_expression();

                -- check if there's another typename
                if found ',' then
                    -- is a dictionary
                    consume ','
                    container.ct = 'dictionary';
                    container.key_dt = first_type_name.dt;
                    container.key_optional = first_type_name.optional;

                    local val_dt = type_expression();

                    container.val_dt = val_dt.dt;
                    container.val_optional = val_dt.optional;
                else
                    -- is an 1D array
                    container.ct = 'array';
                    container.val_dt = first_type_name.dt;
                    container.dimensions[1] = -1;
                end

                consume '>'
            end
            
            if found '?' then
                -- datatype()
                consume '?'
                container.optional = true;
            end

            return container
        end

        -- type_expression     =   array_expression    |
        --                         table_expression    |
        --                         datatype
        type_expression = function(container)
            container = container or {
                ct = 'datatype';
                dt = 'any';
            };

            if found '[' then
                -- array --
                container = array_expression(container)

                -- get array datatype
                local val_dt = type_expression()
                container.val_dt = val_dt.dt;
                container.val_optional = val_dt.optional;
            elseif found 'ID' then
                -- check if id is 'table'
                if resolve_dt(token.lexme) == 'table' then
                    -- table expression
                    container = table_expression(container);
                else
                    -- resolve datatype
                    local dt = resolve_dt(consume 'ID'.lexme);
                    container.dt = dt;
        
                    if found '?' then
                        consume '?'
                        container.optional = true;
                    end
                end
            else
                error('Expected a type_expression in \'' .. raw_key .. '\'')
            end
            return container
        end

        -- var_declaration     =   ID ':' type_expression
        local function var_declaration()
            consume ':'

            root_container = type_expression(root_container);

            -- apply var modifier
            root_container.ct = 'var'
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
                container.vargs = true;
            end

            return container;
        end

        -- fn_declaration      =   ID '(' fn_type_expression... ')'
        local function fn_declaration()
            consume '('
            -- apply fn modifier
            root_container.ct = 'fn';
            root_container.dt = 'function';
            root_container.params = {};

            while not found ')' do
                if found 'ID' or found '[' then
                    -- param
                    local container = fn_type_expression();

                    root_container.params[#root_container.params+1] = container;

                    -- if there are variable arguments, there can be no more parameters.
                    if container.vargs then
                        break;
                    end

                    if found ',' then
                        consume ','
                    elseif found 'ID' then
                        error('Was expecting \')\' not \'' .. token.lexme .. '\' in \'' .. raw_key)
                    end
                elseif found ',' then
                    -- for 'any' shorthand
                    consume ','

                    -- add 'any' datatype container
                    root_container.params[#root_container.params+1] = {
                        ct = 'datatype';
                        dt = 'any';
                    };
                elseif found '.' then
                    -- any argument varg

                    -- eat '...'
                    consume '.'
                    consume '.'
                    consume '.'

                    -- add container
                    root_container.params[#root_container.params+1] = {
                        ct = 'datatype';
                        dt = 'any';
                        vargs = true;
                    }

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

            -- apply modifier
            root_container.const = true;
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
            if parseable_key(key) then
                pos = 1
                raw_key = key
                new_key = key

                root_container = {
                    -- container type
                    ct = '';
                    -- datatype
                    dt = '';
                    -- unparsed key
                    raw_key = raw_key;
                    -- value
                    val = val;
                };

                tokens = tokenize_key(key)
                token = tokens[pos]

                -- start statement
                statement()

                -- when we finish parsing, check type
                if not root_container.const then
                    check_type(root_container, val)
                end

                return new_key, root_container
            else
                local t = _typeof(val)
                return key, {ct = t == 'function' and 'fn' or '', dt = t, raw_key = key, val = val}
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
            -- only parse if we find this
            local new_key, new_val;
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

-- -- sort_members
-- local function sort_members(members)
--     -- sorts members into public and private categories
--     local new_members = {
--         public = {};
--         private = {};
--     };

--     local meta = {};

--     for name, value in next, members do
--         if name:sub(1, 2) == '__' then
--             meta[name] = value;
--         else
--             new_members[determine_access(name)][name] = value;
--         end
--     end

--     return new_members, meta;
-- end
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for auxiliary class functions
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
local function merge_members(members)
    return merge(members.public, members.private)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for constructing a pointer
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
local function create_static_pointer(class, super_class)
    local static_members = class.__static_members;
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
                local obj = super_class.__get_static_member(key)
                if obj ~= nil then
                    return get_value(pointer, obj, function(container, args)
                        return container.val(pointer, unpack(args))
                    end)
                end

                return obj
            else
                error('Class \'' .. class_type .. '\' does not have a super class!');
            end
        else
            local obj = get_member(key)

            if obj ~= nil then
                return get_value(pointer, obj, function(container, args)
                    -- all args checked out, call function
                    return container.val(pointer, unpack(args))
                end)
            end
            return obj
        end
    end

    -- everything set on pointer is an instance member
    local function on_pointer_newindex(pointer, key, val)
        local container = get_member(key)
        if container ~= nil then
            -- parse key
            local new_key, root_container
            new_key, root_container = parse_key(key, val)
            -- determine access
            static_members[determine_access(new_key)][new_key] = root_container;
        end
    end
    
    return setmetatable({}, {
        __index = on_pointer_index;
        __newindex = on_pointer_newindex;
    })
end

-- create_instance_pointer
local function create_instance_pointer(class, super_class, on_index_rules)
    -- on_index_rules: tab<str, fn(pointer, key, self_members)>
    -- self_members is a copy of __prototype
    -- and holds all independent data for pointer

    -- the pointer will index in the following order:
    --     self_members
    --     __prototype
    --     super...

    -- copy values from class.__prototype
    local self_members = merge_members(deep_copy_t(class.__prototype))

    -- must deep_copy_t to remove any value references to the prototype
    -- local self_members = merge(
    --     merge_members(deep_copy_t(class.__prototype)), merge_members(class.__static_members))

    return setmetatable({
        __first_super = super_class;
        __next_super = super_class;
    }, {
        __index = function(pointer, key)
            -- test for on_index rules first
            if on_index_rules[key] then return on_index_rules[key](pointer, key, self_members) end;
            
            local container = self_members[key]
            if container == nil then
                if class.__prototype[key] then
                    -- check __prototype
                    container = class.__prototype[key]
                else
                    -- check super
                    container = pointer.__first_super.__get_instance_member(key)
                end
            end

            if container ~= nil then
                return get_value(pointer, container, function(container, args)
                    -- all args checked out, call function
                    return container.val(pointer, unpack(args))
                end)
            end
        end;

        -- on new index, everything should be set to self_member
        __newindex = function(pointer, key, val)
            local previous = self_members[key]

            if previous == nil then
                -- parse key
                new_key, new_val = parse_key(key, val);

                -- set to self members
                self_members[new_key] = new_val;
            else
                -- set to self members
                self_members[key] = set_value(previous, val);
            end
        end;
    }), self_members;
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for constructing the instance
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    Objects are created by calling [class]([class arguments]).


    - When an object is created, the super class is not instantiated until __init(self) calls
    self.super() for the first time.
        + Then self.super will refer to the super's instance.
--]]
function create_instance(class, init_args, child_pointer)
    local super_class = class.__super;
    local meta = class.__meta;

    -- members is a reference table of methods and variables from class.
    local members = class.__members;

    -- self_pointer is the interface between the user and the object.
    local self_pointer;
    local self_members;

    -- if super class has been intialized yet
    local super_initialized = false;

    self_pointer, self_members = create_instance_pointer(class, super_class, {
        ['super'] = function(pointer, key, self_members)
            if not super_initialized then
                return function(...)
                    if pointer.__next_super then
                        local super_args = {...}
                        if super_args[1] == pointer then super_args = slice_t(super_args, 2, #super_args) end

                        pointer.__next_super.__prototype_self(pointer, super_args)
                        --create_instance(super_class, super_args, pointer);
            
                        -- done.
                        super_initialized = true;
                    else
                        error('Class \'' .. class.__name .. '\' does not have a super class!');
                    end
                end
            else
                -- index super
                local container = super_class.__get_instance_member(key)
                if _typeof(container) ~= 'nil' then
                    return get_value(pointer, container, function(container, args)
                        return container.val(pointer, unpack(args))
                    end)
                end
                return container
            end
        end;
    })

    assert(meta.__init ~= nil, '\'__init\' does not exist in class \'' .. class.__name .. '\'')

    -- call init
    get_value(class, meta.__init, function(container, args)
        container.val(self_pointer, unpack(args))
    end)(unpack(init_args))

    -- unpack all meta data from containers 
    -- (will make exceptions for comparison operations)
    do
        local temp_meta = {}
        for i, c in next, meta do
            temp_meta[i] = c.val;
        end
        meta = temp_meta;
    end

    return setmetatable({
        __baseclass = class.__baseclass;
        __hierarchy = class.__hierarchy;
        __name = class.__name;
    }, merge({
        __index = function(self, key)
            if key:sub(1, 1) ~= '_' then
                obj = self_members[key];

                if _typeof(obj) == 'nil' and super_class then
                    -- get from super
                    obj = super_class.__get_instance_member(key)
                end

                if _typeof(obj) ~= 'nil' then
                    return get_value(self, obj, function(container, args)
                        return container.val(self_pointer, unpack(args))
                    end)
                end
            end
        end;

        __newindex = function(self, key, val)
            if key:sub(1, 1) ~= '_' then
                local previous = self_members[key]

                if previous == nil then
                    -- parse key
                    new_key, new_val = parse_key(key, val);

                    -- set to self members
                    self_members[new_key] = new_val;
                else
                    -- set to self members
                    self_members[key] = set_value(previous, val);
                end
            else
                error('Cannot set a private value!')
            end
        end;

        __tostring = function(self)
            if _typeof(meta.__tostring) == 'function' then
                return meta.__tostring(self_pointer);
            end

            return "instance '" .. self.__name .. "'"
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
local function create_base_class(name, members, super_class)
    --@ base classes are skeleton classes
    --@ no member sorting
    --@ no functionality

    name = name or '';
    
    -- parse_keys() returns a table mixed with "containers" and real values
    -- (from entries that didn't use static typing)
    members = parse_keys(members)

    local hierarchy = name ~= '' and name or '<anonymous>';
    if super_class then
        hierarchy = rawget(super_class, '__hierarchy') .. '.' .. hierarchy;
    end

    -- clear out some meta entries
    members.__index = nil;
    members.__newindex = nil;

    return {
        -- a reference to BaseClass, used to tell identify a class from a table
        __baseclass = BaseClass;
        __hierarchy = hierarchy;
        __name = name;

        __super = super_class;
        __members = members;
    }
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
local function create_complex_class(name, members, super_class)
    --@ Complex classes are classes that contain both instance and static members.
    local class = create_base_class(name, members, super_class);

    -- might change this
    -- local class = deep_copy_t(base_class)
    
    -- we sort the members into public and private instance or static members (also meta)
    local instance_members
    local static_members
    local meta 
    instance_members, static_members, meta = sort_members(class.__members)

    -- reset this
    class.__baseclass = BaseClass;
    class.__meta = meta;
    class.__static_members = static_members;
    -- prototype of instance
    class.__prototype = instance_members;

    class.__get_static_member = function(key)
        if (_typeof(static_members.public[key]) == 'nil'
            and _typeof(static_members.private[key]) == 'nil')
            and super_class then
            -- call super's __get()
            return super_class.__get_static_member(key)
        end

        return static_members.public[key] or static_members.private[key]
    end

    class.__get_instance_member = function(key)
        if (_typeof(instance_members.public[key]) == 'nil'
            and _typeof(instance_members.private[key]) == 'nil')
            and super_class then
            -- call super's __get()
            return super_class.__get_instance_member(key)
        end

        return instance_members.public[key] or instance_members.private[key]
    end

    -- takes self_pointer, changes next super and runs it through init function
    class.__prototype_self = function(pointer, proto_init_args)
        -- set next super
        pointer.__next_super = super_class;

        assert(meta.__init ~= nil, '\'__init\' does not exist in class \'' .. class.__name .. '\'')

        -- initialize
        get_value(nil, meta.__init, function(container, args)
            container.val(pointer, unpack(args))
        end)(unpack(proto_init_args))
    end

    -- static pointer
    local static_pointer = create_static_pointer(class, super_class)
    
    return setmetatable(class, {
        __index = function(class, key)
            local obj = static_members.public[key]

            if obj ~= nil then
                return get_value(class, obj, function(container, args)
                    return container.val(static_pointer, unpack(args))
                end)
            elseif super_class then
                return super_class[key]
            end
            return obj
        end;

        __newindex = function(class, key, val)
            -- set container value
            static_members.public[key] = set_value(static_members.public[key], val)
        end;

        __call = function(...)
            local args = {...}
            args = slice_t(args, 2, #args);

            return create_instance(class, {...})
        end;

        __tostring = function(self)
            return "complex class '" .. name .. "'";
        end;
    })
end
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    Instances are created by calling [class]([class arguments]).


    - When an instance is created, the super class is not instantiated until __init(self) calls
    self.super() for the first time.
        + Then self.super will refer to the super's instance.
--]]
local function create_instance_class(members, super)
    local class = create_base_class(members, super);
    -- meta checks
    if not class.__meta.__init then error('__init is not defined in class \'' .. class.__name ..'\'') end


    return setmetatable(class, {
        __call = function(...)
            local args = {...}
            args = slice_t(args, 2, #args);

            return create_instance(class, {...})
        end
    })
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
local function create_static_class()
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This section of the script is for exporting.
------------------------------------------------------------------------------------------------------------------------------------------------------------
local export = {};

export.typeof = _typeof;
export.is_a_class = is_a_class;

function export.class(name)
    assert(_typeof(name) == 'string', 'Class name must be a string!');

    return function(super_class)
        return function(members)
            assert(_typeof(members) == 'table', 'Class must have a members table!');

            return create_complex_class(name, members, super_class)
        end
    end
end

-- function export.interface(super_interface)
-- end
------------------------------------------------------------------------------------------------------------------------------------------------------------
function export.instanceof(obj, class_name)
    local hierarchy = rawget(obj, '__hierarchy');
    local list = {};
	local str = "";
	
	for char in string.gmatch(hierarchy, '.') do
		if (char ~= '.') then
			str = str..char;
        else
            if str == class_name then
                return true
            end
		end
	end
	
	if str == class_name then
        return true
    end

    return false;
end

function export.mixin(to, from)
end

return export
------------------------------------------------------------------------------------------------------------------------------------------------------------