package;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.group.FlxGroup;

class PlayState extends FlxState {
	var _hud:HUD;
 	// var _health:Int = 3;
	public var _player:Player;

	// var _bat:Bat;
	var _bats:FlxTypedGroup<Bat>;
	public var _slime:Slime;
	var _backgroundMap:FlxTilemap;
	var _foregroundMap:FlxTilemap;
	var _collisionMap:FlxTilemap;

	override public function create():Void {
		FlxG.mouse.visible = false;

		_hud = new HUD();
		_player = new Player(50, 50, [W, S, A, D]);
		_slime = new Slime(200, 200);
		// _bat = new Bat(400, 400);
		_bats = new FlxTypedGroup<Bat>(5);

		for (i in 0...5) {
			_bats.add(new Bat(100 * (i+1), 100 * (i+1)));
		}

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

		// _collisionMap.setTileProperties(34, FlxObject.ANY);
		// _collisionMap.setTileProperties(0, FlxObject.NONE);
		// _collisionMap.follow();

		add(_backgroundMap);

 		add(_hud);
		add(_player);
		add(_slime);
		add(_foregroundMap);
		add(_bats);

		add(_collisionMap);

		super.create();
	}

	override public function update(elapsed:Float):Void {

		FlxG.collide(_collisionMap, _player);
		FlxG.collide(_collisionMap, _slime);
		FlxG.collide(_player, _slime, overlapped);
		FlxG.collide(_player, _bats, overlapped);
		FlxG.collide(_bats, _bats);
		
		if (_player.health <= 0) {
			FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}

	function overlapped(Sprite1:FlxObject, Sprite2:FlxObject):Void {
		// if (Std.is(Sprite1, EnemyBullet) || Std.is(Sprite1, Bullet)) {
		// 	Sprite1.kill();
		// }
		Sprite1.hurt(1);
		_hud.updateHUD(_player.health);
	}

	override public function destroy():Void {
		super.destroy();
	}
}
