![SCREENSHOTS](https://raw.github.com/derekneil/UnrealSimon/master/unrealScreens.png "Unreal Simon")

v0.1 By Derek Neil

Classic Simon Game with Unreal Tournament 1999 (C) theme

Features:
Two types of simon game modes both playing until health depleated
    - stepped for multiple sequences at same length
    - continuous for same sequence that keeps getting longer

Unreal Tournament 1999 sounds, images, and visual effects
Player options to switch bewteen modes, difficulty levels, toggle sounds & ambient noise/music
Persistent player options recalled when app runs again

Known Issues:
Delay between end of game playing sequence and Simon buttons being unlocked for user input
PlayerController stores Player directly instead of using a Player model
SoundController called from GameViewController to save redundant observer logic
High Scores commented in but not implemented