package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class DeathTank2 extends AIChar
	{
		public function DeathTank2()
		{
			attack = .01;
			shotChance = .3;
			defend = 1;
			wander = 2;
			maxShots = 1;
			shotSpeed = 3.5;
			bounceCount = 3;
			baseSpeed = 1.1;
			scoreValue = 700;
		}
		
	}
	
}