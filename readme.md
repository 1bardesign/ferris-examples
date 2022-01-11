# Ferris Examples - this repository is a work in progress!

Get your head around how ferris is meant to be used to make games with a bunch of worked examples

# Demos/Game Split

Some more focussed "feature" demos are being prepared alongside a more integrated mini-game. The feature demos should help understand specific ferris features without all the noise of a full game; the game should help understand how features can be combined.

## Demos

- sprites and animation
	- z sorted animated ferris wheel and particle spam
- physics
	- bouncy ball physics hell
- entities
	- infinitely spawning 2 teams of brawlers on a polyline map
- events
	- pheremone creature "ecosystem"

## Game

- tbd, but some kind of infinite platformer is probable
- or zelda-like?

# Caveats

**No ui layout stuff**

Ferris doesn't currently provide this, though normally some kind of UI system will be created per-game. There are a lot of opinionated UI frameworks out there for you to integrate.

**Minimal input handling (just keyboard)**

Often this varies game by game, but probably ferris could provide a more unified solution (and attach its own hooks). TODO!

# Troubleshooting

**Game Wont Run, something about `lib.batteries` or `lib.ferris`**

The libraries are missing, because they are included as submodules rather than as direct copies, so that they can be easily updated in future.
If you're using git, clone the repository recursively, or initialise the submodules.
Your search engine should be able to help with this.
If you're not using git, but you downloaded the zip from github - github doesn't package up the libraries when it's making that zip! Unzip the .love file from itch instead, it has the libraries included.
