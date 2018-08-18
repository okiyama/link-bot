--Originally ripped from https://github.com/peterkos/LuaMIDIGraphics/blob/master/MidiParser.lua
--but heavily edited
local MIDI = require("MIDI")

score = {}
local track = 3
local removeNonNotes
local getBpm
local getDurationMultiplier

function score.new(filename)

	-- Load score from file
	local midiFile = io.open(filename, 'rb')
	local rawScore = MIDI.midi2score(midiFile:read("*a"))
	midiFile:close()

	-- Sort by note start time rather than note end
	-- (midi2score() sorts by note end)
	table.sort(rawScore[track], function (e1, e2) return e1[2] < e2[2] end)

	score.ticksPerQuarterNote = rawScore[1]
	score.beatsPerMinute = getBpm(rawScore)
	score.framesPerBeat = 1 / (score.beatsPerMinute / 3600) --trust me
	score.scoreNotes = convertRawScoreToNotes(rawScore)
end


-- Print out info of notes
-- Precondition: removeNonNotes() called before this
function score.printNotes()
	console.log("Ticks per quarter note: " .. score.ticksPerQuarterNote)
	console.log("BPM: " .. score.beatsPerMinute)
	console.log("Frames per beat: " .. score.framesPerBeat)

	console.log("[type, start, duration, chan, note, velocity, durationMultiplier]\n")

	for k, event in ipairs(score.scoreNotes) do
		console.log(string.format("%d %5s, %5s, %5s, %4s, %5s, %6s, %5s\n", k,
		event["type"], event["start"], event["duration"], event["chan"], event["note"], event["velocity"], event["durationMultiplier"]))
	end

end


-- Returns new score of only note events
convertRawScoreToNotes = function(notesTable)
	local notesOnly = {}
	local numNotes = 1

	for i=1, #notesTable[track] do
		local currentEvent = notesTable[track][i]

		if (currentEvent[1] == "note") then
			local note = {
				["type"]=currentEvent[1],
				["start"]=currentEvent[2],
				["duration"]=currentEvent[3],
				["chan"]=currentEvent[4],
				["note"]=currentEvent[5],
				["velocity"]=currentEvent[6],
				["durationMultiplier"]=getDurationMultiplier(currentEvent, score.ticksPerQuarterNote)
			}
			notesOnly[numNotes] = note
			numNotes = numNotes + 1
		end
	end

	return notesOnly
end

getBpm = function(score)
	--[[
	"1": "table"
"2": "table"
"3": "table"
"4": "table"
loop through and look for "set_tempo"
	]]
	local microsecondsPerTick
	for i=1, #score[2] do
		local currentEvent = score[2][i]
		if(currentEvent[1] == "set_tempo") then
			microsecondsPerTick = currentEvent[3]
		end
		console.log(score[2][i])
	end

	if(microsecondsPerTick) then
		return 1 / (microsecondsPerTick / 60000000)
	end
end

--Gets a multiplier for the duration of this note where 1x = quarter note
getDurationMultiplier = function(noteEvent, ticksPerQuarterNote)
	return noteEvent[3] / ticksPerQuarterNote
end

return score
