---------------------
-- 30: OUTPUT PATH --
---------------------

debug([[//==================\\]])
debug([[|| 31-directory.lua ||]])
debug([[\\==================//]])

-- set the library directory according to tags

function apply_pathsubs(s)
	for bad, good in pairs(pathsubs) do
		s = s:gsub(bad, good)
	end
	return s
end

local function append(field, before, after)
	if not empty(field) then
		before = before or ''
		after = after or ''
		directory = directory .. apply_pathsubs(before) .. apply_pathsubs(field) .. apply_pathsubs(after)
	end
end

debug("computing output directory...")

directory = dir or ''
if empty(directory) then
	-- hi-res vs lo-res
	if library_dir then
		debug("assembling directory from tags...")
		directory = library_location .. library_dir
		-- music vs non-music TODO
		directory = directory .. '/music/'
		-- torrent vs non-torrent
		if torrent then
			directory = directory .. 'torrents/' 
			-- artist folder: construct from tags
			append(o.artist)
			directory = directory .. '/'
			-- album folder: copy from input
			local album_folder = input.path:match("/([^/]+)/[^/]+$")
			append(album_folder)
			directory = directory .. '/'
		else
			directory = directory .. 'non-torrents/'
			-- artist folder: construct from tags
			local album_artist = not empty(o.album_artist) and o.album_artist or
				(not empty(o.artist) and o.artist or 'Unknown Artist')
			append(album_artist)
			directory = directory .. '/'
			-- album folder: construct from tags
			if not empty(o.album) then
				append(o.date, '[', '] ')
				debug("appending album")
				append(o.album)
				directory = directory .. '/'
			end
		end
	else
		-- extract default directory from input path
		debug("extracting directory from input path...")
		directory = input.path:match("^(.+?/)[^/]+\\.[^.]+$")
	end
else
	debug("using given directory: '" .. dir .. "'")
end

-- ensure there is an ending slash
directory = directory:gsub("/$","") .. "/" or "./"

debug("computed output directory: '" .. directory .. "'")