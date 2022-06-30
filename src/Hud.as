package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class Hud extends Sprite 
	{
		var game:Game;
		public function Hud()
		{
			game = Game(parent);
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		public function update(evt:Event)
		{
			score.text = String(game.levelScore);
			coins.text = String(game.coinsCollected);
			time..text = String(Math.round(game.levelTime/1000)+" secs");
			
		}
	}
	
}