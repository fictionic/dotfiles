--
-- like mediainfo but only for audio and only info that *I* want to see
--

--------------
-- GET INFO --
--------------
local function get_info(file)

	output_table_master = {
		['tags'] = {},
		['audio'] = {},
		['file'] = {}
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
			{'Replay gain', 'ReplayGain'},
			{'Replay gain peak', 'ReplayGain peak'},
		},
		['file'] = {
			{'Complete name', 'file path'},
			{'File size', 'file size'},
			{'Stream size', 'stream size'},
			{'Format/Info', 'format'},
			{'Writing library', 'codec library'},
			{'Writing application', 'encoder'},
			{'Bit rate mode', 'bitrate mode'},
			{'Bit rate', 'bitrate'},
		}
	}

	for name, mediainfo_extraction_table in pairs(mediainfo_extraction_table_master) do
		for _, pair in pairs(mediainfo_extraction_table) do
			badname = pair[1]
			goodname = pair[2]
			value = mediainfo_results_table[badname]
			if value then
				-- tiny fixes
				if badname == 'Bit rate mode' then
					value = value:lower() -- Variable -> variable
				elseif badname == 'Bit rate' then
					value = value:gsub(' ', '') -- N NNNN kb/s -> NNNN kbps
					value = value:gsub("kb/s", " kbps")
				end
				table.insert(output_table_master[name], {goodname, value})
			end
		end
	end

	-- FFPROBE STUFF
	ffprobe_results_raw = io.popen("ffprobe -v error -print_format default=noprint_wrappers=1 -show_entries stream=duration,sample_rate \"" .. file .. "\"", "r"):read("*all")
	-- exact number of samples
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
	table.insert(output_table_master.audio, {'RMS dB', rms_db})
	table.insert(output_table_master.audio, {'peak dB', peak_db})
	table.insert(output_table_master.audio, {'dynamic range', dynamic_range})

	return output_table_master
end

------------------
-- PRINT OUTPUT --
------------------

local function display_output(output_table_master)
	output_table_order = {
		{'TAGS', output_table_master.tags},
		{'AUDIO', output_table_master.audio},
		{'FILE', output_table_master.file}
	}
	-- desired output width in characters
	total_width = 52
	-- longest field name to be displayed
	left_width = 17 -- 'channel positions'
	-- room for displaying values
	right_width = total_width - left_width - separator:len()
	-- print a section of output
	function display_table(output_table)
		ret = ''
		for _, pair in ipairs(output_table) do
			name = pair[1]
			value = pair[2]
			ret = ret .. name .. ": " .. value .. '\n'
		end
		return ret
	end
	-- print all sections
	ret = ''
	for _, pair in ipairs(output_table_order) do
		name = pair[1]
		output_table = pair[2]
		ret = ret .. name .. '\n'
		ret = ret .. display_table(output_table) .. '\n\n'
	end
	return ret
end

-- get album art using mpd-albumart.sh
function get_album_art(file)
	return io.popen("/home/dylan/scripts/mpd-albumart.sh \"" .. file .. "\"", "r"):read("*line")
end

if arg then
	file = arg[1]
	print(display_output(get_info(file)))
	album_art_file = get_album_art(file)
	if album_art_file == '' then
		print("no album art found")
	else
		print("album art:")
		print(album_art_file)
	end
else
	file = '/home/dylan/audio/library/hi-res/' .. io.popen("mpc -f %file% current"):read("*line")

	conky_has_album_art = function()
		return tostring(album_art_file ~= '')
	end

	conky_display_info = function() 
		info = get_info(file)
		output_table_order = {
			{'TAGS', output_table_master.tags},
			{'AUDIO', output_table_master.audio},
			{'FILE', output_table_master.file}
		}
		-- desired output width in characters
		total_width = 52
		-- longest field name to be displayed
		left_width = 17 -- 'channel positions' is the longest field name
		separator = ": "
		-- room for displaying values
		right_width = total_width - left_width - separator:len()
		-- print a section of output
		function display_table(output_table)
			ret = ''
			for _, pair in ipairs(output_table) do
				name = pair[1]
				value = pair[2]
				-- shorten the file path
				if name == "file path" then
					value = value:gsub("/home/dylan/audio/library/hi-res/", "")
				end
				ret = ret .. name .. ": " .. value .. '\n'
			end
			return ret
		end
		-- print all sections
		ret = ''
		for _, pair in ipairs(output_table_order) do
			name = pair[1]
			output_table = pair[2]
			ret = ret .. name .. '\n'
			ret = ret .. display_table(output_table) .. '\n\n'
		end
		return ret
	end

	conky_test = function()
		return "blah ${scroll wait 33 10 1 /home/dylan/audio/library/hi-res/music/non-torrents/65daysofstatic/[2004-09-20] The Fall of Math/1.07. This Cat Is a Landmine.flac}"
	end

end

