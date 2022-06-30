package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class crossHair extends Sprite 
	{
		var game:Game;
		public function crossHair()
		{
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			game = Game(parent);
			mouseEnabled = false;
			mouseChildren = false;
		}
		public function update(evt:Event)
		{
			x = game.mouseX;
			y = game.mouseY;
		}
	}
	
}