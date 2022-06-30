package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class GameObject extends Sprite 
	{
		var game:Game;
		var gx:int;
		var gy:int;
		
		var bCollectable:Boolean;
		var health:int = 0;
		var ammo:int = 0;
		var shield:int = 0;
		var radius = 32
		var resetTimer:Timer;
		
		public function GameObject()
		{
			
			addEventListener(Event.ADDED_TO_STAGE, Init, false, 0, true);
			
		}
		
		public function Init(evt:Event)
		{
				game = Game(parent.parent);
				gx = Math.floor(x / game.gridSize);
				gy = Math.floor(y / game.gridSize);
				x = gx * 32 + 16;
				y = gy * 32 + 16;
				game.objects.push(this);
				removeEventListener(Event.ADDED_TO_STAGE, Init, false);
				resetTimer = new Timer(15000, 1);
				resetTimer.addEventListener(TimerEvent.TIMER, reset, false, 0, true);
		}
		
		public function reset(evt:TimerEvent)
		{
			resetTimer.reset();
			visible = true;
			bCollectable = true;
			// Make FX for reapear..
		}
		public function collected(actor:GameChar):void
		{
			if (bCollectable)
			{
				bCollectable = false;
				visible = false;
				
				resetTimer.start();
				actor.addHealth(health);
				//actor.weapon.ammo += ammo;
				actor.addShield(shield);
				//TODO: Make fx, add local interfaces to GameChar, ECAPSULATION!!! Perform Safe Operations damn it!
			}
		}
	}
	
}