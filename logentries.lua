require "string"
require "os"
 
local token = read_config("token")

-- time from DockerLogInput is in nanoseconds which Lua can't handle
function date(timestamp)
   return os.date("%Y-%m-%dT%H:%M:%SZ", string.format("%.0f", timestamp / 1000000000))
end

function process_message()

   local msg = decode_message(read_message("raw"))
   local container_name = nil

   for _, v in pairs(msg.Fields) do
      if v.name == "ContainerName" then
         container_name = v.value[1]
         break
      end
   end

   if not container_name then
      container_name = "unknown_container"
   end
   
   -- don't log connector logs
   if string.find(container_name, "RDAJR") then
      return -2
   end

   local ok, timestamp = pcall(date, msg.Timestamp)
   if not ok then
      timestamp = os.date("%Y-%m-%dT%H:%M:%SZ")
   end
   
   inject_message(token .. " " .. timestamp .. " name=" .. container_name .. " " .. msg.Hostname .. " " .. msg.Payload .. "\r\n")

   return 0

end
