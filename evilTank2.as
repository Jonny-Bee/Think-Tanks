package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class evilTank2 extends AIChar
	{
		public function evilTank2()
		{
			attack = .001;
			shotChance = .2;
			defend = 4;
			wander = 4;
			maxShots = 5;
			shotSpeed = 2.5;
			bounceCount = 0;
			baseSpeed = 1.2;
			scoreValue = 1500;
		}
		
	}
	
}