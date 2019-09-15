local keywords = {
	["[Tt]hread[s]?"] = "Threads",
	["[Tt]ask[s]?"] = "Tasks",
	["[Pp]arallel"] = "Parallelism",
	["[Pp]arallelism"] = "Parallelism",
	["[Pp]arallel [Pp]rogramming"] = "Parallel~Programming",
	["[Ww]ork[- ]?[Ss]tealing"] = "Work~Stealing",
	--["[Ww]ork[- ]?[Ss]plitting"] = "Work~Splitting",
	["[Rr]untime [Ss]ystem[s]?"] = "Runtime~Systems",
	["[Ll]oad [Bb]alancing"] = "Load~Balancing",
	["[Bb]alancing"] = "Load~Balancing",
	["[Cc]ommunication"] = "Communication",
	["[Mm]essage[- ]?[Pp]assing"] = "Message~Passing",
	["[Cc]hannel[s]?"] = "Channels",
	["[Ss]cheduling"] = "Task~Scheduling",
	["[Tt]ask [Ss]cheduling"] = "Task~Scheduling",
	["[Tt]ask [Pp]ool[s]?"] = "Task~Pools",
	["[Pp]ool[s]?"] = "Task~Pools",
	["[Mm]ulticore"] = "Multicore",
	["[Mm]any[-]?core"] = "Manycore",
	["[Mm]ultiprocessor[s]?"] = "Multiprocessor",
}

local filename = arg[1] or "index.markdown"
local file = assert(io.open(filename))
for line in file:lines() do
	for key, val in pairs(keywords) do
		for word in line:gmatch(key) do
			print(val)
		end
	end
end
file:close()
