## What?
This repository is where I house some experiments (done in Processing) with Verlet physics, trying to see how far I can make the simpler definition of Newton's force equations go.

<img src=./imgs/physics_demo_cube.gif></img>

## Why?
My girlfriend was having trouble making Suika game so I thought I'd implement
some easy-to-use physics for her. Because of that this repository is not
written in the Holy Tongue (C) and is instead a Processing app- all be it one
written in a C style...

## Is it usable?
Yes actually. I've made a few games using this code and they run pretty well.
It is at the end of the day a Java application, using an N^2 algorithm for
collision detection though, so performance isn't impressive. That being said I was still able to make Suika game, Cursed (soft-body) Tetris, and Angry Birds and run them on my 15 year old 32-bit laptop just fine (more than 60fps).<br><br>
General rule of thumb, don't go past 3,000 point-masses.

<img src=./imgs/suika_game_demo.gif></img>

## Verlet Physics
I learned about Verlet physics from ![this](https://youtu.be/lS_qeBy3aQI) video
and thought the concept was interesting. If you don't know what they are I
recommend that video. <br><br>

After re-implementing what was done in the original video, I thought I'd have
some fun trying to see how far I can take this simpler definition of Newton's
laws. Trying to add in the following:
- Masses/inverse masses
- Non-circle bodies
- The third dimensions
- Dampening
- Friction
- Rigid body polygon meshes
- Soft body polygon meshes





