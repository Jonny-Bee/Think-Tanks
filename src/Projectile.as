package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class Projectile extends Sprite 
	{
		var game:Game;
		var vx:Number;
		var gx:Number;
		var vy:Number;
		var gy:Number;
		var speed:Number = 2;
		var radius:Number = 4;
		var bounces:int = 0;
		var maxBounces:int = 1;
		var owner:GameChar;
		var bDead:Boolean = false;
		var enemyShot:Boolean;
		var trailTick:int = 0;
		var direction:Number;
		
		public function Projectile(ow:GameChar, gm:Game, xp:Number, yp:Number, velx:Number, vely:Number, maxBounce:Number = 1, nmeShot:Boolean = false)
		{
			owner = ow;
			game = gm;
			x = xp;
			y = yp;
			vx = velx;
			vy = vely;
			maxBounces = maxBounce;
			enemyShot = nmeShot;
			mouseEnabled = false;
			mouseChildren = false;
			//direction = Math.atan2(vy, vx) * 180 / Math.PI;
			//shotGFX..gotoAndStop(Math.round((direction+180) / 5));
			
		}
		
		public function tick(dt:Number = 1)
		{
			if (!bDead)
			{
				trailTick ++;
			if (vy < 0)
			{
				if (checkGrid(x, y + vy - 6))
				{
					vy *= -1;
					bounced();
				}
			}
			else if (vy > 0)
			{
				if (checkGrid(x, y + vy + 6))
				{
					vy *= -1;
					bounced();
				}
			}
			
			if (vx < 0)
			{
				if (checkGrid(x + vx - 6, y))
				{
					vx *= -1;
					bounced();
					
				}
			}
			else if (vx > 0)
			{
				if (checkGrid(x + vx + 6, y))
				{
					vx *= -1;
					bounced();
				}
			}
			
			x += vx * dt;
			y += vy * dt;
			gx = Math.floor(x / 32);
			gy = Math.floor(y / 32);
			checkCollision();
			if (trailTick >= 2)
			{
				trailTick = 0;
				var f = new spriteFX(game, x - vx , (y - vy) - 7,0,  0, 9, game.SpritePool.trail, 24,1,1);
				game.fx.push(f);
			}
			}
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
		public function bounced()
		{
			bounces += 1;
			//direction = Math.atan2(vy, vx) * 180 / Math.PI;
			//shotGFX..gotoAndStop(Math.round((direction+180) / 5));
			if (bounces > maxBounces)
			{
				
				destroy();
			}
			else {
				game.SoundManager.playShot("wall");
			}
		}
		public function checkCollision()
		{
			for (var q in game.projectiles)
			{
				var f = game.projectiles[q];
				if (f != this)
				{
					if (f.gx >= gx-1 && f.gx <= gx + 1)
					{
						if (f.gy >= gy-1 && f.gy <= gy + 1)
						{
							
							if (checkRadial(f))
							{
								break;
							}
							
						}
					}
					
				}
			}
			if (!enemyShot)
			{
				if (bounces > 0)
				{
					checkRadial(game.player);
				}
				for (var h in game.enemies)
				{
					var f = game.enemies[h];
					
					
					if (f.gx >= gx-2 && f.gx <= gx + 2)
					{
						if (f.gy >= gy-2 && f.gy <= gy + 2)
						{
							if (owner == game.player && f != game.player)
							{
								f.state = "dodge";
							}
							if (checkRadial(f))
							{
								break;
							}
								
						}
					}
						
					
				}
			}
			else {
				/*if (bounces > 0)
				{
					for (var h in game.enemies)
					{
						
						if (f.gx >= gx-1 && f.gx <= gx + 1)
						{
							if (f.gy >= gy-1 && f.gy <= gy + 1)
							{
								if (checkRadial(f))
								{
									break;
								}
								
							}
						}
					}
							
						
				}*/
				var bh = checkRadial(game.player);
			}
		}
		public function destroy():void
		{
			if (!bDead)
			{
				var f = new spriteFX(game, x, y - 5, 0, 0, 9, game.SpritePool.hit, 32);
				game.SoundManager.playShot("explode2");
				game.fx.push(f);
				owner.shotCount --;
				bDead = true;
				game.removeProjectile(this);
				
				
			}
			
		}
		public function takeHit(actor):void
		{
			this.destroy();
		}
		public function checkRadial(f):Boolean
		{
			var rslt = false;
			var a = x - f.x;
			var b = y - f.y;
			var plen = (a * a + b * b);
			var limit = (f.radius + 6) * (f.radius + 6);
			if( plen <= limit)
			{
				f.takeHit(this.owner);
				this.takeHit(null);
				rslt = true;
			}
			return rslt;
		}
		
		
	}
	
}