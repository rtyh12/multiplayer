@tool
extends MeshInstance3D


@export var radius: float:
	set(new):
		radius = new

		if not Engine.is_editor_hint():
			return
		
		if meshInstance != null:
			meshInstance.mesh.radius = new * 1e-4
			meshInstance.mesh.height = new * 1e-4 * 2
			meshInstance.mesh.material.set_shader_parameter("scale", 10000 / new)
		if atmosphere != null:
			atmosphere.planet_radius = new * 1e-4
			atmosphere.atmosphere_height = 200 * 1e-4
			atmosphere.set_shader_parameter("u_density", 15 * new / 6300)
		if collisionShape != null:
			collisionShape.shape.radius = new * 1e-4

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