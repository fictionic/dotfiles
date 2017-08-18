#!/bin/lua

-- like mediainfo but only for audio and only what *I* want to see

file = arg[1]

-- MEDIAINFO STUFF

mediainfo_results_raw = io.popen("mediainfo \"" .. file .. "\"", "r"):read("*all")
mediainfo_results_raw_general, mediainfo_results_raw_audio = mediainfo_results_raw:match("[^\n:]*\n(.-)\n\n[^\n:]*\n(.-)\n\n")
-- first do "General"
mediainfo_results_table_general = {}
for line in mediainfo_results_raw_general:gmatch("([^\n]+:[^\n]+)\n") do
	tag = {line:match("([^:]+[^ ]) +: (.*)")}
	mediainfo_results_table_general[tag[1]] = tag[2]
end
-- then do "Audio"
mediainfo_results_table_audio = {}
for line in mediainfo_results_raw_audio:gmatch("([^\n]+:[^\n]+)\n") do
	tag = {line:match("([^:]+[^ ]) +: (.*)")}
	mediainfo_results_table_audio[tag[1]] = tag[2]
end

mediainfo_extraction_table = {
	['Track name'] = 'title',
	['Track name/Position'] = 'track',
	['Track name/Total'] = 'track total',
	['Album/Performer'] = 'album artist',
	['Album'] = 'album',
	['Performer'] = 'artist',
	['Part'] = 'disc',
	['Part/Total'] = 'disc total',
	['Recorded date'] = 'date',
	['Format/Info'] = 'format',
	['File size'] = 'file size',
	['Genre'] = 'genre',
	['Bit rate'] = 'bit rate',
	['Bit rate mode'] = 'bit rate mode',
	['Channel(s)'] = 'channels',
	['Channel positions'] = 'channel positions',
	['Bit depth'] = 'bit depth',
	['Stream size'] = 'stream size',
	['Writing library'] = 'writing library',
}

-- DR14_TMETER STUFF

-- dr14_results_raw = io.popen("dr14_tmeter --quiet -f \"" .. file .. "\"", "r"):read("*all")
-- dynamic_range = dr14_results_raw:match("\nDR += (.-)\n")
-- peak_db = dr14_results_raw:match("\nPeak dB += (.-)\n")
-- rms_db = dr14_results_raw:match("\nRms dB += (.-)\n")
-- print(dynamic_range, peak_db, rms_db)

-- FFPROBE STUFF (exact number of samples)
ffprobe_results_raw = io.popen("ffprobe -v error -print_format default=noprint_wrappers=1 -show_entries stream=duration,sample_rate \"" .. file .. "\"", "r"):read("*all")
sample_rate_str = ffprobe_results_raw:match("sample_rate=([^\n]+)")
exact_duration_str = ffprobe_results_raw:match("duration=([^\n]+)")
exact_duration = tonumber(exact_duration_str)
sample_rate = tonumber(sample_rate_str)
x = exact_duration * sample_rate
number_of_samples = (x%2 ~= 0.5 and math.floor(x+0.5)) or x-0.5
print(number_of_samples)
