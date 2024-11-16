
-- Only add the steam ids of people who you can really trust
-- Each steamid has to be surrounded by quotes and a comma must come after each on except the last one
-- Leave "UNKNOWN" in the list if you are hosting a listen server otherwise you won't be admin
adminlist = {
	"UNKNOWN", -- leave this one
	"STEAM_0:1:1337", -- change/remove this, they are just examples
	"STEAM_0:2:1337" -- change/remove this, they are just examples
}


--[[
Admin commands

bg_removeallprops
Removes all the props that have been spawned

bg_restartround
Restarts the round

bg_physgunpickup <0/1>
You can set this to 0 or 1. This will allow the phsygun to pick up objects
if you set it to 1. Be careful though. Anyone can easily cheat by propelling
theirself up with the phsygun

bg_gravgunfreeze <0/1>
You can set this to 0 or 1. Setting it to 1 allows the gravity gun to freeze
objects after you let go of the object. This can also be used to cheat by 
taking about 3 boxes and stacking them in the air over and over.

bg_timelimit <minutes>
Set's the round time limit in minutes. Example: bg_timelimit 30
You'll have to restart the round for it to take effect

bg_scorelimit <score>
Set's the score limit for the game.

]]--