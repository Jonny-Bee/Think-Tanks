package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class Marker extends Sprite 
	{
		var game:Game;
		public function Marker()
		{
			
			game = Game(parent);
			mouseEnabled = false;
			mouseChildren = false;
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		public function update(evt:Event)
		{
			if (game.player != null)
			{
				x = game.player.x;
				y = game.player.y;
				rotation += 1;
				visible = game.player.visible;
			}
		}
	}
	
}