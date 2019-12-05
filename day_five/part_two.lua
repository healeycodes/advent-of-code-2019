-- this is the first program I have ever written in Lua!
local filename = arg[1]

-- left pad a (s)tring to (l)ength by (c)har
local function lpad(s, l, c) return string.rep(c or ' ', l - #s) .. s end

-- accepts an int code program and an input
local function int_codes(instructions, input)
    local i = 1
    while i < #instructions do
        local op_code = lpad(tostring(instructions[i]), 5, '0')
        -- are parameters in position or immediate mode?
        local c = op_code:sub(3, 3) == '0'
        local b = op_code:sub(2, 2) == '0'
        local a = op_code:sub(1, 1) == '0'
        -- parameters
        local x = nil
        local y = nil
        local z = instructions[i + 3] -- writing will always be positional
        if c and i + 1 <= #instructions then
            x = instructions[instructions[i + 1] + 1]
        else
            x = instructions[i + 1]
        end
        if b and i + 2 <= #instructions then
            y = instructions[instructions[i + 2] + 1]
        else
            y = instructions[i + 2]
        end
        -- addition
        if op_code:sub(5, 5) == '1' then
            instructions[z + 1] = x + y
            i = i + 4
        end
        -- multiplication
        if op_code:sub(5, 5) == '2' then
            instructions[z + 1] = x * y
            i = i + 4
        end
        -- input
        if op_code:sub(5, 5) == '3' then
            instructions[instructions[i + 1] + 1] = input
            i = i + 2
        end
        -- output
        if op_code:sub(5, 5) == '4' then
            print('output: ' .. tostring(instructions[instructions[i + 1] + 1]))
            i = i + 2
        end
        -- halt!
        if op_code:sub(4, 5) == '99' then
            return
        end
        -- jump-if-true
        if op_code:sub(5, 5) == '5' then
            if x ~= 0 then
                i = y + 1
            else
                i = i + 3
            end
        end
        -- jump-if-false
        if op_code:sub(5, 5) == '6' then
            if x == 0 then
                i = y + 1
            else
                i = i + 3
            end
        end
        -- less than
        if op_code:sub(5, 5) == '7' then
            if x < y then
                instructions[z + 1] = 1
            else
                instructions[z + 1] = 0
            end
            i = i + 4
        end
        -- equals
        if op_code:sub(5, 5) == '8' then
            if x == y then
                instructions[z + 1] = 1
            else
                instructions[z + 1] = 0
            end
            i = i + 4
        end
    end
end

-- get file as string
local function read_file(path)
    local file = io.open(filename, 'rb') -- r read mode and b binary mode
    if not file then error('Couldn\'t read file!') end
    local content = file:read '*a' -- *a or *all reads the whole file
    file:close()
    return content
end

local program = {}
for v in read_file(filename):gmatch('([^,]+)') do
    table.insert(program, tonumber(v))
end

int_codes(program, 5)
