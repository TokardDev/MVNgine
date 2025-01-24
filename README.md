# TGVNgine
## Tokard's Godot Visual Novel Engine

TGVNgine is a simple, lightweight visual novel engine built with Godot, designed to help me quickly create and prototype 2D visual novels with more flexibility than Ren'Py.

## Getting Started

### Prerequisites
- Godot Engine (version 3.5 or higher recommended).
- Basic understanding of Godot and GDScript.

### Installation

1. Clone the repository.
2. (IDK) This is the first commit...

<br>

# Documentation
## Character Management

| Command                      | Explanation                                                                                                    | Example               | Status             |
|------------------------------|----------------------------------------------------------------------------------------------------------------|-----------------------|--------------------|
| `[+character (expression)]`   | Adds a `character` to the scene. `expression` is optional and allows loading a character with a different sprite. If no expression is provided, the default expression is used. If the character is already in the scene, it will update its sprite based on the `expression` parameter. | `[+amicus smile]`     | <span style="color:red;">To Do</span> |
| `[-character]`                | Removes the specified `character` from the scene.                                                             | `[-amicus]`           | <span style="color:red;">To Do</span> |
| `[character mv x]`           | Moves the `character` horizontally. The `x` value ranges from -50 to 50, with 0 as the center of the screen.     | `[amicus mv 25]`      | <span style="color:red;">To Do</span> |
| `[character look direction]` | Changes the `direction` the character is facing. `Direction` can be `left` or `right`.                         | `[amicus look left]`  | <span style="color:red;">To Do</span> |
| `>character text`            | Specifies which `character` is speaking and their dialogue.                                                   | `>amicus Hi Marco, slept well?` | <span style="color:red;">To Do</span> |
| `@text`                       | Displays narration or inner thoughts not tied to a specific character.                                        | `@You think about Amicus` | <span style="color:red;">To Do</span> |
| `[character anim animation]` | Plays a one-time `animation` for the specified `character`.                                                   | `[amicus anim jump]`       | <span style="color:red;">To Do</span> |
| `[character loop animation]` | Plays a looping `animation` for the `character`.                                                             | `[amicus loop idle]`  | <span style="color:red;">To Do</span> |

<br>

## Scene Management

| Command       | Explanation                                                         | Example           | Status             |
|---------------|---------------------------------------------------------------------|-------------------|--------------------|
| `[clear]`     | Clears all elements from the scene, including characters, music, and background. | `[clear]`         | <span style="color:red;">To Do</span> |

<br>

## Background Management

| Command                    | Explanation                                                                | Example                 | Status             |
|----------------------------|----------------------------------------------------------------------------|-------------------------|--------------------|
| `[bg image]`               | Sets the background to the specified `image` from the background folder.     | `[bg house]`           | <span style="color:red;">To Do</span> |
| `[bg anim direction speed]` | Moves the background in a specified direction (`up`, `down`, `left`, `right`) with a defined speed. | `[bg anim down 2]`           | <span style="color:red;">To Do</span> |

<br>

## Music & Sound Management

| Command           | Explanation                                  | Example                  | Status             |
|-------------------|----------------------------------------------|--------------------------|--------------------|
| `[music track]`   | Plays the specified music `track`.           | `[music danger]`         | <span style="color:red;">To Do</span> |
| `[music stop]`    | Stops the current music playing.            | `[music stop]`           | <span style="color:red;">To Do</span> |
| `[sound effect]`  | Plays a specific sound `effect` from the sound folder. | `[sound explosion]`     | <span style="color:red;">To Do</span> |

<br>

## Layer Management  

| Command              | Explanation                                                                                      | Example                  | Status             |
|----------------------|--------------------------------------------------------------------------------------------------|--------------------------|--------------------|
| `[+layer image Z]`    | Adds a `layer` at the specified Z-index. Layers with a negative Z go behind characters. Backgrounds don't have indices and always remain in the back. | `[+layer shadows 2]`     | <span style="color:red;">To Do</span> |
| `[-layer image]`      | Removes a layer from the scene.                                                                  | `[-layer shadows]`        | <span style="color:red;">To Do</span> |

<br>

## Commentaries & Notes

| Command  | Explanation                                  | Example             | Status             |
|----------|----------------------------------------------|---------------------|--------------------|
| `#`      | Marks the beginning of a comment. It is ignored during execution. | `# This is a comment` | <span style="color:red;">To Do</span> |

<br>

## Acknowledgments

- Thanks to Godot Engine for providing an open-source platform to build this engine.
