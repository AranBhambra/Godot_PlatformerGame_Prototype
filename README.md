# 2D Platformer

This demo is a pixel art 2D platformer with graphics and sound.

It shows you how to code characters and physics-based objects
in a real game context. This is a relatively complete demo
where the player can jump, walk on slopes, fire bullets,
interact with enemies, and more. It contains one closed
level, and the player is invincible, unlike the enemies.

You will find most of the demo’s content in the `Level.tscn` scene.
You can open it from the default `Game.tscn` scene, or double
click on `Level.tscn` in the `src/Level/` directory.

Language: GDScript

Renderer: GLES 2

Concept: Players follow Rex, a young tribal man on a quest to discover hidden treasure. Riding an ostrich, Rex must navigate treacherous obstacles and battle fierce creatures using his boomerang and agility. The objective is to overcome challenges and claim the ultimate prize.

Genre: Adventure, Platformer, Action.

Core Mechanics:

Movement: Jumping, running, dodging.

Combat: Use a boomerang to defeat enemies.

Level Progression: Face increasing difficulty as you progress.

## Features

- Side-scrolling player controller using [`KinematicBody2D`](https://docs.godotengine.org/en/latest/classes/class_kinematicbody2d.html).
    - Can walk on and snap to slopes.
    - Can shoot, including while jumping.
- Enemies that crawl on the floor and change direction when they encounter an obstacle.
- Camera that stays within the level’s bounds.
- Supports keyboard and gamepad controls.
- Platforms that can move in any direction.
- Gun that shoots bullets with rigid body (natural) physics.
- Collectible coins.
- Pause and pause menu.
- Pixel art visuals.
- Sound effects and music.

## Screenshots

![image](https://github.com/user-attachments/assets/bbbc5f61-a275-41c0-9586-59d56fb12ad7)


![image](https://github.com/user-attachments/assets/afc6de61-8428-4fbb-aee0-ccb736f2a1f4)


## Music

"One Piece OST Overtaken" by Basilis Papadopoulos https://youtu.be/daFi4MScfl8
