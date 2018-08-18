--joypad.set just sends that button config along for that particular frame
--joypad.setanalog sends that value and keeps it until it's reset
--assuming 60 frames in a second

--Range is from B4 to F6

local Midi = require ('MIDI')
local midiInput = require("MidiParser")

notesToButtonsMap = {
	[71] = {["Z"] = "True",["A"] = "True"},
	[72] = {["Z"] = "True",["A"] = "True"},
	[73] = {["Z"] = "True",["A"] = "True"},
	[74] = {["A"] = "True"},
	[75] = {["R"] = "True",["A"] = "True"},
	[76] = {["Z"] = "True",["C Down"] = "True"},
	[77] = {["C Down"] = "True"},
	[78] = {["R"] = "True",["C Down"] = "True"},
	[79] = {["Z"] = "True",["C Right"] = "True"},
	[80] = {["Z"] = "True",["C Right"] = "True"},
	[81] = {["C Right"] = "True"},
	[82] = {["Z"] = "True",["C Left"] = "True"},
	[83] = {["C Left"] = "True"},
	[84] = {["R"] = "True",["C Left"] = "True"},
	[85] = {["Z"] = "True",["C Up"] = "True"},
	[86] = {["C Up"] = "True"},
	[87] = {["R"] = "True",["C Up"] = "True"},
	[88] = {["R"] = "True",["C Up"] = "True"},
	[89] = {["R"] = "True",["C Up"] = "True"}
}

notesToAnalogMap = {
	[71] = {["Y Axis"] = "-127"},
	[72] = {["Y Axis"] = "-40"},
	[73] = {["Y Axis"] = "0"},
	[74] = {["Y Axis"] = "0"},
	[75] = {["Y Axis"] = "0"},
	[76] = {["Y Axis"] = "0"},
	[77] = {["Y Axis"] = "0"},
	[78] = {["Y Axis"] = "0"},
	[79] = {["Y Axis"] = "-39"},
	[80] = {["Y Axis"] = "0"},
	[81] = {["Y Axis"] = "0"},
	[82] = {["Y Axis"] = "0"},
	[83] = {["Y Axis"] = "0"},
	[84] = {["Y Axis"] = "0"},
	[85] = {["Y Axis"] = "0"},
	[86] = {["Y Axis"] = "0"},
	[87] = {["Y Axis"] = "0"},
	[88] = {["Y Axis"] = "38"},
	[89] = {["Y Axis"] = "127"}
}


local function holdButtonsForFrames(buttons, frameCount)
	for i=1, frameCount do
		joypad.set(buttons, 1)
		emu.frameadvance()
	end
end

midiInput.new("tetris.midi")
local transposeErrorMessage = midiInput.autoTranspose(71, 89)

if(transposeErrorMessage) then
	console.log(transposeErrorMessage)
	return
end

midiInput.printNotes()

for i=1, #midiInput.scoreNotes do
	local currentNoteEvent = midiInput.scoreNotes[i]
	local note = currentNoteEvent["note"]
	local framesToHold = midiInput.framesPerBeat * currentNoteEvent["durationMultiplier"]

	joypad.setanalog(notesToAnalogMap[note], 1)
	holdButtonsForFrames(notesToButtonsMap[note], framesToHold)
end

while true do
	emu.frameadvance()
end
