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
	public class powerUp extends Sprite 
	{
		var game:Game;
		var gx:int;
		var gy:int;
		var life:int = 1000;
		var bCollectable:Boolean = true;
		
		
		
		public function checkGrid(xp, yp):Boolean
		{
			var tgx = Math.floor(xp / 32);
			var tgy = Math.floor(yp / 32);
			if (game.map.getGrid(tgx, tgy) == 1)
			{
				return true;
			}
			else {
				return false;
			}
		}
		public function update(dt)
		{
			
			life -= dt;
			if (life <= 0)
			{
				collected(false);
			}
			gx = Math.floor(x / game.gridSize);
			gy = Math.floor(y / game.gridSize);
		}
		public function collected(col:Boolean = true ):void
		{
			if (bCollectable)
			{
				bCollectable = false;
				visible = false;
				if (col == true)
				{
					game.SoundManager.playShot("coin");
				}
				var f = new spriteFX(game, x, y - 5, 0, 0, 9, game.SpritePool.hit, 32);
				
				game.fx.push(f);
				game.removeCoin(this);
			}
		}
	}
	
}