require "cjson"
require "string"
require "table"
 
containers = {}

local token = read_config("token")

function process_message()

   local msg = decode_message(read_message("raw"))
   local container_name = ""

   for _, v in pairs(msg.Fields) do
      if v.name == "ContainerName" then
         container_name = v.value[1]
         break
      end
   end

   -- don't log connector logs
   if string.find(container_name, "RDAJR") then
      return -2
   end

   inject_message(token .. " " .. msg.Timestamp .. " name=" .. container_name .. " " .. msg.Hostname .. " " .. msg.Payload .. "\n")

   return 0

end
