package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class PlayerChar extends GameChar 
	{
		public var shots:int = 2;
		public var bounce:int = 1;
		public var shotSpeed = 2;
		public var pPrimed:Boolean;
		
		public function PlayerChar()
		{
			game = Game(parent.parent);
			game.player = this;
			
			shots = game.gameData.playerShots;
			bounce = game.gameData.playerBounce;
			shotSpeed = game.gameData.shotSpeed;
			baseSpeed = game.gameData.playerSpeed;
			mouseEnabled = false;
			mouseChildren = false;
		
		}
		public function setPowerUp():void
		{
			shots = game.gameData.playerShots;
			bounce = game.gameData.playerBounce;
			shotSpeed = game.gameData.shotSpeed;
			baseSpeed = game.gameData.playerSpeed;
		}
		public override function fire():void
		{
			if (!game.bPaused)
			{
			if (shotCount < shots && visible)
			{
				shotCount ++;
		
				var a = (stage.mouseX - x);
				var b = (stage.mouseY - y);
				var c = Math.sqrt(a * a + b * b);
				var velx = (a / c) * shotSpeed;
				var vely = (b / c) * shotSpeed;
				
				var shot:Projectile = new Projectile(this, game, x + (velx * 10),y + (vely * 10), velx, vely,bounce);
				parent.addChild(shot);
				game.projectiles.push(shot);
				game.SoundManager.playShot("shot1");
			}
			}
		}
		public override function takeHit(actor):void
		{
			if (!bDead)
			{
				bDead = true;
				visible = false;
				var f = new spriteFX(game, x, y, 0, 0, 9, game.SpritePool.explosion1, 128,.3);
				game.fx.push(f);
				game.decalFX.Crater(x,y);
				game.SoundManager.playShot("explode");
				game.restart();
			}
		}
		public override function getDir():void
		{
			var f;
			for (var r in game.enemies)
			{
				f = game.enemies[r];
				
				if (f.gx >= gx-1 && f.gx <= gx + 1)
				{
					if (f.gy >= gy-1 && f.gy <= gy + 1)
					{
						var a = x - f.x ;
						var b = y - f.y ;
						var plen = Math.sqrt(a * a + b * b);
						if (plen < 32)
						{
							var pen = plen - 32;
							vx -= ((a / plen) * pen)*.5;
							vy -= ((b / plen) * pen)*.5;
							f.vx += ((a / plen) * pen)*.5;
							f.vy += ((b / plen) * pen)*.5;
						}
						
					}
				}
					
				
			}
			if (game.isDown(38) || game.isDown(87))
			{
				vy += -.2;
			}
			else if (game.isDown(40) || game.isDown(83))
			{
				vy += .2;
			}
		
			if (game.isDown(37) || game.isDown(65))
			{
				vx += -.2;
			}
			else if (game.isDown(39) || game.isDown(68))
			{
				vx += .2;
			}
		
			
		/*	if (game.isDown(32) && bCanShootSpecial)
			{
				bCanShootSpecial = false;
				fireSpecial();
			}
			else if (!game.isDown(32))
			{
					bCanShootSpecial = true;
			}*/
			var ax = (stage.mouseX - x);
			var ay = (stage.mouseY - y);
			var tAngle = Math.atan2(ay, ax) * 180 / Math.PI;
			turret.gotoAndStop(Math.round((tAngle + 180) / 5));
			
			
		}
	}
	
	
	
}