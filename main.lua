-- Slash Key Definitions

SLASH_SABS_ = '/sabs'

function SlashCmdList.SABS(args, editBox)
	local command, arg = msg:match("^(%S*)%s*(.-)$")
	print("Your command was: " .. command)
	print("Your argument was: " .. arg)
end
	