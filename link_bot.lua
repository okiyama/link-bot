--joypad.set just sends that button config along for that particular frame
--joypad.setanalog sends that value and keeps it until it's reset

--[[
resetTable["A"]="False"
resetTable["A Down"]="False"
resetTable["A Left"]="False"
resetTable["A Right"]="False"
resetTable["A Up"]="False"
resetTable["B"]="False"
resetTable["C Down"]="False"
resetTable["C Left"]="False"
resetTable["C Right"]="False"
resetTable["C Up"]="False"
resetTable["DPad D"]="False"
resetTable["DPad L"]="False"
resetTable["DPad R"]="False"
resetTable["DPad U"]="False"
resetTable["L"]="False"
resetTable["R"]="False"
resetTable["Start"]="False"
resetTable["Z"]="False"
]]

local Midi = require ('MIDI')
local midiInput = require("MidiParser")


notesToButtonsMap = {
	["B4"] = {["Z"] = "True",["A"] = "True"},
	["C5"] = {["Z"] = "True",["A"] = "True"},
	["C#5"] = {["Z"] = "True",["A"] = "True"},
	["D5"] = {["A"] = "True"},
	["D#5"] = {["R"] = "True",["A"] = "True"},
	["E5"] = {["Z"] = "True",["C Down"] = "True"},
	["F5"] = {["C Down"] = "True"},
	["F#5"] = {["R"] = "True",["C Down"] = "True"},
--	["G5"] = {["C Down"] = "True"},
	["G5"] = {["Z"] = "True",["C Right"] = "True"},
	["G#5"] = {["Z"] = "True",["C Right"] = "True"},
	["A5"] = {["C Right"] = "True"},
	["A#5"] = {["R"] = "True",["C Right"] = "True"},
	["A#5"] = {["Z"] = "True",["C Left"] = "True"},
	["B5"] = {["C Left"] = "True"},
	["C6"] = {["R"] = "True",["C Left"] = "True"},
	["B#6"] = {["R"] = "True",["C Left"] = "True"},
	["C#6"] = {["Z"] = "True",["C Up"] = "True"},
	["D6"] = {["C Up"] = "True"},
	["D#6"] = {["R"] = "True",["C Up"] = "True"},
	["E6"] = {["R"] = "True",["C Up"] = "True"},
	["Fb6"] = {["R"] = "True",["C Up"] = "True"},
	["F6"] = {["R"] = "True",["C Up"] = "True"}
}

notesToAnalogMap = {
	["B4"] = {["Y Axis"] = "-127"},
	["C5"] = {["Y Axis"] = "-40"},
	["C#5"] = {["Y Axis"] = "0"},
	["D5"] = {["Y Axis"] = "0"},
	["D#5"] = {["Y Axis"] = "0"},
	["E5"] = {["Y Axis"] = "0"},
	["F5"] = {["Y Axis"] = "0"},
	["F#5"] = {["Y Axis"] = "0"},
--	["G5"] = {["Y Axis"] = "127"},
	["G5"] = {["Y Axis"] = "-39"},
	["G#5"] = {["Y Axis"] = "0"},
	["A5"] = {["Y Axis"] = "0"},
	["A#5"] = {["Y Axis"] = "0"},
	["A#5"] = {["Y Axis"] = "0"},
	["B5"] = {["Y Axis"] = "0"},
	["C6"] = {["Y Axis"] = "0"},
	["B#6"] = {["Y Axis"] = "0"},
	["C#6"] = {["Y Axis"] = "0"},
	["D6"] = {["Y Axis"] = "0"},
	["D#6"] = {["Y Axis"] = "0"},
	["E6"] = {["Y Axis"] = "38"},
	["Fb6"] = {["Y Axis"] = "38"},
	["F6"] = {["Y Axis"] = "127"}
}

local function advanceOneSecond ()
	for i=1,20 do
		emu.frameadvance()
	end
end

local function holdButtonsForOneSecond (buttons)
	for i=1,20 do
		joypad.set(buttons, 1)
		emu.frameadvance()
	end
end

scale = {"B4", "C5", "D5", "E5", "F5", "G5", "A5", "B5", "C6", "D6", "E6", "F6"}

--[[
for i=1, #scale do
	note = scale[i]
	joypad.setanalog(notesToAnalogMap[note], 1)
	--console.log(joypad.get(1))
	holdButtonsForOneSecond(notesToButtonsMap[note])
	advanceOneSecond()
end
]]
midiInput.new("tetris.midi")
midiInput.printNotes()
--[[
cRight = {["C Right"] = "True"}
holdButtonsForOneSecond(cRight)
advanceOneSecond()
holdButtonsForOneSecond(cRight)
]]

while true do
	emu.frameadvance()
end
