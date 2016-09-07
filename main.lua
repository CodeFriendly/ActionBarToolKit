-- Slash Key Definitions
SLASH_ABTK1 = '/abtk'

if ( ActionBarToolKitDB == nil ) then
	ActionBarToolKitDB = {}
end

function SlashCmdList.ABTK(args, editBox)
	local command, arg = args:match("^(%S*)%s*(.-)$")
	if( command == 'save' ) then
		save_bar(arg)
	end
	if( command == 'load' ) then
		load_bar(arg)
	end
end
	
function save_bar(bar_number)
	local db = {}
	local first_button = bar_number * 12 - 11
	for button = first_button, first_button + 11
	do
		db = nil
		local type, id, sub_type, sub_id = GetActionInfo(button)
		db= {
			type=type,
			id=id,
			sub_type=sub_type,
			sub_id=sub_id}
		print(button .. ": " .. tostring(type) .. " - " .. tostring(id) .. " - " .. tostring(sub_type) .. " - " .. tostring(sub_id))
		ActionBarToolKitDB[button] = db
	end
end

function load_bar(bar_number)
	local first_button = bar_number * 12 - 11
	for button = first_button, first_button + 11
	do
		button_data = ActionBarToolKitDB[button] 
		restore_button(button,button_data)
	end
end

function restore_button(button, button_data)
	if ( button_data.type == 'spell') then
			PickupSpell(button_data.id)
			PlaceAction(button)
			ClearCursor()
	elseif ( button_data.type == 'item') then
		PickupItem(button_data.id)
		PlaceAction(button)
		ClearCursor()
	elseif ( button_data.type == 'macro') then
		PickupMacro(button_data.id)
		PlaceAction(button)
		ClearCursor()	
	elseif ( button_data.type == 'equipmentset') then
		PickupEquipmentSetByName(button_data.id)
		PlaceAction(button)
		ClearCursor()	
	elseif ( button_data.type == 'summonpet') then
		C_PetJournal.PickupPet(button_data.id)
		PlaceAction(button)
		ClearCursor()	
	elseif ( button_data.type == 'summonmount') then
		spell_id = ({ C_MountJournal.GetMountInfoByID(button_data.id) })[2]
		PickupSpell(spell_id)
		PlaceAction(button)
		ClearCursor()		
	elseif ( button_data.type == nil) then
		PickupAction(button) 
		ClearCursor()
	else
		print("Unhandled item type for button " .. button .. ": " .. button_data.type)
	end
end