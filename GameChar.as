package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class GameChar extends Sprite 
	{
		var game:Game;
		
		var angle:Number = 0;
		var vx:Number = 0;
		var vy:Number = 0;
		var gx:Number = 0;
		var gy:Number = 0;
		
		//corner points
		
		var lx:Number;
		var by:Number;
		var rx:Number;
		var ty:Number;
		
		var sx:Number = 15;//half width
		var sy:Number = 15;// half height
		
		var gravity:Number = 0.1;
		var friction:Number = .92;
		var baseSpeed:Number = .8;
		public var Base:MovieClip;
		public var turret:MovieClip;
		var desiredAngle:Number = 0;
		var aimAngle:Number = 0;
		var team:int = 0;
		
		var bCanShootSpecial:Boolean = true;
		
		var weapon:Weapon;
		var health:Number = 100;
		var maxHealth = 100;
		var shield:Number = 0;
		
		var shotCount:int = 0;
		var bDead:Boolean;
		var radius:Number = 12;
		var traveled:Number = 0;
		
		
		public function addShield(num):void
		{
			shield += num;
			if (shield > 100)
			{
				shield = 100;
			}
		}
		
		public function addHealth(num):void
		{
			health += num;
			if (health > maxHealth)
			{
				health = maxHealth;
			}
		}
		
		
		public function updatePoints():void
		{
			lx = x - sx;
			rx = x + sx;
			ty = y - sy;
			by = y + sy;
			
			gx = Math.floor(x / game.gridSize);
			gy = Math.floor(y / game.gridSize);
			
		}
		public function getDir():void
		{
			
		}
		public function fire():void
		{
			
		}
		public function fireSpecial():void
		{
			
		
		}
		public function tick(dt:Number = 1):void
		{
			updatePoints();
			getDir();
			move(dt);
			collideObjects();
		}
		public function collideObjects():void
		{
			for (var i in game.objects)
			{
				var f = game.objects[i];
				if (f.gx >= gx-1 && f.gx <= gx + 1)
				{
					if (f.gy >= gy-1 && f.gy <= gy + 1)
					{
						if(getSquaredDist(f) <= 1024)
						{
							f.collected(this);
						}
						
					}
				}
			}
		}
		public function getClosestEnemy():GameChar
		{
			/*var dist = 10000000000000000;
			var cur:GameChar;
			var sel:GameChar;
			for (var i in game.enemies)
			{
				cur = game.enemies[i];
				var tdist = getSquaredDist(cur)
				if ( tdist < dist && cur != this)
				{
					sel = cur;
					dist = tdist;
				}
			}
			cur = game.player;
				tdist = getSquaredDist(cur)
				if ( tdist < dist)
				{
					sel = cur;
					dist = tdist;
				}*/
			//return sel;
			return game.player;
		}
		public function getSquaredDist(actor):Number
		{
			var a = x - actor.x;
			var b = y - actor.y;
			var c = (a * a + b * b);
			return c;
		}
		public function takeHit(actor):void
		{
			
		}
		public function move(dt:Number = 1):void
		{
			var speed = baseSpeed * dt;
			
			vx *= .91;
			vy *= .91;
			if (vx > 0)
			{
				if (testPoint(rx +(vx*speed),by) == 0 && testPoint(rx +(vx*speed),ty) == 0)
				{
					x += vx * speed;
					traveled += vx * speed;
				}
				else 
				{
					vx *= 0.5;
					snapX();
				}
			}
			else if (vx < 0)
			{
				if (testPoint(lx +(vx*speed),by) == 0 && testPoint(lx +(vx*speed),ty) == 0)
				{
					x += vx * speed;
					traveled -= vx * speed;
				}
				else 
				{
					vx  *= 0.5;
					snapX();	
				}
			}
			if (vy > 0)
			{
				if (testPoint(rx,by+(vy*speed)) == 0 && testPoint(lx,by +(vy*speed)) == 0)
				{
					y += vy * speed;
					traveled += vy * speed;
				}
				else 
				{
					vy  *= 0.5;
					snapY();
				}
			}
			else if (vy < 0)
			{
				if (testPoint(rx,ty+(vy*speed)) == 0 && testPoint(lx,ty +(vy*speed)) == 0)
				{
					y += vy * speed;
					traveled -= vy * speed;
				}
				else 
				{
					vy *= 0.5;
					snapY();
				}
			}
			if (vx != 0 || vy != 0)
			{
				desiredAngle = Math.atan2(vy, vx) * 180 / Math.PI;
			}
			if(angle != desiredAngle)
			{
			
				var turnAmount = closestAngle(angle, desiredAngle)*.16;
			
				if(Math.abs(turnAmount) < .2)
				{
					angle = desiredAngle;
				}
				else
				{
					angle += turnAmount;
				}
			}
			if(angle > 180)
			{
				angle -= 360;
			}
			else if(angle < -180)
			{
				angle += 360;
			}
			Base.gotoAndStop(Math.round((angle + 180) / 5));
			if (traveled >= 8)
			{
				traveled = 0;
				game.decalFX.trax(x, y, angle);
			}
		}
		public function tempGrid(xp, yp):Point
		{
			var tx = Math.floor(xp / game.gridSize);
			var ty = Math.floor(yp / game.gridSize);
			return new Point(tx, ty);
		}
		public function snapY():void
		{
			y = gy * 32 + 16;
			updatePoints();
		}
		public function snapX():void
		{
			x = gx * 32 + 16;
			updatePoints();
		}
		public function testPoint(px,py):int
		{
			var cp = tempGrid(px,py);
			var rslt:int = game.map.getGrid(cp.x, cp.y);
		
			return rslt;
		}
		public function closestAngle(sta:Number, fin:Number):Number
		{
			var t:Number = fin-sta;
			t %= 360;
			t += 540;
			t %= 360;
			t -= 180;
			return t;
		}
	}
	
}