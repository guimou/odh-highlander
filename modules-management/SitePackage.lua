function visible_hook(t)
	local restricted_packages = {
		"abaqus", 
		"allinea",
		"amber",
		"ansys",
		"cfour-mpi",
		"comsol",
		"cpmd",
		"ddt-cpu",
		"ddt-gpu",
		"demon2k",
		"dl_poly4",
		"feko",
		"fluent",
		"hfss",
		"ls-dyna",
		"ls-dyna-mpi",
		"ls-opt",
		"maker",
		"matlab",
		"oasys-ls-dyna",
		"orca",
		"starccm",
		"starccm-mixed",
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
	local restricted_available = os.getenv("CC_RESTRICTED") or "false"
	if (restricted_available ~= "true") then
		if (has_value(restricted_packages,moduleName)) then
			t['isVisible'] = false
			return
		end
	end
end

local hook      = require("Hook")
hook.register("isVisibleHook",  visible_hook)
