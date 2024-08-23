extends Button
@export var controller: Node

func _on_pressed():
	get_tree().call_group("vertex_group", "queue_free")
	controller.set_mode(controller.modes.vertices)
	
	for i in range(knoten_klasse.node_count):
		get_tree().call_group("edge_group" + str(i), "queue_free")
		
	knoten_klasse.node_count = 0
