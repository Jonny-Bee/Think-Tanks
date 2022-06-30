package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class retryButton extends gameButton 
	{
		override public function doAction():void
		{
			
			game.newLevel(game.currentLevel);
				
		}
	}
	
}