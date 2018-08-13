# link-bot
A bot for having Link play songs in Majora's Mask. Uses Bizhawk's lua scripting capabilities. Right now only capable of playing a simple scale but the end goal is having him play arbitrary MIDI files.

TODO:

* Respect durations of notes in MIDI file
* Allow user to choose which track link should play
* Handle notes outside his range somehow. Auto-transcribing could work, but if the range is too big it just won't really work.
* Fix the dependency on copy-pasting LuaMidi into Bizhawk/Lua folder
