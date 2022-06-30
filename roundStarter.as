package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class roundStarter extends Sprite 
	{
		public var game:Game;
		public var ticker:int = 0;
		var soundBlip:int = 0;
		
		public function roundStarter()
		{
			game = Game(parent);
			game.bPaused = true;
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		public function update(evt:Event)
		{
			ticker ++;
			if (ticker < 70)
			{
				myText.text = String("Level " + game.currentLevel);
			}
			else if (ticker < 110)
			{
				if (soundBlip < 1)
				{
					soundBlip ++;
					game.SoundManager.playShot("beep");
				}
				myText.text = "Ready";
			}
			else if (ticker < 150)
			{
				if (soundBlip < 2)
				{
					soundBlip ++;
					game.SoundManager.playShot("beep");
				}
				myText.text = "STEADY";
			}
			else if (ticker < 190)
			{
				if (soundBlip < 3)
				{
					soundBlip ++;
					game.SoundManager.playShot("beep");
				}
				myText.text = "GO!!";
			}
			else if(ticker < 200)
			{
				myText.text = "--";
				ticker = 1000;
				destroy();
			}
		}
		public function destroy():void
		{
			visible = false;
			game.startRound();
			game.bPaused = false;
			removeEventListener(Event.ENTER_FRAME, update);
			parent.removeChild(this);
		}
	}
	
}