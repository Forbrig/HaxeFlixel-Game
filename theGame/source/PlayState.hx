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
	public var _players:FlxTypedGroup<Player>;
	var _bats:FlxTypedGroup<Bat>;
	var _slimes:FlxTypedGroup<Slime>;
	var _backgroundMap:FlxTilemap;
	var _backgroundMap2:FlxTilemap;
	var _foregroundMap:FlxTilemap;
	var _collisionMap:FlxTilemap;
	var _objectSpawn:FlxTilemap;

	override public function create():Void {
		FlxG.mouse.visible = false;

		_hud = new HUD();

		_players = new FlxTypedGroup<Player>(1);
		_slimes = new FlxTypedGroup<Slime>(5);
		_bats = new FlxTypedGroup<Bat>(1);

		// _players.add(new Player(50, 50, 1, [W, S, A, D]));
		// _players.add(new Player(50, 50, 2, [UP, DOWN, LEFT, RIGHT]));

		// for (i in 0...5) {
		// 	_bats.add(new Bat(100 * (i+1), 100 * (i+1)));
		// 	_slimes.add(new Slime(100 * (i+1), 100 * (i+1)));
		// }

		_backgroundMap = new FlxTilemap();
		_backgroundMap2 = new FlxTilemap();
		_foregroundMap = new FlxTilemap();
		_collisionMap = new FlxTilemap();
		_objectSpawn = new FlxTilemap();

		_collisionMap.visible = false;

		var _tiledMap = new TiledMap("assets/data/maps/map1.tmx");

		var _background = cast(_tiledMap.getLayer("background"), TiledTileLayer);
		_backgroundMap.loadMapFromArray(_background.tileArray, _background.width, _background.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);

		var _background2 = cast(_tiledMap.getLayer("background2"), TiledTileLayer);
		_backgroundMap2.loadMapFromArray(_background2.tileArray, _background2.width, _background2.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);

		var _foreground = cast(_tiledMap.getLayer("foreground"), TiledTileLayer);
		_foregroundMap.loadMapFromArray(_foreground.tileArray, _foreground.width, _foreground.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);

		var _collision = cast(_tiledMap.getLayer("collision"), TiledTileLayer);
		_collisionMap.loadMapFromArray(_collision.tileArray, _collision.width, _collision.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);

		var _spawn = cast(_tiledMap.getLayer("spawn"), TiledTileLayer);
		_objectSpawn.loadMapFromArray(_spawn.tileArray, _spawn.width, _spawn.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);

		// player spawn
		var id = 1;
		var _spawnObj = _objectSpawn.getTileInstances(305);
		if (_spawnObj != null) {
			for (i in _spawnObj) {
				_players.add(new Player(Std.int(i % _objectSpawn.widthInTiles) * _tiledMap.tileWidth, Std.int(i / _objectSpawn.widthInTiles) * _tiledMap.tileHeight, id, [W, S, A, D]));
				id = id+1;
			}
		}

		// bat spawn
		_spawnObj = _objectSpawn.getTileInstances(308);
		if (_spawnObj != null) {
			for (i in _spawnObj) {
				_bats.add(new Bat(Std.int(i % _objectSpawn.widthInTiles) * _tiledMap.tileWidth, Std.int(i / _objectSpawn.widthInTiles) * _tiledMap.tileHeight));
			}
		}

		add(_backgroundMap);
		add(_backgroundMap2);
 		add(_hud);
		add(_players);
		add(_slimes);
		add(_foregroundMap);
		add(_bats);
		add(_collisionMap);

		super.create();
	}

	override public function update(elapsed:Float):Void {

		FlxG.collide(_collisionMap, _players);
		FlxG.collide(_collisionMap, _slimes);
		FlxG.collide(_players, _players);
		FlxG.collide(_players, _slimes, overlapped);
		FlxG.collide(_players, _bats, overlapped);
		FlxG.collide(_bats, _bats);
		FlxG.collide(_slimes, _slimes);
		
		if (getPlayerById(1).health <= 0) {
			FlxG.switchState(new PlayState());
		}

		super.update(elapsed);
	}

	function overlapped(Sprite1:FlxObject, Sprite2:FlxObject):Void {
		// if (Std.is(Sprite1, EnemyBullet) || Std.is(Sprite1, Bullet)) {
		// 	Sprite1.kill();
		// }
		Sprite1.hurt(1);
		_hud.updateHUD(getPlayerById(1).health);
	}

	public function getPlayerById(id:Int):Player {
        for (p in _players) {
            if (cast(p, Player)._id == id) {
                return cast(p, Player);
            }
        }
        return null;
    }

	override public function destroy():Void {
		super.destroy();
	}
}
