extends Node
var pixel_script = preload("res://value_types/pixel.gd")
var celda_script = preload("res://value_types/celda.gd")

func pixel(vector : Vector2) -> Pixel:
	return pixel_script.new(vector)

func celda(vector : Vector2) -> Celda:
	return celda_script.new(vector)
