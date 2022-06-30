package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author J Bartram
	 */
	public class Clicker extends Sprite
	{
		var game:Game;
		
		public function Clicker() 
		{
			game = Game(parent);
			addEventListener(MouseEvent.CLICK, playerFire, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, hMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, sMouse, false, 0, true);
		}
		public function playerFire(evt:MouseEvent)
		{
			game.playerFire(evt);
		}
		public function hMouse(evt:MouseEvent)
		{
			Mouse.hide();
		}
		public function sMouse(evt:MouseEvent)
		{
			Mouse.show();
		}
		
	}

}