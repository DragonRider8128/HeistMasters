extends ItemList

func update_disguises(amount):
	clear()
	for disguises in range(amount):
		add_icon_item(load("res://GFX/PNG/Tiles/tile_129.png"),false)
