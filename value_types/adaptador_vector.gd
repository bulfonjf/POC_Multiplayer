class_name AdaptadorVector

var vector : Vector2
var BASE_CLASS = "AdaptadorVector"

func _init(vectorInput : Vector2):
	vector = vectorInput
	
func _in(lista : Array):
	for entidad in lista:
		if self._eq(entidad):
			return true
	return false
	
func _eq(entidad : AdaptadorVector):
	return self.BASE_CLASS == entidad.BASE_CLASS and self.vector == entidad.vector 

