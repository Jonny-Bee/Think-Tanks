package
{
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import fog.as3.FogDevAPI;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class Game extends MovieClip
	{
		public const gridSize:int = 32;
		public var map:GameMap;
		public var mainTick:Timer;
		public var oldTime:Number = 0;
		
		var keysDown:Object = new Object();
		
		
		public var enemies:Array;// list of enemies
		public var fx:Array; // list of self destroying fx
		public var objects:Array;// list of non game map collidable objects
		public var projectiles:Array; // does what is say's on the tin
		public var player:PlayerChar;
		public var level:MovieClip;
		public var SpritePool:spritePool;
		public var decalFX:Decal;
		public var currentLevel:int = 0;
		public var frameController:FrameController;
		public var SoundManager:soundManager;
		public var gameData:GameInfo;
		public var startTimer:Timer;
		public var restartTimer:Timer;
		public var endTimer:Timer;
		public var CrossHair:crossHair;
		
		public var playerScore:int = 0;
		public var levelScore:int = 0;
		public var coinsCollected:int = 0;
		public var levelTime:Number = 0;
		public var playerLives:int = 5;
		public var FogAPI;
		
		public var bPaused:Boolean = false;
		
		
		public function Game() 
		{
			gotoAndStop(1);
			FogAPI = new FogDevAPI( { id:'4e679d23c073f', root:root } );
			SpritePool = new spritePool();
			SoundManager = new soundManager(this);
			gameData = new GameInfo(false, this);
			// init game timers
			mainTick = new Timer(20, 0);
			startTimer = new Timer(3000, 1);
			restartTimer = new Timer(1000, 1);
			endTimer = new Timer(5000, 1);
			mainTick.addEventListener(TimerEvent.TIMER, tick, false, 0, true);
			startTimer.addEventListener(TimerEvent.TIMER, startRound, false, 0, true);
			restartTimer.addEventListener(TimerEvent.TIMER, restartRound, false, 0, true);
			endTimer.addEventListener(TimerEvent.TIMER, endRound, false, 0, true);
			
			
			// init keyboard listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
            stage.addEventListener(Event.DEACTIVATE, clearKeys);
			SoundManager.playbgm();
			//newLevel(1);
		}
		
		public function newLevel(num):void
		{
			
			map = new GameMap(24,16 );
			enemies = new Array();
			projectiles = new Array();
			fx = new Array();
			objects = new Array();
			oldTime = 0;
			currentLevel = num;
			frameController.getFrame(num + 5);
			levelTime = 0;
			levelScore = 0;
			coinsCollected = 0;
			
			
			
		}
		public function startRound()
		{
			//startTimer.stop();
			mainTick.start();
			
		}
		public function restartRound(tm:TimerEvent)
		{	mainTick.stop();
			endTimer.stop();
			restartTimer.stop();
			getFrame(4);
		}
		public function endRound(tm:TimerEvent = null)
		{
			mainTick.stop();
			restartTimer.stop();
			frameController.getFrame(3);
		}
		public function getFrame(num):void
		{
			frameController.getFrame(num);
		}
		public function arrived(num):void
		{
			
			if (num > 5)
			{
				//SoundManager.playbgm();
			}
			else if(currentLevel > 0){
				//SoundManager.stopbgm();
				
				Mouse.show();
			}
		}
		public function restart():void
		{
			
			restartTimer.start();
		}
		public function playerFire(evt:MouseEvent)
		{
			player.fire();
		}
		public function tick(evt:TimerEvent)
		{
			
			var dt:Number;
			if (oldTime == 0)
			{
				oldTime = getTimer();
				dt = 1;
				
			}
			else {
				var nt = getTimer();
				var dt = (nt - oldTime)/16;
				
				oldTime = nt;
				
			}
			if (!bPaused)
			{
				levelTime += dt*16;
			player.tick(dt);
			
			for (var i in enemies)
			{
				enemies[i].tick(dt);
			}
			for (var j in projectiles)
			{
				projectiles[j].tick(dt);
			}
			for (var k in objects)
			{
				objects[k].update(dt);
			}
			for (var l in fx)
			{
				fx[l].tick(dt);
			}
			}
		}
		public function removeProjectile(actor):void
		{
			for (var i in projectiles)
			{
				if (projectiles[i] == actor)
				{
					projectiles.splice(i, 1);
					level.removeChild(actor);
					break;
				}
			}
		}
		public function removeCoin(actor):void
		{
			for (var i in objects)
			{
				if (objects[i] == actor)
				{
					objects.splice(i, 1);
					level.removeChild(actor);
					break;
				}
				
			}
			
		}
		public function makeCoins(xp, yp)
		{
		
				var num = Math.ceil(Math.random() * 4);
				for (var i = 0; i < num; i++)
				{
					var nc = new coin(this);
					nc.x = xp;
					nc.y = yp;
					level.addChild(nc);
					objects.push(nc);
				}
			
		}
		public function removeEnemy(actor):void
		{
			levelScore += actor.scoreValue;
			for (var i in enemies)
			{
				if (enemies[i] == actor)
				{
					var f = new spriteFX(this, actor.x, actor.y, 0, 0, 9, SpritePool.explosion1, 128, .3);
					makeCoins(actor.x, actor.y);
					fx.push(f);
					decalFX.Crater(actor.x, actor.y);
					enemies.splice(i, 1);
					level.removeChild(actor);
					
					break;
				}
			}
			if (enemies.length <= 0)
			{
				
				
				endTimer.start();
				//endRound();
			}
			
		}
		public function removeSprite(actor):void
		{
			for (var i in fx)
			{
				if (fx[i] == actor)
				{
					fx.splice(i, 1);
					break;
					
				}
			}
		}
		public function sortActors():void
		{
			//loop through level and sort on y
			
			var len:uint = level.numChildren;
			for (var i = 0; i < len - 1; i++)
			{
				
				for (var j = i + 1; j < len; j++)
				{
					if ( level.getChildAt(i).y > level.getChildAt(j).y )
					{
						level.swapChildrenAt( i, j );
					}
				}
			}
		}
		public function isDown(keyCode:uint):Boolean {
			
            return Boolean(keyCode in keysDown);
        }
        
        private  function keyPressed(event:KeyboardEvent):void {
            keysDown[event.keyCode] = true;
			
        }
       
        private function keyReleased(event:KeyboardEvent):void {
            if (event.keyCode in keysDown) {
                delete keysDown[event.keyCode];
            }
        }
        
       
        private function clearKeys(event:Event):void {
           
            keysDown = new Object();
        }
		
	}

}