local tab = {}
function get_constant(func, index)
	for i,v in pairs(getconstants(ola)) do
		if v == index or i == index then
			return i
		end
	end
	return false
end
tab.get_constant = get_constant

return tab 
