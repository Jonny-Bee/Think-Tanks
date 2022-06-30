package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class staticTank2 extends AIChar
	{
		public function staticTank2()
		{
			attack = .3;
			defend = 0;
			wander = 0;
			maxShots = 3;
			shotSpeed = 4;
			bounceCount = 0;
			baseSpeed = 0;
			bStatic = true;
			shotChance = .6;
			scoreValue = 300;
		}
		
		override public function chooseAction():String
		{
			
			Enemy = getClosestEnemy();
			
			
			
			return "seeking";
		}
		override public  function getDir():void
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
			

			vx = 0;
			vy = 0;
			if (Enemy != null)
			{
				rotate();
			}
			else {
				Enemy = getClosestEnemy();
			}
			
			
		}
	
		
	}
	
}