package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class UpgradeMenu extends Sprite 
	{
		public var game:Game;
		public var buttons:Array = new Array();
		
		public function UpgradeMenu()
		{
			game = Game(parent);
			mouseEnabled = false;
			BuildButtons();
			
		}
		public function refresh():void
		{
			for (var i in buttons)
			{
				buttons[i].refresh();
			}
			outputText.text = String(game.gameData.credits );
		}
		private function BuildButtons():void
		{
			var lb;
			var xp = 296;
			var yp = 152;
			for (var i = 1; i < 6; i++)
			{
				
				lb = new shotUpgradeButton(game,i+2,i*50);
				lb.x = xp;
				lb.y = yp;
				addChild(lb);
				buttons.push(lb);
				xp += 80;
				
			}
			xp = 296;
			yp += 64
			for ( i = 1; i < 6; i++)
			{
				
				lb = new bounceUpgradeButton(game,i,i*50);
				lb.x = xp;
				lb.y = yp;
				addChild(lb);
				buttons.push(lb);
				xp += 80;
				
			}
			xp = 296;
			yp += 64
			for ( i = 1; i < 6; i++)
			{
				
				lb = new shotSpeedUpgradeButton(game,1.8 + (i * .2),i*50);
				lb.x = xp;
				lb.y = yp;
				addChild(lb);
				buttons.push(lb);
				xp += 80;
				
			}
			xp = 296;
			yp += 64
			for ( i = 0; i < 5; i++)
			{
				
				lb = new speedUpgradeButton(game,.8 + (i * .1),(i+1)*50);
				lb.x = xp;
				lb.y = yp;
				addChild(lb);
				buttons.push(lb);
				xp += 80;
				
			}
			outputText.text = String(game.gameData.credits );
		}
	}
	
}