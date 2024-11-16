Build Gamemode v1.2

- Created by g33k

The point of this game is to make it to the top of the cliff the fastest. 
There are 3 levels to get to. You need to use teamwork to make it. 
The prop maker (slot 2, first weapon) is used to create crates and barrels. 
Primay fire for crates, secondary for barrels. You can use 
the gravity gun to place the items. After they have the item positioned someone 
will have to freeze the item with the physgun. Use the secondary fire to freeze it. 
The physgun's beam has been disabled due to the ability to cheat with it. 

If you are hosting a listening server you can issue some admin commands. If you 
are hosting a dedicated server you will have to add in your steamid into the 
adminlist.lua file. If you extracted it correctly it should be in the dir
C:\Program Files\Valve\Steam\SteamApps\SourceMods\gmod\lua\gamemodes\build

You can also add the steamids of your friends that you trust to use the commands.


Press F3 for the admin panel


Admin commands


bg_removeallprops
-- Removes all the props that have been spawned

bg_restartround
-- Restarts the round

bg_physgunpickup <0/1>
-- You can set this to 0 or 1. This will allow the phsygun to pick up objects
-- if you set it to 1. Be careful though. Anyone can easily cheat by propelling
-- theirself up with the phsygun

bg_gravgunfreeze <0/1>
-- You can set this to 0 or 1. Setting it to 1 allows the gravity gun to freeze
-- objects after you let go of the object. This can also be used to cheat by 
-- taking about 3 boxes and stacking them in the air over and over.

bg_timelimit <minutes>
-- Set's the round time limit in minutes. Example: bg_timelimit 30
-- You'll have to restart the round for it to take effect

bg_scorelimit <score>
-- Set's the score limit for the game.



