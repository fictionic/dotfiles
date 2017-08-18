#!/bin/lua

-- like mediainfo but only for audio and only info that *I* want to see

file = arg[1]

output_table_master = {
	['tags'] = {},
	['audio'] = {},
	['file'] = {}
}

output_table_order = {
	{'TAGS', output_table_master.tags},
	{'AUDIO', output_table_master.audio},
	{'FILE', output_table_master.file}
}

-- MEDIAINFO STUFF

mediainfo_results_raw = io.popen("mediainfo \"" .. file .. "\"", "r"):read("*all")
mediainfo_results_table = {}
for line in mediainfo_results_raw:gmatch("([^\n]+:[^\n]+)\n") do
	tag = {line:match("([^:]+[^ ]) +: (.*)")}
	mediainfo_results_table[tag[1]] = tag[2]
end

mediainfo_extraction_table_master = {
	['tags'] = {
		{'Track name', 'title'},
		{'Album', 'album'},
		{'Part', 'disc'},
		{'Track name/Position', 'track'},
		{'Performer', 'artist'},
		{'Album/Performer', 'album artist'},
		{'Recorded date', 'date'},
		{'Composer', 'composer'},
		{'Track name/Total', 'track total'},
		{'Part/Total', 'disc total'},
		{'Genre', 'genre'},
	},
	['audio'] = {
		{'Bit depth', 'bit depth'},
		{'Channel(s)', 'channels'},
		{'Channel positions', 'channel positions'},
	},
	['file'] = {
		{'File size', 'file size'},
		{'Format/Info', 'format'},
		{'Bit rate', 'bit rate'},
		{'Bit rate mode', 'bit rate mode'},
		{'Stream size', 'stream size'},
		{'Writing library', 'writing library'},
	}
}

for name, mediainfo_extraction_table in pairs(mediainfo_extraction_table_master) do
	for _, pair in pairs(mediainfo_extraction_table) do
		badname = pair[1]
		goodname = pair[2]
		value = mediainfo_results_table[badname]
		if value then
			table.insert(output_table_master[name], {goodname, value})
		end
	end
end

-- FFPROBE STUFF
-- exact number of samples
ffprobe_results_raw = io.popen("ffprobe -v error -print_format default=noprint_wrappers=1 -show_entries stream=duration,sample_rate \"" .. file .. "\"", "r"):read("*all")
sample_rate_str = ffprobe_results_raw:match("sample_rate=([^\n]+)")
exact_duration_str = ffprobe_results_raw:match("duration=([^\n]+)")
exact_duration = tonumber(exact_duration_str)
sample_rate = tonumber(sample_rate_str)
x = exact_duration * sample_rate
number_of_samples = (x%2 ~= 0.5 and math.floor(x+0.5)) or x-0.5
-- exact duration in mm:ss.ff (f = float)
total_seconds_int = math.floor(exact_duration)
minutes = math.floor(total_seconds_int/60)
seconds = (total_seconds_int - minutes*60) + (exact_duration - total_seconds_int)
duration = minutes .. ":" .. seconds
table.insert(output_table_master.audio, {'duration', duration})
table.insert(output_table_master.audio, {'number of samples', number_of_samples})

-- DR14_TMETER STUFF

dr14_results_raw = io.popen("dr14_tmeter --quiet -f \"" .. file .. "\"", "r"):read("*all")
dynamic_range = dr14_results_raw:match("\nDR += (.-)\n")
peak_db = dr14_results_raw:match("\nPeak dB += (.-)\n")
rms_db = dr14_results_raw:match("\nRms dB += (.-)\n")
table.insert(output_table_master.audio, {'dynamic range', dynamic_range})
table.insert(output_table_master.audio, {'peak dB', peak_db})
table.insert(output_table_master.audio, {'RMS dB', rms_db})

-- PRINT OUTPUT --
------------------

function print_table(width, output_table)
	for _, pair in ipairs(output_table) do
		name = pair[1]
		value = pair[2]
		print(name .. ": " .. value)
	end
end
width = 52
for _, pair in ipairs(output_table_order) do
	name = pair[1]
	output_table = pair[2]
	print(name)
	print_table(width, output_table)
	print()
end
