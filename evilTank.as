package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class evilTank extends AIChar
	{
		public function evilTank()
		{
			attack = .02;
			shotChance = .2;
			defend = 4;
			wander = 4;
			maxShots = 3;
			shotSpeed = 2.8;
			bounceCount = 1;
			baseSpeed = 1.1;
			scoreValue = 1000;
		}
		
	}
	
}