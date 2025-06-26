package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.group.FlxGroup;
import flixel.tile.FlxBaseTilemap;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState {
	var _hud:HUD;

	public var _playerBullets:FlxTypedGroup<Shuriken>;
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

		_playerBullets = new FlxTypedGroup<Shuriken>();
		_players = new FlxTypedGroup<Player>(1);

		_slimes = new FlxTypedGroup<Slime>(5);
		_bats = new FlxTypedGroup<Bat>(20);

		_backgroundMap = new FlxTilemap();
		_backgroundMap2 = new FlxTilemap();
		_foregroundMap = new FlxTilemap();
		_collisionMap = new FlxTilemap();
		_objectSpawn = new FlxTilemap();

		_collisionMap.visible = false;

		var _tiledMap = new TiledMap("assets/data/maps/map1.tmx");

		var _background = cast(_tiledMap.getLayer("background"), TiledTileLayer);
		_backgroundMap.loadMapFromArray(_background.tileArray, _background.width, _background.height, "assets/data/maps/terrain_atlas.png", 32, 32,
			FlxTilemapAutoTiling.OFF, 1);

		var _background2 = cast(_tiledMap.getLayer("background2"), TiledTileLayer);
		_backgroundMap2.loadMapFromArray(_background2.tileArray, _background2.width, _background2.height, "assets/data/maps/terrain_atlas.png", 32, 32,
			FlxTilemapAutoTiling.OFF, 1);

		var _foreground = cast(_tiledMap.getLayer("foreground"), TiledTileLayer);
		_foregroundMap.loadMapFromArray(_foreground.tileArray, _foreground.width, _foreground.height, "assets/data/maps/terrain_atlas.png", 32, 32,
			FlxTilemapAutoTiling.OFF, 1);

		var _collision = cast(_tiledMap.getLayer("collision"), TiledTileLayer);
		_collisionMap.loadMapFromArray(_collision.tileArray, _collision.width, _collision.height, "assets/data/maps/terrain_atlas.png", 32, 32,
			FlxTilemapAutoTiling.OFF, 1);

		var _spawn = cast(_tiledMap.getLayer("spawn"), TiledTileLayer);
		_objectSpawn.loadMapFromArray(_spawn.tileArray, _spawn.width, _spawn.height, "assets/data/maps/terrain_atlas.png", 32, 32, FlxTilemapAutoTiling.OFF, 1);

		// player spawn
		var _spawnObj = _objectSpawn.getTileInstances(305);
		if (_spawnObj != null) {
			for (i in _spawnObj) {
				_players.add(new Player(Std.int(i % _objectSpawn.widthInTiles) * _tiledMap.tileWidth,
					Std.int(i / _objectSpawn.widthInTiles) * _tiledMap.tileHeight, _playerBullets, [W, S, A, D]));
			}
		}

		// bat spawn
		for (i in 0..._bats.maxSize) {
			// Spawn bats outside the map boundaries (randomly on one of the four sides)
			var side = FlxG.random.int(0, 3); // 0=left, 1=right, 2=top, 3=bottom
			var x:Float;
			var y:Float;
			if (side == 0) { // left
				x = -32;
				y = FlxG.random.int(0, _backgroundMap.heightInTiles * 32);
			} else if (side == 1) { // right
				x = _backgroundMap.widthInTiles * 32 + 32;
				y = FlxG.random.int(0, _backgroundMap.heightInTiles * 32);
			} else if (side == 2) { // top
				x = FlxG.random.int(0, _backgroundMap.widthInTiles * 32);
				y = -32;
			} else { // bottom
				x = FlxG.random.int(0, _backgroundMap.widthInTiles * 32);
				y = _backgroundMap.heightInTiles * 32 + 32;
			}
			_bats.add(new Bat(Std.int(x), Std.int(y)));
		}

		add(_backgroundMap);
		add(_backgroundMap2);
		add(_hud);
		add(_players);
		add(_slimes);
		add(_foregroundMap);
		add(_bats);
		add(_playerBullets);
		add(_collisionMap);

		super.create();
	}

	override public function update(elapsed:Float):Void {
		FlxG.collide(_collisionMap, _players);
		FlxG.collide(_bats, _players, overlapped);
		FlxG.collide(_bats, _bats);

		// bullets collision
		FlxG.collide(_playerBullets, _bats, overlapped);
		FlxG.collide(_playerBullets, _foregroundMap, overlapped);

		if (getPlayerById(1).health <= 0) {
			FlxG.switchState(() -> new MenuState());
		}

		if (_bats.countLiving() == 0) {
			FlxG.switchState(() -> new MenuState());
		}

		super.update(elapsed);
	}

	function overlapped(attacker:FlxObject, victim:FlxObject):Void {
		if (attacker is Shuriken) {
			cast(attacker, Shuriken).kill();
		}

		if (victim is Bat) {
			cast(victim, Bat).hurt(1);
		}

		if (victim is Player) {
			cast(victim, Player).hurt(1);
		}

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
