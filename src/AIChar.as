package 
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class AIChar extends GameChar 
	{
		var state:String = "seeking"; // health, ammo, chase, run,charging,reloading
		var path:Array;
		var target:Point;
		var lastTarget:Point;
		private var visited:Array = new Array();
		var Enemy:GameChar;
		var intel:Number = .2;
		var aiTimer:Number = 0;
		var aim:Point;
		var aimvx:Number;
		var aimvy:Number;
		
		//stats
		var attack:Number = .1;
		var shotChance:Number = .1;
		var defend:Number = 3;
		var wander:Number = 3;
		var shotSpeed:Number = 2;
		var bounceCount:Number = 1;
		var maxShots:int = 2;
		var bStatic:Boolean = false;
		
		var bCanSee:Boolean = false;
		var shotTimer = 0;
		var scoreValue:int = 200;
		var htTick:int = 0;
		
		public function AIChar()
		{
			game = Game(parent.parent);
			game.enemies.push(this);
			var w = game.map.width;
			var h = game.map.height;
			mouseEnabled = false;
			mouseChildren = false;
			{
				for (var i = 0; i < w; i++)
				{
					visited[i] = new Array();
					for (var j = 0; j < h; j++)
					{
						visited[i].push(0);
					}
				}
			}
			
			
		}
		override public function collideObjects():void
		{
		
		}
		public override function takeHit(actor):void
		{
			if (!bDead)
			{
				bDead = true;
				game.removeEnemy(this);
				game.SoundManager.playShot("explode");
				
			}
		}
		public override function fire():void
		{
			if (shotCount < maxShots && shotTimer > 20)
			{
				shotTimer = 0;
				shotCount ++;
				var velx = aimvx * shotSpeed;
				var vely = aimvy * shotSpeed;
				
				var shot:Projectile = new Projectile(this, game, x + (velx * 10),y + (vely * 10), velx, vely,bounceCount,true);
				parent.addChild(shot);
				game.projectiles.push(shot);
				game.SoundManager.playShot("shot1");
			}
		}
		public function chooseAction():String
		{
			
			Enemy = getClosestEnemy();
			path = new Array();
			target = null;
			
			
			var chs = attack;
			var rn = defend;
			
			var seek = wander;
			var total = (chs + rn + seek);
			
			rn += seek;
			var st:String = "";
			var choice = Math.random() * total;
			if (choice <= seek)
			{
				st = "seeking";
			}
			else if ( choice <= rn)
			{
				st = "run";
			}
			else {
				st = "chase";
			}
			
			return st;
		}
		
		public override function getDir():void
		{
			shotTimer ++;
			if (Math.random() < shotChance)
			{
					if((canSee(Enemy)))
					{
						//trace("fire");
						bCanSee = true;
						fire();
					}
					else{
					//trace("cant see");
					bCanSee = false;
					}
					
			}	
			if (!bStatic)
			{
			var f;
			htTick ++;
			/*if (htTick > 2 && state != "dodge")
			{
				htTick = 0;
				for (var q in game.projectiles)
				{
					f = game.projectiles[q];
					if (f.owner == game.player)
					{
						if (f.gx >= gx-2 && f.gx <= gx + 2)
						{
							if (f.gy >= gy-2 && f.gy <= gy + 2)
							{
								state = "dodge";
								
							}
						}
						
					}
				}
			}*/
			if (htTick > 2)
			{
				htTick = 0;
			for (var r in game.enemies)
			{
				f = game.enemies[r];
				if (f != this)
				{
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
			}
			}
			if (Enemy != null)
			{
				rotate();
				
			}
			else {
				Enemy = getClosestEnemy();
			}
			if (target == null)
			{
				aiTimer = 0;
			}
			aiTimer --;
			if (aiTimer <= 0)
			{
				aiTimer = Math.random() * 200;
				state = chooseAction();
			}
			if (state == "seeking")
			{
				if (target != null)
				{
					if (inGrid(target))// check if arrived at target square if true enum next target based on state
					{
						getNewTarget();
					}
					else {
						var tvx = (target.x*32)+16 - x;
						var tvy = (target.y*32)+16 - y;
						var dlen = Math.sqrt(tvx * tvx + tvy * tvy);
						vx += (tvx / dlen) * .15;
						vy += (tvy / dlen) * .15;
					}
				}
				else {
					getNewTarget();
				}
			}
			else if (state == "chase")
			{
				if (!bCanSee)
				{
					if (path.length <= 0)
					{
						 
						var cur = Enemy;
						
						var np = new Point(cur.gx, cur.gy);

						path = game.map.findPath(gx, gy, np.x, np.y);
						var my = Number(path.pop());
						var mx = Number(path.pop());
						target = new Point(mx, my);
						
					}
					else
					{
						if (inGrid(target))
						{
							var my = Number(path.pop());
							var mx = Number(path.pop());
							target = new Point(mx, my);
						
						}
						else {
							var tvx = (target.x*32)+16 - x;
							var tvy = (target.y*32)+16 - y;
							var dlen = Math.sqrt(tvx * tvx + tvy * tvy);
							vx += (tvx / dlen) * .2;
							vy += (tvy / dlen) * .2;
						}
					}
				}
				else
				{
					if (target != null)
					{
						if (inGrid(target))
						{
							getNewTarget();
						}
						else {
							var tvx = (target.x*32)+16 - x;
							var tvy = (target.y*32)+16 - y;
							var dlen = Math.sqrt(tvx * tvx + tvy * tvy);
							vx += (tvx / dlen) * .15;
							vy += (tvy / dlen) * .15;
						}
					}
					else {
						getNewTarget();
						}
					}
				
				
			}
			else if (state == "run")
			{
				
				if (path.length <= 0)
				{
					np = getSafeSquare();
					path = game.map.findPath(gx, gy, np.x, np.y);
					var my = Number(path.pop());
					var mx = Number(path.pop());
					target = new Point(mx, my);
				}
				else
				{
					if (inGrid(target))
					{
						var my = Number(path.pop());
						var mx = Number(path.pop());
						target = new Point(mx, my);
					}
					else {
						var tvx = (target.x*32)+16 - x;
						var tvy = (target.y*32)+16 - y;
						var dlen = Math.sqrt(tvx * tvx + tvy * tvy);
						vx += (tvx / dlen) * .2;
						vy += (tvy / dlen) * .2;
					}
				}
				
				
			}
			else if (state == "dodge")
			{
				var tvx = 0;
				var tvy = 0;
				var pCount = 0;
				for (var q in game.projectiles)
				{
					var f = game.projectiles[q];
					if (f.owner == Enemy)
					{
						if (f.gx >= gx-2 && f.gx <= gx + 2)
						{
							if (f.gy >= gy-2 && f.gy <= gy + 2)
							{
								var a = x - (f.x + (f.vx*5));
								var b = y - (f.y + (f.vy*5));
								var plen = Math.sqrt(a * a + b * b);
								if( plen <= 128)
								{
									tvx += (a  / plen) * .2;
									tvy += (b / plen) * .2;
									
									pCount += 1;
								}
								
							}
						}
						
					}
				}
				if (pCount > 0)
				{
					vx += tvx / pCount;
					vy += tvy / pCount;
				}
				else {
					aiTimer = 0;
				}
			}
			}
			else {
				vx = 0;
				vy = 0;
				aiTimer --;
				if (aiTimer <= 0)
				{
					aiTimer = 10;
					state = chooseAction();
				}
				if (Enemy != null)
				{
					rotate();
				}
				else {
					Enemy = getClosestEnemy();
				}
			}
			
		}
		public function inGrid(pt:Point):Boolean
		{
			if (gx == pt.x && gy == pt.y)
			{
				return true;
			}
			else {
				return false;
			}
		}
		public function getNewTarget():void
		{
			if (state == "seeking")
			{
				target = checkNineGrid();
			
				
				visited[target.x][target.y] = getTimer();
				
			}
		}
		public function getSafeSquare():Point
		{
			var tpx = game.player.gx;
			var tpy = game.player.gy;
			tpx -= 12;
			tpy -= 8;
			tpy *= -1;
			tpy *= -1;
			tpx += 12;
			tpy += 8;
			var rsd:Array = new Array();
			for (var i = tpx - 2; i < tpx + 3; i++)
			{
				for (var j = tpy - 2; j < tpy + 3; j++)
				{
					if (game.map.getGrid(i, j) == 0)
					{
						rsd.push(new Point(i, j));
					}
				}
				
			}
			var sl = Math.floor(Math.random() * rsd.length);
			return rsd[sl];
		}
		public function checkNineGrid():Point
		{
			var rsd:Array = new Array();
			for (var i = gx - 1; i < gx + 2; i++)
			{
				for (var j = gy - 1; j < gy + 2; j++)
				{
					if (game.map.getGrid(i, j) != 1)
					{
						rsd.push(new Point(i, j));
					}
				}
				
			}
			var sel = rsd[0];
			for (var k in rsd)
			{
				var c = rsd[k];
				if (visited[c.x][c.y] < visited[sel.x][sel.y])
				{
					if (Math.random() < .9)
					{
						sel = c;
					}
						
				}
				
			}
			return sel;
		}
		public function rotate():void
		{
			var nme = Enemy;
			var a:Number = nme.x - x;
			var b:Number = nme.y - y;
			var c = Math.sqrt(a * a + b * b);
			var tAngle = Math.atan2(b, a) * 180 / Math.PI;
			var ax = a / c;
			var ay = b / c;
			aimvx = ax;
			aimvy = ay;
			if(aimAngle != tAngle)
			{
			
				var turnAmount = closestAngle(aimAngle, tAngle)*.1;
			
				if(Math.abs(turnAmount) < .1)
				{
					aimAngle = tAngle;
				}
				else
				{
					aimAngle += turnAmount;
				}
			} 
			if(aimAngle > 180)
			{
				aimAngle -= 360;
			}
			else if(aimAngle < -180)
			{
				aimAngle += 360;
			}
			turret.gotoAndStop(Math.round((aimAngle+180) / 5));
		}
		public function canSee(nme:GameChar):Boolean
		{
			var rslt:Boolean = false;
			if (nme != null && nme.visible)
			{
			var a:Number = nme.x - x;
			var b:Number = nme.y - y;
			var c = Math.sqrt(a * a + b * b);
			var testPoint:Point;
			var bContinue:Boolean = true;
			var ax = a / c;
			var ay = b / c;
			aimvx = ax;
			aimvy = ay;
			var mm:int = 5;
			
			while (bContinue)
			{
				testPoint = tempGrid(x + (ax * mm), y + (ay * mm));
				if (game.map.getGrid(testPoint.x, testPoint.y) == 1)
				{
					bContinue = false;
					rslt = false
				}
				else if (testPoint.x == nme.gx && testPoint.y == nme.gy)
				{
					bContinue = false;
					rslt = true;
				}
				mm += 10;
			}
			}
			return rslt;
			//TODO: perform raycast to enemy checking for wall collision
			
		}
	
	
	}
	
}