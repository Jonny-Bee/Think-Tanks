package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class DeathTank extends AIChar
	{
		public function DeathTank()
		{
			attack = .03;
			shotChance = .3;
			defend = 1;
			wander = 2;
			maxShots = 2;
			shotSpeed = 3;
			bounceCount = 2;
			baseSpeed = 1.0;
			scoreValue = 500;
		}
		
	}
	
}