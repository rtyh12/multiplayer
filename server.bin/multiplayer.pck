GDPC                 �                                                                         P   res://.godot/exported/206107301/export-218a8f2b3041327d8a5756f3a245f83b-icon.resP      '      2�T�q6��2�(rvpa    X   res://.godot/exported/206107301/export-9f509a86e3b1d629710e371c59721211-main_server.scn �      �      'D!K��KMN�4����    T   res://.godot/exported/206107301/export-a8a6c2d17c22928b6c4c68c746089ba7-robot.scn   �
      �      F[L�.0|VV��'��    ,   res://.godot/global_script_class_cache.cfg  �             ��Р�8���8~$}P�       res://.godot/uid_cache.bin  �      \       H�󹙈f�V,~�� �       res://ClickRobot.gd         q      !h���o��`��y�       res://SetupMultiplayer.gd   p      �      ��e��.�ޓ���~       res://SpawnRobots.gdp      S      �m�p�x�/	�pM���       res://icon.svg  �      �      C��=U���^Qu��U3       res://icon.svg.import   �      �       c�{�E�Q��2<	       res://main_server.tscn.remap�      h       �w����y�Rt��0��       res://multiplayer.gd       t      �\�D����>^eK�       res://project.binary�      {      h�]��Dj*��;�       res://robot.tscn.remap  @      b       =v���0��=گ�M��    extends TextureRect


var IP_ADDRESS := "fairydust.cc"
# var IP_ADDRESS := "159.89.20.135"
var PORT = 3000

@export var is_on := true:
	set(new):
		is_on = new
		modulate = Color.WHITE if is_on else Color.BLACK


func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_on = not is_on               [remap]

importer="texture"
type="PlaceholderTexture2D"
uid="uid://q7fygxoaljav"
metadata={
"vram_texture": false
}
path="res://.godot/exported/206107301/export-218a8f2b3041327d8a5756f3a245f83b-icon.res"
    RSRC                    PlaceholderTexture2D            ��������                                                  resource_local_to_scene    resource_name    size    script        #   local://PlaceholderTexture2D_i8388 �          PlaceholderTexture2D       
      C   C      RSRC         RSRC                    PackedScene            ��������                                                  ..    GridContainer    resource_local_to_scene    resource_name 	   _bundled    script       Script    res://SpawnRobots.gd ��������   PackedScene    res://robot.tscn p��A�L      local://PackedScene_4d3ex R         PackedScene          	         names "         Control    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    GridContainer    columns    script    robot    MultiplayerSpawner    _spawnable_scenes    spawn_path    	   variants    
                    �?                                     "         res://robot.tscn                    node_count             nodes     7   ��������        ����                                                          ����	                                             	      
                        ����            	             conn_count              conns               node_paths              editable_instances              version             RSRC   extends Node2D


var PORT = 3000
var MAX_CLIENTS = 10


var black := false:
	set(new_black):
		black = new_black
		modulate = Color.BLACK if new_black else Color.WHITE


func _ready() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer

	print("server up")

	multiplayer.peer_connected.connect(peer_connected.bind())
	

@rpc("any_peer")
func change_color_request(new_black: bool):
	change_color_response.rpc(new_black)


@rpc("any_peer")
func change_color_response(new_black: bool):
	print("i am server")


func peer_connected(id: int):
	print("penis ", id)            RSRC                    PackedScene            ��������                                            
      .    is_on    resource_local_to_scene    resource_name    size    script    properties/0/path    properties/0/spawn    properties/0/replication_mode 	   _bundled       Script    res://ClickRobot.gd ��������   #   local://PlaceholderTexture2D_apeaj �      %   local://SceneReplicationConfig_vntqg          local://PackedScene_p3njm [         PlaceholderTexture2D       
      C   C         SceneReplicationConfig                                              PackedScene    	      	         names "   	      TextureRect    size_flags_horizontal    size_flags_vertical    texture    script    MultiplayerSynchronizer    replication_config    _on_TextureRect_gui_input 
   gui_input    	   variants                                                node_count             nodes        ��������        ����                                               ����                   conn_count             conns                                       node_paths              editable_instances              version             RSRC  extends Node


var peer := ENetMultiplayerPeer.new()

# var IP_ADDRESS := "fairydust.cc"
var IP_ADDRESS := "172.22.226.71"
var PORT := 3000

func _ready() -> void:
	print(OS.has_feature("headless"))
	if OS.has_feature("dedicated_server") or OS.has_feature("Server"):
		peer.create_server(PORT)
		print("server")
	else:
		peer.create_client(IP_ADDRESS, PORT)

	print("poop")
	multiplayer.multiplayer_peer = peer
	peer.peer_connected.connect(peer_connected)

func peer_connected(id: int):
	print("penis ", id)     extends GridContainer


@export var robot: PackedScene

func _ready() -> void:
	if OS.has_feature("dedicated_server") or OS.has_feature("Server"):
		# for i in range(24):
		await get_tree().create_timer(10).timeout
		while true:
			print("spawning robot")
			add_child(robot.instantiate(), true)
			await get_tree().create_timer(1).timeout             [remap]

path="res://.godot/exported/206107301/export-9f509a86e3b1d629710e371c59721211-main_server.scn"
        [remap]

path="res://.godot/exported/206107301/export-a8a6c2d17c22928b6c4c68c746089ba7-robot.scn"
              list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             R̮ϲ�   res://icon.svg�sz-��   res://main_server.tscnp��A�L   res://robot.tscn    ECFG      _custom_features         dedicated_server   application/config/name         multiplayer    application/run/main_scene          res://main_server.tscn     application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     autoload/MultiplayerSetup$         *res://SetupMultiplayer.gd     input/click�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position    ��C  �A   global_position     ��C  �B   factor       �?   button_index         canceled          pressed          double_click          script           