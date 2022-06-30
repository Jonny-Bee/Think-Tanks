package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class staticTank3 extends AIChar
	{
		public function staticTank3()
		{
			attack = .3;
			defend = 0;
			wander = 0;
			maxShots = 1;
			shotSpeed = 3.5;
			bounceCount = 4;
			baseSpeed = 0;
			bStatic = true;
			shotChance = .4;
			scoreValue = 400;
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