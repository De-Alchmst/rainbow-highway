# The Hackers Quick Guide

This is not a complex explanation of every procedure.
At least os of now, I feel like the code is quite clear.
Plus it's not like we will need documentations for long anyways...

This is a quick, dirty, and possibly outdated overview of the codebase
topology and quirks.

Lets start from the beginning: `Main.pas`.

Main does not have much stuff in it, and hopefully it never will.
It does however call few init functions, that need to be executed after raylib
Initializes.

Speaking of Raylib, it has it's own unit.
C bindings in Pascal are very straight forward, so I don't feel like explaining
it.
I add stuff as I need it by rewriting it from the header file.
Raymath and rlgl have their own units.

Next "big" unit is `Core.pas`.
Here I store stuff that is used all over the place, so it does not belong to any
one unit.

Some might call my programming approach barbaric.
Maybe it is...
What can I say, I like good old procedural programming and Pascal, unlike some
other languages, does not seem to care.

The main game itself is structured into three parts: highway, entities and HUD.

Highway is drawn in `HighwayDraw.pas` and `BeamsDraw.pas`.
Each also has its own logic unit.
With a bit of fancy AI and magic, Beams get Their size from Loaded music.
Currently we only do 32 bit audio and analyze only single channel.
Well, shit happens.

Speaking of music, I don't store multiple music tracks, I just load the one I
want to play.
I generally try to have as few resources loaded at a time, purely as a
challenge.

This also goes with textures.
I currently don't do spritesheets, but I would like to one day.
I have few textures I use all the time, let's call them static, and rest is only
loaded when needed, we will call those dynamic.
When Something want's to use a texture, it asks for it via it's path.
Maps are fun.

Back to the layers.
Entities are drawn in `GameDraw.pas`, and are handled in `GameLogic.pas`.

I tried to make entities as a complex OOP shting.
I would not call it a great success, but it works.

I All the entities are stored in the `Entities` directory.
The main ones end int `Base`. From these other specific entities derive.

Drawing entities is also fun.

In `TexturePlate.pas` is a simple rlgl procedure to draw texture in fun ways.
Too fun, in fact.
Since textures can, in theory, clip through one another, I was forced to apply
alpha discard shader. I recommend you do the same, as it makes things way
easier.
