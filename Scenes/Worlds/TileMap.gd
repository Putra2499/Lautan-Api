extends TileMap

var selected_tile

func _process(_delta):
	var tile = local_to_map(get_global_mouse_position())
	selected_tile = map_to_local(tile)
