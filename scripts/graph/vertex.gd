class_name vertex_class extends Area2D

# Static variables and functions
static var node_count: int = 0
static var lerp_speed: int = 15;

# Sprites
enum sprites {unselected, selected, hovered, current, visited}
@export var sprite_unselected: CompressedTexture2D
@export var sprite_selected: CompressedTexture2D
@export var sprite_current: CompressedTexture2D
@export var sprite_visited: CompressedTexture2D

# Vertex data
var id_: int
var allowed_to_move: bool = false
var visited: bool = false

# Visuals of vertex 
var label_id: Label
var label_info: Label
var label_meta: Label
var sprite: Sprite2D

func _ready():
	# Set id and update node_count
	id_ = node_count
	node_count += 1
	# Init visuals
	sprite = get_node("Sprite2D")
	sprite.texture = sprite_unselected
	
	label_id = get_node("./Label_id")
	label_info = get_node("./Label_info")
	label_meta = get_node("./Label_meta")
	reset_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Make sure every vertex desnt collide with any other vertex
	for vertex in get_tree().get_nodes_in_group("vertex_group"):
		if vertex != self && global_position.distance_to(vertex.global_position) <  constants.node_margin:
			vertex.global_position = lerp(vertex.global_position, global_position + (vertex.global_position - global_position).normalized() *  constants.node_margin, lerp_speed * delta)
	
	# Lerp vertex position to mouse position if vertex is allowed to move
	if allowed_to_move:
		global_position = lerp(global_position, get_global_mouse_position(), lerp_speed * delta)

func set_allowed_to_move(state: bool):
	if state:
		modulate = constants.hovered
	else:
		modulate = Color(1.0, 1.0, 1.0, 1.0)
	allowed_to_move = state

func mark_visited():
	set_sprite(vertex_class.sprites.visited)
	label_info.set_text(tr("VISITED"))

func reset_visited():
	visited = false

func reset_labels():
	label_id.text = str(id_)
	label_info.text = ""
	label_meta.text = ""

func set_sprite(selection: sprites):
	match selection:
		sprites.unselected: 
			sprite.texture = sprite_unselected
		sprites.selected:
			sprite.texture = sprite_current
		sprites.current:
			sprite.texture = sprite_current
		sprites.visited:
			sprite.texture = sprite_current

func _on_mouse_entered():
	modulate = constants.hovered

func _on_mouse_exited():
	if not allowed_to_move:
		modulate = Color(1.0, 1.0, 1.0, 1.0)
