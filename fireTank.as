package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class fireTank extends AIChar
	{
		public function fireTank()
		{
			attack = .0001;
			shotChance = .1;
			defend = 4;
			wander = 4;
			maxShots = 1;
			shotSpeed = 4;
			bounceCount = 0;
			baseSpeed = 1.0;
			scoreValue = 1500;
		}
		
	}
	
}