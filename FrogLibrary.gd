# FrogDataEditor.gd
extends Window

var items = []
var item_paths = []

func _ready():
	hide() # Hide by default

func set_items(new_items: Array, new_paths: Array):
	items = new_items
	item_paths = new_paths
	_update_ui()
	popup_centered() # Center the window

func _update_ui():
	var vbox = $VBoxContainer
	vbox.clear() # Clear previous content

	for item in items:
		var health_label = Label.new()
		health_label.text = "Health: "
		vbox.add_child(health_label)

		var health_spinbox = SpinBox.new()
		health_spinbox.min_value = 0
		health_spinbox.max_value = 100
		health_spinbox.value = item.health
		_connect_spinbox(health_spinbox, item, "health")
		vbox.add_child(health_spinbox)

		var unlocked_label = Label.new()
		unlocked_label.text = "Unlocked: "
		vbox.add_child(unlocked_label)

		var unlocked_checkbox = CheckBox.new()
		unlocked_checkbox.pressed = item.unlocked
		_connect_checkbox(unlocked_checkbox, item, "unlocked")
		vbox.add_child(unlocked_checkbox)

		var image_path_label = Label.new()
		image_path_label.text = "Image Path: "
		vbox.add_child(image_path_label)

		var image_path_edit = LineEdit.new()
		image_path_edit.text = item.imagePath
		_connect_line_edit(image_path_edit, item, "imagePath")
		vbox.add_child(image_path_edit)

		var separator = HSeparator.new()
		vbox.add_child(separator)

	var save_button = Button.new()
	save_button.text = "Save"
	#save_button.connect("pressed", save_button, "_on_save_pressed")
	save_button.connect("pressed",self,"_on_save_pressed")
	vbox.add_child(save_button)

func _connect_spinbox(spinbox, item, property):
	spinbox.connect("value_changed", self, "_on_spinbox_value_changed", [item, property])

func _connect_checkbox(checkbox, item, property):
	checkbox.connect("toggled", self, "_on_checkbox_toggled", [item, property])

func _connect_line_edit(line_edit, item, property):
	line_edit.connect("text_changed", self, "_on_line_edit_text_changed", [item, property])

func _on_spinbox_value_changed(value, item, property):
	item.set(property, value)

func _on_checkbox_toggled(toggled, item, property):
	item.set(property, toggled)

func _on_line_edit_text_changed(text, item, property):
	item.set(property, text)

func _on_save_pressed():
	for i in range(items.size()):
		ResourceSaver.save(item_paths[i], items[i])
	hide()
