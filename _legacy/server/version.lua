-- Branding!
local label =
[[ 
  
███████╗███████╗  ░██████╗░█████╗░██████╗░██╗██████╗░████████╗░██████╗
██╔════╝╚════██║  ██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
█████╗░░░░███╔═╝  ╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░╚█████╗░
██╔══╝░░██╔══╝░░  ░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░░╚═══██╗
███████╗███████╗  ██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░██████╔╝
╚══════╝╚══════╝  ╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░

]]

-- Returns the current version set in fxmanifest.lua
function GetCurrentVersion()
	return GetResourceMetadata(GetCurrentResourceName(), "version" )
end

-- Grabs the latest version number from the web GitHub
PerformHttpRequest( "https://raw.githubusercontent.com/EZ-Scripts/versions/main/"..GetResourceMetadata(GetCurrentResourceName(), "name" ), function( err, text, headers )
	-- Wait to reduce spam
	Citizen.Wait( 2000 )

	-- Print the branding!
	print( label )

	-- Get the current resource version
	local curVer = GetCurrentVersion()

	print( "Current version: " .. curVer )

	if ( text ~= nil ) then
		-- Print latest version
		print( "Latest recommended version: " .. text)

		-- If the versions are different, print it out
		if ( tonumber(curVer) ~= tonumber(text) ) then
			print( "^1This script is outdated, visit your keymaster to get the latest version." )
		else
			print( "This script is up to date!\n^0" )
		end
	else
		-- In case the version can not be requested, print out an error message
		print( "^1There was an error getting the latest version information.\n^0" )
	end
end )
