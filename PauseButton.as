package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class PauseButton extends MovieClip 
	{
		var game:Game;
		var hud:Hud;
		var primed:Boolean;
		public function PauseButton()
		{
			game = Game(parent);
			
			
			addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
			addEventListener(Event.ENTER_FRAME, ticker, false, 0, true);
			
			gotoAndStop(1);
			
		}
		public function ticker(evt:Event)
		{
			if (game.isDown(80))
			{
				primed = true;
			}
			else
			{
				if (primed)
				{
					primed = false;
					clicked();
				}
			}
			
		}
		public function clicked(evt:MouseEvent = null):void
		{
			if (game.bPaused)
			{
				game.bPaused = false;
				gotoAndStop(1);
			}
			else
			{
				game.bPaused = true;
				gotoAndStop(2);
				
			}
			
		}
		
			
	}
	
}