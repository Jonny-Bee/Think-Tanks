package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class lightTank extends AIChar
	{
		public function lightTank()
		{
			attack = .03;
			shotChance = .1;
			defend = 1;
			wander = 2;
			maxShots = 1;
			shotSpeed = 2;
			bounceCount = 1;
			baseSpeed = .6;
			scoreValue = 100;
		}
		
	}
	
}