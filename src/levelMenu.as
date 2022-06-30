package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class levelMenu extends Sprite 
	{
		public var game:Game;
		public function levelMenu()
		{
			game = Game(parent);
			mouseEnabled = false;
			BuildButtons();
		}
		
		private function BuildButtons():void
		{
			var lb:levelButton;
			var xp = 66;
			var yp = 112;
			for (var i = 1; i < 46; i++)
			{
				
				lb = new levelButton(game,i);
				lb.x = xp;
				lb.y = yp;
				addChild(lb);
				xp += 80;
				if (xp > 720)
				{
					yp += 80;
					xp = 66;
					
				}
			}
		}
	}
	
}