# TGVNgine
## Tokard's Godot Visual Novel Engine

TGVNgine is a simple, lightweight visual novel engine built with Godot, designed to help me quickly create and prototype 2D visual novels with more flexibility than Ren'Py.


### Installation

1. Clone the repository.

2. IDK this is the first commit...

# Documentation (todo)

## Character Management

| Command                        | Explanation                                                                 | Example                      |
|--------------------------------|-----------------------------------------------------------------------------|------------------------------|
| `[character [expression]]`     | Adds a character to the scene, optionally specifying an expression. If no expression is provided, the default expression is used. | `[amicus smile]`             |
| `[-character]`                 | Removes the specified character from the scene.                            | `[-amicus]`                  |
| `[[mv character x]]`           | Moves the character horizontally. Value ranges from -50 to 50, with 0 as the center of the screen. | `[[mv amicus 25]]`           |
| `[[look character_name direction]]` | Changes the direction the character is facing. Direction can be `left`, `right`, or other custom orientations. | `[[look amicus left]]`       |
| `{character_name}`             | Specifies which character is speaking in the dialogue.                     | `{amicus}`                   |

<br>

## Background Management

| Command                        | Explanation                                                                 | Example                      |
|--------------------------------|-----------------------------------------------------------------------------|------------------------------|
| `[[background name]]`           | Sets the background to the specified image from the background folder.      | `[[background house]]`       |
 
<br>

## Music & Sound Management

| Command                        | Explanation                                                                 | Example                      |
|--------------------------------|-----------------------------------------------------------------------------|------------------------------|
| `[[music track_name]]`          | Plays the specified music track.                                             | `[[music danger]]`           |
| `[[stop_music]]`                | Stops the current music playing.                                             | `[[stop_music]]`             |
| `[[sound effect_name]]`         | Plays a specific sound effect from the sound folder.                         | `[[sound explosion]]`        |

<br>

## Layer Management  

| Command                        | Explanation                                                                 | Example                      |
|--------------------------------|-----------------------------------------------------------------------------|------------------------------|
| `[[add_layer layer_name Z]]`    | Adds a layer at the specified Z-index. Layers with negative Z go behind characters. Note: background doesn't have an index and will always be in the background. | `[[add_layer shadow -2]]`    |
| `[[rm_layer layer_name]]`       | Removes a layer from the scene.                                              | `[[rm_layer shadow]]`        |

<br>

## Animation & Effects

| Command                              | Explanation                                                                 | Example                             |
|--------------------------------------|-----------------------------------------------------------------------------|-------------------------------------|
| `[[animate character animation]]`    | Plays a one-time animation for the specified character.                     | `[[animate amicus jump]]`           |
| `[[loop_anim character animation]]`  | Plays a looping animation for the character.                               | `[[loop_anim amicus idle]]`         |
| `[[mv_bg direction speed]]`          | Moves the background in a specified direction (`up`, `down`, `left`, `right`) with a defined speed. | `[[mv_bg down 2]]`                 |

<br>

## Commentaries & Notes

| Command                        | Explanation                                                                 | Example                      |
|--------------------------------|-----------------------------------------------------------------------------|------------------------------|
| `#`                            | Marks the beginning of a comment. It is ignored during execution.           | `# This is a comment`        |

<br>

## Acknowledgments

- Thanks to Godot Engine for providing an open-source platform to build this engine.
- Thanks to all contributors and the visual novel community for inspiration.
****
