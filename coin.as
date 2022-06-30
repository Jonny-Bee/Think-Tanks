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
	public class coin extends Sprite 
	{
		var game:Game;
		var gx:int;
		var gy:int;
		var vx:Number;
		var vy:Number;
		var life:int = 1000;
		var bCollectable:Boolean = true;
		
		
		public function coin(gm:Game)
		{
			
			game = gm;
			gx = Math.floor(x / game.gridSize);
			gy = Math.floor(y / game.gridSize);
			vx = -2 + (Math.random() * 4);
			vy = -2 + (Math.random() * 4);
			
		}
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
			vx *= .98;
			vy *= .98;
			x += vx*dt;
			y += vy*dt;
			life -= dt;
			if (life <= 0)
			{
				collected(false);
			}
			if (vy < 0)
			{
				if (checkGrid(x, y + vy - 6))
				{
					vy *= -1;
				}
			}
			else if (vy > 0)
			{
				if (checkGrid(x, y + vy + 6))
				{
					vy *= -1;
				}
			}
			
			if (vx < 0)
			{
				if (checkGrid(x + vx - 6, y))
				{
					vx *= -1;
					
				}
			}
			else if (vx > 0)
			{
				if (checkGrid(x + vx + 6, y))
				{
					vx *= -1;
				}
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
					game.coinsCollected += 1;
					game.gameData.addCredit(5);
					game.SoundManager.playShot("coin");
				}
				var f = new spriteFX(game, x, y - 5, 0, 0, 9, game.SpritePool.hit, 32);
				
				game.fx.push(f);
				game.removeCoin(this);
			}
		}
	}
	
}