extends Node2D

var cadenciaPlatosEnSegundos = 3
var tiempoEntrePlatos = 0
var cañonIzq:Node
var cañoñDer:Node
@onready var cañonPrefab:PackedScene=preload("res://FruitNinja/Escenas/cañon.tscn")
@onready var unPlato:PackedScene=preload("res://FruitNinja/Escenas/objetos_arrojados.tscn")
@onready var timer:Timer=$Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",disparar)
	timer.start()
	timer.wait_time = cadenciaPlatosEnSegundos
	cañonIzq = cañonPrefab.instantiate()
	#cañonIzq.set_variables(new Vector2(1,1))
	cañoñDer = cañonPrefab.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tiempoEntrePlatos += delta
	if tiempoEntrePlatos > cadenciaPlatosEnSegundos:
		print("Tiro Plato")
		tiempoEntrePlatos = 0
		
func disparar():
	var algo:Node = unPlato.instantiate()
	add_child(algo)
	print("disparo")

#func _create_cañon(posIni:Vector2)
#   var enemy = load("res://FruitNinja/Escenas/cañon.tscn")
#   enemy.instantiate()
#	   enemy.set_variables(my_enemy_object)
#   add_child(enemy)
