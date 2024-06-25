# CustomEditorPlugin.gd

extends EditorPlugin

func _enter_tree():
	# Called when the plugin is activated
	add_custom_button()

func add_custom_button():
	# Create a new button
	var button = Button.new()
	button.text = "Frog"
	button.connect("pressed", self, "_on_button_pressed")
	
	# Add the button to the editor interface
	var topbar = get_editor_interface().get_base_control().get_child(0)
	topbar.add_child(button)

func _on_button_pressed():
	# Method to handle button press
	var scene_path = "res://path_to_your/FrogDataEditor.tscn"
	var scene = load(scene_path)
	var instance = scene.instance()
	get_tree().root.add_child(instance)
