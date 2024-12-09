function ConfigExists(filename, substr)
	-- Check if a file exists and if a string is present inside.
	local f = io.open(filename, "r")
	if f == nil then
		return false
	else
		return string.find(f:read("*all"), substr) ~= nil
	end
end
