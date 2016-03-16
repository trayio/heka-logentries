require "cjson"
require "string"
require "table"
 
containers = {}

local token = read_config("token")

function process_message()
    local differentiator = read_message("Logger") -- sent by 'differentiator' in logentries.toml
    local container_name = containers[differentiator]

    local ok, payload = pcall(cjson.decode, read_message("Payload"))
    if not ok then
       return -1
    end

    if payload.Name then
       containers[payload.ID] = payload.Name
       return -2 -- no output, but not error (see https://hekad.readthedocs.org/en/latest/sandbox/index.html#functions-that-must-be-exposed-from-the-lua-sandbox)
    end

    if not container_name then
       container_name = "unknown_container"
    elseif string.find(container_name, "RDAJR") then
       -- local split = {}
       -- for x in string.gmatch(container_name, "[^.]+") do
       --    table.insert(split, x)
       -- end
       -- container_name = split[2]
       return -2
    elseif string.find(container_name, "/") then
       container_name = string.gsub(container_name, "/", "", 1) -- docker prefixes container name with '/'
       if container_name == "logentries" then
          return -2
       end
    end


    inject_message(token .. " " .. payload.time .. " name=" .. container_name .. " " .. read_message("Hostname") .. " " .. payload.log)

    return 0
end
