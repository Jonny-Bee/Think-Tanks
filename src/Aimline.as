package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class Aimline extends Sprite 
	{
		var game:Game;
		
		
		public function Aimline()
		{
			
			game = Game(parent);
			mouseEnabled = false;
			mouseChildren = false;
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			
			
		}
		public function update(evt:Event)
		{
			if (game.player != null && !game.bPaused)
			{
				visible = game.player.visible;
				x = game.player.x;
				y = game.player.y-8;
				
				
				var a = game.mouseX - x;
				var b = game.mouseY - y;
				var xlen = Math.sqrt(a * a +b * b);
				var tAngle = Math.atan2(b, a) * 180 / Math.PI;
				rotation = tAngle;
				
				scaleX = xlen / 200;
			}
			else
			{
				visible = false;
			}
		}
	}
	
}