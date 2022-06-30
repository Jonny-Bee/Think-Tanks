package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class RunDown extends Sprite 
	{
		public var game:Game;
		public var lvScore:int = 0;
		public var bnsScore:int = 0;
		public var collectScore:int = 0
		public var colScore:int = 0;
		public var tBonus:Number = 0;
		public var ttlScore:Number = 0;
		public var tScore:int = 0;
		public var allMyScores:int = 0;
		
		public function RunDown()
		{
			game = Game(parent);
			getScores();
			addEventListener(Event.ENTER_FRAME, showScores, false, 0, true);
			ttlScore = game.playerScore;
		}
		
		public function getScores()
		{
			totalScore.text = String(game.playerScore);
			tBonus = getTimeBonus();
			
			colScore = game.coinsCollected * 100;
			tScore = game.levelScore + tBonus + colScore;
			game.playerScore += tScore;
			game.gameData.saveLevel(game.currentLevel, tScore);
			for (var i = 1; i < 51; i++)
			{
				allMyScores += int(game.gameData.Levels[i]);
			}
			
		}
		public function submitScores():void
		{
			
			MovieClip(root).FogAPI.LibraryCall('ScoresUpdate', {score:allMyScores} );
		}
		public function showScores(evt:Event)
		{
			if (lvScore < game.levelScore)
			{
				lvScore += 10;
			}
			else if (bnsScore < tBonus)
			{
				lvScore = game.levelScore;
				bnsScore += 50;
			}
			else if (collectScore < colScore)
			{
				bnsScore = tBonus;
				collectScore += 20;
			}
			else
			{
				collectScore = colScore;
				totalScore.text = String(tScore);
			}
			lvlScore.text = String(lvScore);
			timeBonus.text = String(bnsScore);
			collectedBonus.text = String(collectScore);
			
		}
		
		public function getTimeBonus():int
		{
			var time = Math.round(game.levelTime / 1000);
			var rtScore:int = 0;
			if (time > 120)
			{
				rtScore = 0;
			}
			else if (time > 90)
			{
				rtScore = 50;
			}
			else if (time > 80)
			{
				rtScore = 60;
			}
			else if (time > 70)
			{
				rtScore = 100;
			}
			else if (time > 60)
			{
				rtScore = 200;
			}
			else if (time > 50)
			{
				rtScore = 300;
			}
			else if (time > 40)
			{
				rtScore = 500;
			}
			else if (time > 30)
			{
				rtScore = 1000;
			}
			else if (time > 25)
			{
				rtScore = 1500;
			}
			else if (time > 20)
			{
				rtScore = 2000;
			}
			else if (time > 15)
			{
				rtScore = 2500;
			}
			else if (time > 10)
			{
				rtScore = 3000;
			}
			else if (time > 5)
			{
				rtScore = 5000;
			}
			else {
				rtScore = 10000;
			}
			return rtScore;
		}
	}
	
}