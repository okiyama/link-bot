--Originally ripped from https://github.com/peterkos/LuaMIDIGraphics/blob/master/MidiParser.lua
--but heavily edited
local MIDI = require("MIDI")

score = {}
score.scoreNotes = {}
local track = 3
local removeNonNotes

function score.new(filename)

	-- Load score from file
	local midiFile = io.open(filename, 'rb')
	local bytes = midiFile:read("*a")
	score.scoreNotes = MIDI.midi2score(bytes)
	midiFile:close()

	-- Sort by note start time rather than note end
	-- (midi2score() sorts by note end)
	table.sort(score.scoreNotes[track], function (e1, e2) return e1[2] < e2[2] end)

	score.scoreNotes = removeNonNotes(score.scoreNotes)
end


-- Print out info of notes
-- Precondition: removeNonNotes() called before this
function score.printNotes()

	console.log("[type, start, duration, chan, note, velocity]\n")

	for k, event in ipairs(score.scoreNotes) do
		console.log(string.format("%d %5s, %5s, %5s, %4s, %5s, %6s\n", k, event[1], event[2], event[3], event[4], event[5], event[6]))
	end

end


-- Returns new score of only note events
removeNonNotes = function(notesTable)

	local notesOnly = {}
	local numNotes = 1

	for i=1, #notesTable[track] do
		local currentEvent = notesTable[track][i]

		if (currentEvent[1] == "note") then
			notesOnly[numNotes] = currentEvent
			numNotes = numNotes + 1
		end
	end

	return notesOnly
end

return score
