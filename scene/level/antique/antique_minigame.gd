extends Minigame

@export var force_per_scroll: int = 50
@export var sisyphus_animation: AnimatedSprite2D
@export var boulder: Node2D

func _input(event: InputEvent) -> void:
    if event.is_pressed() and event.button_index == MOUSE_BUTTON_WHEEL_UP:
        force_buildup+=force_per_scroll

        var current_frame = sisyphus_animation.get_frame()+1

        if current_frame >= 8:
            current_frame = 0
        print(current_frame)
        var current_progress = sisyphus_animation.get_frame_progress()
        sisyphus_animation.set_frame_and_progress(current_frame,current_progress)

        boulder.rotate(0.07)
