class_name Bus
extends Node

# global signals
signal hp_changed(health: int, max: int)
signal game_over()

# request re-sending of data over the bus (e.g. when UI components are ready)
signal refresh_hp()

# data
var score_time: float = 0.0
