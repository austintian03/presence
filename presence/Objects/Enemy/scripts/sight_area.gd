class_name SightArea
extends Area2D

signal player_detected

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_detected.emit(true)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_detected.emit(false)
