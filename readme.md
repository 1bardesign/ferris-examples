# Examples for the Ferris Game Framework

Get your head around how [ferris](https://github.com/1bardesign/ferris) is meant to be used to make games, with some worked examples.

# Demos/Game Split

Some more focussed "feature" demos are being prepared alongside a more integrated mini-game.

The feature demos should help understand specific ferris features without all the noise of a full game; the game should help understand how features can be combined.

We can reevaluate if this split still makes sense once they're all actually finished!

## Demos

- sprites and animation
	- z sorted animated ferris wheel and firework particle spam
- physics
	- a little character running around bouncy ball physics hell

## Game

- tbd, but some kind of infinite procgen platformer is probable
- or zelda-like?

# Caveats

**Overusing behaviours**

Behaviours are one of the big "wins" of ferris over more traditional ecs - you don't need to create a whole new system for some throwaway one-off behaviour, and you can localise the logic along with the entity itself.

It's almost _too_ easy to do this.

A downside is that you can overdo this and sort of forget that systems exist, even when they might be a better fit :) This is done as a deliberate example for the particle entity - the "transform" component should really be in its own system. Thankfully, migrating from a behaviour to a "proper" component is not much work when you need to. Just be mindful of this. A good middle ground is creating classes for behaviours you find yourself reusing.

**No Audio, Yet**

It's coming, but you can also get a really long way by just loading a few sound effects and playing them from the start upon something happening, and sticking some looping music in the background. I just haven't had time to source proper sound for the demos yet - or to pull a few handy sound utility things out of arco :)

**No ui layout stuff**

Ferris doesn't currently provide this, normally some kind of UI system will be created per-game. There are a lot of opinionated UI frameworks out there for you to integrate.

It's something we might explore in future!

**Tilemap just does rendering**

The provided tilemap system just renders a layer of the provided tilemap; it doesn't do collisions or anything else fancy.

This isn't an inherent limitation of ferris, just a limitation of the tilemap system written for this demo.

**Just keyboard input in the demo**

Keyboard is simplest to understand, and just supporting keyboard means minimal complexity setting up hooks etc.

I'm working through a more unified input solution for ferris at the moment as part of the development of Arco.

# Troubleshooting

**Game Wont Run, something about `lib.batteries` or `lib.ferris`**

Sounds like the libraries are missing, because they are included as submodules rather than as direct copies, so that they can be easily updated in future.
If you're using git, clone the repository recursively, or initialise the submodules.
Your search engine should be able to help with this.

If you're not using git, but you downloaded the zip from github - github doesn't package up the libraries when it's making that zip!
You can unzip the .love file from itch instead, it has the libraries included.
