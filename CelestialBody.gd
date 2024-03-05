@tool
extends MeshInstance3D


func recalculate():
	# if not Engine.is_editor_hint():
	# 	return
	
	if meshInstance != null:
		meshInstance.mesh.radius = radius * 1e-4
		meshInstance.mesh.height = radius * 1e-4 * 2
		meshInstance.mesh.material.set_shader_parameter("scale", 10000 / radius)
	if atmosphere != null:
		atmosphere.planet_radius = radius * 1e-4
		atmosphere.atmosphere_height = atmosphere_height * 1e-4
		atmosphere.set_shader_parameter("u_density", atmosphere_density * radius / 6300)
	if collisionShape != null:
		collisionShape.shape.radius = radius * 1e-4

@export var radius: float:
	set(new):
		radius = new
		recalculate()

@export var atmosphere_height: float:
	set(new):
		atmosphere_height = new
		recalculate()

@export var atmosphere_density: float:
	set(new):
		atmosphere_density = new
		recalculate()

@export var meshInstance: MeshInstance3D

@export var atmosphere: Node3D:
	set(new):
		atmosphere = new
		if new == null or atmosphere == null: return
		atmosphere.sun = new

@export var collisionShape: CollisionShape3D

@export var sun: Node3D:
	set(new):
		sun = new
		if new == null or atmosphere == null: return
		atmosphere.sun = new