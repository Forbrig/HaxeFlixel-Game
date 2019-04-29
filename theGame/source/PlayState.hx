package;

import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;


class PlayState extends FlxState {
	var _player:Player;
	var _map:FlxTilemap;

	override public function create():Void {
		_player = new Player(20, 20);
		_map = new FlxTilemap();
		var _tiledMap = new TiledMap("assets/data/maps/map1.tmx");
		var _background = cast(_tiledMap.getLayer("background"), TiledTileLayer);
		_map.loadMapFromArray(_background.tileArray, _background.width, _background.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);


		add(_map);
		add(_player);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

	override public function destroy():Void {
		super.destroy();
	}
}
