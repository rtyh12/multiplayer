@tool
extends MeshInstance3D


@export var radius: float:
	set(new):
		if not Engine.is_editor_hint():
			return
		
		radius = new
		meshInstance.mesh.radius = new * 1e-5
		meshInstance.mesh.height = new * 1e-5 * 2
		atmosphere.planet_radius = new * 1e-5

@export var meshInstance: MeshInstance3D
@export var atmosphere: Node3D