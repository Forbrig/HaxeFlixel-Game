package;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;


class PlayState extends FlxState {
	var _player:Player;
	var _backgroundMap:FlxTilemap;
	var _foregroundMap:FlxTilemap;
	var _collisionMap:FlxTilemap;

	override public function create():Void {
		_player = new Player(20, 20);

		_backgroundMap = new FlxTilemap();
		_foregroundMap = new FlxTilemap();
		_collisionMap = new FlxTilemap();

		_collisionMap.visible = false;

		var _tiledMap = new TiledMap("assets/data/maps/map1.tmx");

		var _background = cast(_tiledMap.getLayer("background"), TiledTileLayer);
		_backgroundMap.loadMapFromArray(_background.tileArray, _background.width, _background.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);

		var _foreground = cast(_tiledMap.getLayer("foreground"), TiledTileLayer);
		_foregroundMap.loadMapFromArray(_foreground.tileArray, _foreground.width, _foreground.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);

		var _collision = cast(_tiledMap.getLayer("collision"), TiledTileLayer);
		_collisionMap.loadMapFromArray(_collision.tileArray, _collision.width, _collision.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);


		add(_backgroundMap);
		add(_player);

		add(_foregroundMap);
		add(_collisionMap);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		

		// FlxG.collide(_collisionMap, _player);
		
		// if (_collisionMap.overlaps(_player)) {
		// 	FlxObject.separate(_collisionMap, _player);
		// }
		trace(_collisionMap.overlaps(_player));

		super.update(elapsed);
	}

	override public function destroy():Void {
		super.destroy();
	}
}
