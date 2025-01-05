extends VBoxContainer

@onready var hp_label := %HPLabel as Label
@onready var hp_bar := %HPBar as TextureProgressBar

@export var critical_level := 1000
@export var texture_hp_low: Texture2D
@export var warn_level := 3000
@export var texture_hp_med: Texture2D
@export var texture_hp_high: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GameBus.hp_changed.connect(update_label)
	GameBus.refresh_hp.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_label(health: int, max: int) -> void:
	hp_bar.max_value = max
	hp_label.text = "SHIELD: %d" % health
	hp_bar.value = health
	if health <= critical_level:
		hp_bar.texture_progress = texture_hp_low
	elif health <= warn_level:
		hp_bar.texture_progress = texture_hp_med
	else:
		hp_bar.texture_progress = texture_hp_high
