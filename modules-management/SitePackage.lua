function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

local all_available = os.getenv("ALL_MODULES_AVAILABLE")

function visible_hook(t)
        if (all_available == "true") then
                t['isVisible'] = true
                return
        end
	local available_packages = {
                "SciPy-bundle",
                "R",
                "RStudio-Server",
                "code-server"
        }
	local pathT = {}
        local moduleName = t.sn
        local fullName = t.fullName
        local fn = t.fn
        local posix = require "posix"
        local modulePath = pathT[moduleName] or pathT[fullName]
        if modulePath ~= nil then
                local ftype = posix.stat(modulePath,"type") or nil
                if ftype == nil then
                        t['isVisible'] = false
                        return
                end
        end
	if (has_value(available_packages,moduleName)) then
                t['isVisible'] = true
        else
                t['isVisible'] = false
        end
end


local hook      = require("Hook")
hook.register("isVisibleHook",  visible_hook)
