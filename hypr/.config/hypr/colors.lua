local path = os.getenv("HOME") .. "/.config/hypr/colors.conf" -- adjust to the generated file
local c = {}

local f = io.open(path, "r")
if f then
	for line in f:lines() do
		local name, value = line:match("^%s*%$([%w_]+)%s*=%s*(.-)%s*$")
		if name then
			c[name] = value
		end
	end
	f:close()
end

return c
