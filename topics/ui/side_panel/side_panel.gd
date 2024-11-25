class_name SidePanel extends Control

@export var is_open: bool

@export var button_toggle: Button
@export var cont_code: CodeContainer
@export var cont_var: VarContainer
@export var cont_call: CallStackContainer
@export var cont_exp: ExpContainer
func _ready():
	button_toggle.open = is_open
	if is_open:
		button_toggle.force_open()
	else:
		button_toggle.force_close()

func _process(_delta):
	is_open = button_toggle.open

func toggle():
	button_toggle.toggle_()
func open():
	button_toggle.open_()
func close():
	button_toggle.close_()

func select_containers(c: bool, v: bool, cs: bool, i: bool):
	cont_code.visible = bool(c)
	cont_var.visible = bool(v)
	cont_call.visible = bool(cs)
	cont_exp.visible = bool(i)

func override_exp(text_: String):
	cont_exp.override(text_)

func override_code(text_: String, update_init: bool = true):
	cont_code.override(text_, update_init)

func override_code_return(text_: String = "Algorithm returned", color: Color = constants.color_1_c):
	cont_code.set_return(text_, color)

func override_code_call(text_: String):
	cont_code.set_call(text_)

func highlight_code(lines: Array):
	cont_code.highlight_lines(lines)
func highlight_code_undo():
	cont_code.highlight_lines_undo()

func create_variable() -> Label:
	return cont_var.create_variable()

func create_variable_undo():
	cont_var.create_variable_undo()

func push_call() -> Label:
	return cont_call.push_call_()

func reset(c: bool = 1, v: bool = 1, cs: bool = 1, i: bool = 1):
	if c:
		cont_code.reset()
	if v:
		cont_var.reset()
	if cs:
		cont_call.reset()
	if i:
		cont_exp.reset()

func make_call():
	cont_call.make_call()
func make_call_undo():
	cont_call.make_call_undo()
func make_call_variable(variable_name: String):
	cont_call.create_variable(variable_name)
func make_call_variable_undo():
	cont_call.create_variable_undo()
