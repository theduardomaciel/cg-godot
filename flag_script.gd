extends MeshInstance3D

@export var my_flag_texture: Texture2D

func _ready():
	var flag_instance = $FlagChild  # supondo esse seja o nome do nó instanciado
	var mat = flag_instance.get_active_material(0) as ShaderMaterial
	if mat:
		mat.set_shader_parameter("flag_texture", my_flag_texture)
