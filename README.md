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

## File Management with `.tgvn` Files

In TGVNgine, all game content and story progression are stored in custom `.tgvn` files. These files serve as the core structure for handling routes, scenes, characters, and choices in the visual novel. Each `.tgvn` file represents a segment of the story, allowing for dynamic transitions between different paths, based on the player’s decisions.

These files are written in a simple text format and can be easily edited to create complex branching narratives with variables, conditions, and actions. When the player makes a choice, the engine will load a new `.tgvn` file to continue the story from the chosen point.

You can run ``./bin/build`` script to build a custom .exe/.sh/.app depending on your OS using a custom name + icon.

## Character Management

| Command                      | Explanation                                                                                                    | Example               | Status             |
|------------------------------|----------------------------------------------------------------------------------------------------------------|-----------------------|--------------------|
| `[+character (sprite)]`   | Adds or change the sprite of a `character`. `sprite` is optional and allows loading a character with a different sprite by using it's file name. | `[+copper smile]`     | <span style="color:red;">To Do</span> |
| `[-character]`                | Removes the specified `character` from the scene.                                                             | `[-copper]`           | <span style="color:red;">To Do</span> |
| `[character mv <value>]`           | Moves the `character` horizontally. The `value` ranges from -50 to 50, with 0 as the center of the screen.     | `[copper mv 25]`      | <span style="color:red;">To Do</span> |
| `[character look <direction>]` | Changes the `direction` the character is facing. `Direction` can be `left` or `right`.                         | `[copper look left]`  | <span style="color:red;">To Do</span> |
| `>character`                 | Specifies which `character` is speaking. Will use this character untill you specify another.                   | `>copper` | <span style="color:red;">To Do</span> |
| `@text`                       | Displays narration or inner thoughts not tied to a specific character. WIll override > command, but not replace it | `@You think about Copper` | <span style="color:red;">To Do</span> |
| `[character anim <animation>]` | Plays a one-time `animation` for the specified `character`.                                                   | `[bowden anim jump]`       | <span style="color:red;">To Do</span> |
| `[character loop <animation>]` | Plays a looping `animation` for the `character`.                                                             | `[copper loop wave]`  | <span style="color:red;">To Do</span> |

<br>

## Scene Management

| Command       | Explanation                                                         | Example           | Status             |
|---------------|---------------------------------------------------------------------|-------------------|--------------------|
| `[clear]`     | Clears all elements from the scene, including characters, music, and background. | `[clear]`         | <span style="color:red;">To Do</span> |

<br>

## Background Management

| Command                    | Explanation                                                                | Example                 | Status             |
|----------------------------|----------------------------------------------------------------------------|-------------------------|--------------------|
| `[bg <image>]`               | Sets the background to the specified `image` from the background folder.     | `[bg forest]`           | <span style="color:red;">To Do</span> |
| `[bg anim <direction> <speed>]` | Moves the background in a specified direction (`up`, `down`, `left`, `right`) with a defined speed. | `[bg anim down 2]`           | <span style="color:red;">To Do</span> |

<br>

## Music & Sound Management

| Command           | Explanation                                  | Example                  | Status             |
|-------------------|----------------------------------------------|--------------------------|--------------------|
| `[music <track>]`   | Plays the specified music `track`.           | `[music danger]`         | <span style="color:red;">To Do</span> |
| `[music stop]`    | Stops the current music playing.            | `[music stop]`           | <span style="color:red;">To Do</span> |
| `[sound <effect>]`  | Plays a specific sound `effect` from the sound folder. | `[sound explosion]`     | <span style="color:red;">To Do</span> |

<br>

## Layer Management  

| Command              | Explanation                                                                                      | Example                  | Status             |
|----------------------|--------------------------------------------------------------------------------------------------|--------------------------|--------------------|
| `[+layer <image> <index>]`    | Adds a layer from an `image` at the specified `index`. Layers with a negative`index go behind characters. Backgrounds don't have index and always remain in the back. | `[+layer fog 2]`     | <span style="color:red;">To Do</span> |
| `[-layer <image>]`      | Removes a layer from the scene.                                                                  | `[-layer fog]`        | <span style="color:red;">To Do</span> |

<br>

## Goto Command

| Command        | Explanation                                                                                                      | Example              | Status             |
|----------------|------------------------------------------------------------------------------------------------------------------|----------------------|--------------------|
| `[goto <scene>]` | Jump to the specified `scene`. This can be used to move to a new scene or checkpoint in the visual novel. Scenes are using .tgvn extension.         | `[goto prologue]`    | <span style="color:red;">To Do</span> |

<br>

#Voici la version sans le bloc `markdown` :

## Choice Management

| Command            | Explanation                                                                                               | Example                | Status             |
|--------------------|-----------------------------------------------------------------------------------------------------------|------------------------|--------------------|
| `[choice [choice1, choice2, ...]]`         | Displays a `choice` menu with options for the player to select. Each option leads to a different scene or action. | `[choice "run", "hide", "fight"]` | <span style="color:red;">To Do</span> |

<br>

Example

```bash
>Bowden
[choice "run", "hide", "fight"]
    [case 1]
        @You decide to run
        The forest blurs around you as you sprint
        [goto escapeRoute]
    [case 2]
        @You choose to hide behind a tree
        [goto stealthRoute]
    [case 3]
        @You decide to stand your ground and fight
        [goto battleScene]
    [end choice]
```

<br>

## Variable Management

| Command               | Explanation                                                                                     | Example                   | Status             |
|-----------------------|-------------------------------------------------------------------------------------------------|---------------------------|--------------------|
| `[var <variable> <value>]` | Sets a `variable` to a specified `value`. This is useful for tracking player choices or game state. You can use + and -. | `[var courage 10]`    | <span style="color:red;">To Do</span> |
| `[if <condition>]` | Checks if the `variable` meets a specified `condition`. If true, the following block of code is executed. | `[if courage > 5]`  | <span style="color:red;">To Do</span> |
| `[else]`               | Executes the block of code after the `if` statement if the condition is false.                   | `[else]`                   | <span style="color:red;">To Do</span> |
| `[endif]`             | Ends the `if` statement.                                                                          | `[end if]`                | <span style="color:red;">To Do</span> |

<br>

Example

```bash
>Copper
[var trust_level 3]
[var trust_level +2] # increase trust level
[if trust_level >= 5]
    @You trust Copper with your life because they have proven their loyalty in countless ways
[else]
    @You doesn't seem convinced yet, Copper's tail flicking nervously as they consider your actions.
[endif]

```

## Commentaries & Notes

| Command  | Explanation                                  | Example             | Status             |
|----------|----------------------------------------------|---------------------|--------------------|
| `#`      | Marks the beginning of a comment. It's ignored during execution. | `# This is a comment` | <span style="color:red;">To Do</span> |

<br>

## Acknowledgments

- Thanks to Godot Engine for providing an open-source platform to build this engine.
