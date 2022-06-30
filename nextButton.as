package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class nextButton extends gameButton 
	{
		override public function doAction():void
		{
			
			game.newLevel(game.currentLevel + 1);
				
		}
	}
	
}