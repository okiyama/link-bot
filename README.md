# link-bot
A bot for having Link play songs in Majora's Mask. Uses Bizhawk's lua scripting capabilities.
Currently capable of loading up a MIDI with one track that only plays one note at a time then playing it.
Will also attempt to automatically transpose to fit in Link's range if the provided MIDI is too high or too low.

Note to self:
To get this running, load Bizhawk(must have LuaMidi in the Bizhawk/Lua folder). Open scripts and choose link_bot.lua
from the project folder. Modify link_bot.lua to call midiInput.new("twinkle_twinkle_top.mid", 1) substituting in correct
values. 1 is track number, file is file.

TODO:

* Allow user to choose which track link should play
* Handle chords on one track somehow
* Play more complex songs and make a video out of it. This should include the controller inputs.
