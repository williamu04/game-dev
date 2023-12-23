extends CanvasLayer

var green: Color = Color("6bbfa3")
var red: Color = Color(0.9, 0, 0, 1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var gren_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var gren_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready():
	Globals.connect("stat_up", update_stat)
	update_gren()
	update_laser()
	update_health()

func update_laser():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)
	
func update_gren():
	gren_label.text = str(Globals.gren_amount)
	update_color(Globals.gren_amount, gren_label, gren_icon)
	
func update_health():
	health_bar.value = Globals.health

func update_stat():
	update_gren()
	update_laser()
	update_health()

func update_color(jml: int, label: Label, icon: TextureRect) -> void:
	if jml <= 0:
		label.modulate = red
		icon.modulate = red
	else: 
		label.modulate = green
		icon.modulate = green
