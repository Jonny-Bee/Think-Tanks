package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class shadyTank extends AIChar
	{
		public function shadyTank()
		{
			attack = .02;
			shotChance = .2;
			defend = 5;
			wander = 2;
			maxShots = 4;
			shotSpeed = 2;
			bounceCount = 1;
			baseSpeed =.9;
			scoreValue = 400;
		}
		
	}
	
}