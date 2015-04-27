require "cjson"
require "string"
 
local token = read_config("token")

local msg = {
    Payload = nil,
}

function process_message()
    local ok, payload = pcall(cjson.decode, read_message("Payload"))
    if not ok then
        return -1
    end

    -- msg.Payload = string.format("%s %s %s %s", token, payload.time, read_message("Hostname"), payload.log)

    inject_message(token .. " " .. payload.time .. " " .. read_message("Hostname") .. " " .. payload.log)

    return 0
end
