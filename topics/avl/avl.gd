extends tree_traversal_class

func _ready():
	pass

var vertices: Array = []
func create_tree(data_array: Array, edge_array: Array):
	if is_instance_valid(new_vertex):
		new_vertex.queue_free()
	
	for vertex in vertices:
		vertex.queue_free()
	vertices.clear()
	
	for data in data_array:
		var vertex = vertex_scene.instantiate()
		vertex.set_data(data)
		vertices.push_back(vertex)
		add_child(vertex)
	
	for edge in edge_array:
		match edge[2]:
			0:
				vertices[edge[0]].p1.set_target(vertices[edge[1]])
			1:
				vertices[edge[0]].p2.set_target(vertices[edge[1]])
	
	root_ptr.set_target(vertices[0])
	reposition()
	reposition()

func parent(index):
	return int((index - 1) / 2)

func aufgabe_01(argv: Array):
	new_vertex = vertex_scene.instantiate()
	new_vertex.visible = false
	new_vertex.set_data(4)
	new_vertex.global_position = vertices[6].dest_pos + Vector2(100, 100)
	new_vertex.move_to(new_vertex.global_position)
	add_child(new_vertex)
	
	push_operations([
			Operation.new(
					Operation.opcodes.POINT_AT,
					[vertices[6].p2, new_vertex]),
			Operation.new(
					Operation.opcodes.TOGGLE_VISIBLE,
					[new_vertex]),
	])
	
	push_operations([
			Operation.new(
					Operation.opcodes.POINT_AT,
					[vertices[3].p1, null]),
			Operation.new(
					Operation.opcodes.POINT_AT,
					[vertices[6].p2, null]),
			Operation.new(
					Operation.opcodes.POINT_AT,
					[new_vertex.p1, vertices[6]]),
			Operation.new(
					Operation.opcodes.POINT_AT,
					[new_vertex.p2, vertices[3]]),
			Operation.new(
					Operation.opcodes.MOVE,
					[new_vertex, vertices[3].dest_pos + Vector2(-150, 150)]),
			Operation.new(
					Operation.opcodes.MOVE,
					[vertices[6], vertices[3].dest_pos + Vector2(-300, 300)]),
	])
	
	push_operations([
			Operation.new(
					Operation.opcodes.POINT_AT,
					[vertices[1].p1, new_vertex]),
			Operation.new(
					Operation.opcodes.MOVE,
					[vertices[3],  Vector2(vertices[3].dest_pos.x, vertices[3].global_position.y + 300)]),
	])
	
	push_operations([
			Operation.new(
					Operation.opcodes.REPOS,
					[[]]),
	])
func _on_buton_aufgabe_01_pressed():
	create_tree(
		[16, 10, 25, 5, 12, 20, 3],
		[[0, 1, 0],
		[0, 2, 1],
		[1, 3, 0],
		[1, 4, 1],
		[2, 5, 0],
		[3, 6, 0]])
	
	init_algo(aufgabe_01)

func aufgabe_02(argv: Array):
	push_operations([
			Operation.new(
					Operation.opcodes.POINT_AT,
					[vertices[0].p2, vertices[5]]),
			Operation.new(
					Operation.opcodes.MOVE_REL,
					[vertices[2], Vector2(0, 150)]),
	])

	push_operations([
			Operation.new(
					Operation.opcodes.TOGGLE_VISIBLE,
					[vertices[2]]),
	])

	push_operations([
			Operation.new(
					Operation.opcodes.MOVE_REL,
					[vertices[2], Vector2(0, 0)]),
			Operation.new(
					Operation.opcodes.REPOS,
					[[vertices[2]]]),
	])
	
	## SECOND PHASE
	
	push_operations([
			Operation.new(
					Operation.opcodes.POINT_AT,
					[vertices[1].p2, vertices[0]]),
			Operation.new(
					Operation.opcodes.POINT_AT,
					[vertices[0].p1, vertices[4]]),
	])
	
	push_operations([
			Operation.new(
					Operation.opcodes.POINT_AT,
					[root_ptr, vertices[1]]),
	])
	
	push_operations([
			Operation.new(
					Operation.opcodes.REPOS,
					[[vertices[2]]]),
	])
func _on_buton_aufgabe_02_pressed():
	create_tree(
		[16, 10, 25, 5, 12, 30, 6],
		[[0, 1, 0],
		[0, 2, 1],
		[1, 3, 0],
		[1, 4, 1],
		[2, 5, 1],
		[3, 6, 1]])
	
	init_algo(aufgabe_02)