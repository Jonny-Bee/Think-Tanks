package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class muteButton extends MovieClip
	{
		var game:Game;
		public function muteButton()
		{
			game = Game(parent);
			addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
			addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
		}
		
		public function clicked(evt:MouseEvent):void
		{
			
				game.SoundManager.mute();
			
		}
		public function tick(evt:Event):void
		{
			if (game.SoundManager.bMute)
			{
			
				gotoAndStop(2);
			}
			else
			{
				gotoAndStop(1);
			}
		}
			
	}
	
}