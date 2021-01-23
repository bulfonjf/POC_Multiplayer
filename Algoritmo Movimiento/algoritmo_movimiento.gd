extends Reference

onready var grilla_principal : TileMap = get_node("res://Grilla")

# esto devolveria la base si consultas las celdas ocupadas
#var ejemplo = [
#	{"posicion_x": 1, "posicion_y": 0, "entidad_id": 10, "entidad_tipo": "unidad"},
#	{"posicion_x": 15, "posicion_y": 3, "entidad_id": 15, "entidad_tipo": "unidad"},
#	{"posicion_x": 2, "posicion_y": 2, "entidad_id": 7, "entidad_tipo": "edificio"}
#]	

func evaluar_celdas_adyacentes(_celda_actor : Celda):
	var celdas_a_evaluar : Array = []
	var celdas_adyacentes = grilla.obtener_celdas_adyacentes(_celda_actor)
	for celda in celdas_adyacentes:
		var info_celda = obtener_info_celda(celda)
		if info_celda[0].entidad_id == NULL: #######guarda, comprobar esto
			celdas_a_evaluar.append(celda)
		else:
			#consultar que tipo de nodo es, si es amigo o enemigo
			pass
	return celdas_a_evaluar

func obtener_info_celda(_celda : Celda):
	celda = _celda.vector
	valor_x = celda.x
	valor_y = celda.y
	var info_celda = Db.consultar("select entidad_id, entidad_tipo from celdas_ocupadas where posicion_x = %d and posicion_y = %d" % [valor_x, valor_y])
	return info_celda


	
func celda_libre(celda_a_evaluar : Celda): #Evalua si celda destino esta libre
	var info_celda = obtener_info_celda(celda_a_evaluar)
	if info_celda[0].entidad_id == NULL: #######guarda, comprobar esto
		return true
	else:
		return false
	
#Devuelve las celdas donde el actor se puede mover
func obtener_celdas_donde_se_puede_mover(actor):
	var celdas_donde_se_puede_mover : Array
	var celdas_de_movimiento_permitido = {}  #Aca se van guardando las celdas evaluadas y su coste de movimeinto
	var celda_actor = grilla_principal.obtener_posicion_grilla(actor) #obtiene la celda actual del actor
	var celdas_adyacentes_al_actor = evaluar_celdas_adyacentes(celda_actor) #obtiene celdas adyacentes al actor
		
	
	for celda in celdas_adyacentes_al_actor: #LLama a evaluzar_brach  por cada celda adyacente
		evaluar_branch(celda_actor, celda, actor.get_movimientos(), actor, celdas_de_movimiento_permitido) 
	
	for celda in celdas_de_movimiento_permitido:
		if celda_actor.vector == celda:
			celdas_de_movimiento_permitido.erase(celda)
	for celda in celdas_de_movimiento_permitido.keys():  #Pasar las celdas a formato Celda antes de devolverlas
		var celda_convertida = Convertir.celda(celda)
		celdas_donde_se_puede_mover.append(celda_convertida)
	
	return celdas_donde_se_puede_mover
	
#evalua las celdas siguiendo un camino, 
#y les asigna un valor en base al heroe y  los tiles
#comienza con las cellas adyacentes al actor, y se va llamando recursivamente
func evaluar_branch(celda_origen: Celda, celda_destino: Celda, movimiento_disponible, actor, celdas_de_movimiento_permitido):
	var tipo_de_terreno_celda_destino = grilla_principal.obtener_info_de_celda(celda_destino)["tipo"] #obtiene el "tipo" de tile
	var coste_de_movimiento = actor.obtener_coste_movimiento(tipo_de_terreno_celda_destino) #coste de mov del tile segun el "tipo" de actor
	var movimiento_disponible_branch = movimiento_disponible #variable de movimiento disponibles interna

		
	if movimiento_disponible_branch >= coste_de_movimiento and self.celda_libre(celda_destino):  #primero evalua si le quedan mov disponibles al jug para mover a la celda, y si la celda está libre
		movimiento_disponible_branch -= coste_de_movimiento  #resta el coste de mov del tile al mov disponible del actor( la variable interna)
		
		if celdas_de_movimiento_permitido.has(celda_destino.vector):  #se fija si la celda ya ha sido evaluada
			if celdas_de_movimiento_permitido[celda_destino.vector] < movimiento_disponible_branch: #si la nueva evaluacion es más óptima, sobreescribe la anterior.
				celdas_de_movimiento_permitido[celda_destino.vector] = movimiento_disponible_branch
			else:
				return   #Corta el algoritmo si la celda ya fue evaluada de forma más óptima
		
		else: #si la celda no fue evaluada previamente, le asigna un valor a la celda
			celdas_de_movimiento_permitido[celda_destino.vector] = movimiento_disponible_branch
		
		
		var celdas_adyacentes_celda_destino = grilla_principal.obtener_celdas_adyacentes(celda_destino) #nuevas celdas adyacentes, para hacer la recursion de la funcion
		celdas_adyacentes_celda_destino.erase(celda_origen) #elimina la celda de origen (que fue evaluada en las lineas de arriba) de las celdas adyacentes
		
		for celda in celdas_adyacentes_celda_destino: #la funcion de llama a si misma con las celdas adyacentes a la celda evaluada
			evaluar_branch(celda_destino, celda, movimiento_disponible_branch, actor, celdas_de_movimiento_permitido)

