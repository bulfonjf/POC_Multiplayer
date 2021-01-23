extends Node
class_name ext_lista

func comparar_arrays(source : Array, target : Array) -> bool:
	var matcheo = false
	for item in source:
		if target.has(item):
			matcheo = true
		else:
			matcheo = false
			break

	return matcheo

# Obtiene el indice de un elemento en un array. Si el elemento no esta devuelve -1
# Se usa func_para_comparar para determinar cuando el target esta en el source 
func obtener_index(source: Array, target: Object, func_para_comparar) -> int:
	for item in source: 
		if func_para_comparar.call_func(item, target): 
			return source.find(item, 0) #aca el item siempre va a estar, pq item viene de la iteracion del array
	return -1