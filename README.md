# Godot-Snake
Recreation of Snake mobile game using Godot 4 

# Current implementation
- Board is the main game scene
- Snake scene contains the code for the "parts"
- Once a target is eaten by the head of the snake, it then builds another part at its tail
- Each part will follow the part in front of it (moves to the coordinates of the piece in front of it)
- The game resets when the snake exits the board or eats itself
