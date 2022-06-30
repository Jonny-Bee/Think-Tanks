package 
{
	import flash.net.SharedObject;
	public class GameInfo
	{
		
		public var credits:int = 0;
		public var Levels:Array;

		public var game:Game;
		public var GameData:SharedObject;
		
		
		public var playerSpeed:Number = .8;
		public var playerShots:int = 3;
		public var playerBounce:int = 1;
		public var shotSpeed:Number = 2;

		public function GameInfo(bNew:Boolean,gm:Game)
		{
			game = gm;
			GameData = SharedObject.getLocal("TA-27", "/", false);
			if (GameData.data.bPlayed == 1)
			{
				LoadData();
			}
			else {
				createNewData();
			}
		
		}
		// upgrades//////////////////////////////
		public function upgradeSpeed():void
		{
			if (playerSpeed < 1.4)
			{
				playerSpeed += .1;
				saveData();
			}
		}
		public function upgradeBounce():void
		{
			if (playerBounce < 6)
			{
				playerBounce ++;
				saveData();
			}
		}
		public function upgradeShots():void
		{
			if (playerShots < 8)
			{
				playerShots ++;
				saveData();
			}
		}
		public function upgradeShotSpeed():void
		{
			if (shotSpeed < 3)
			{
				shotSpeed += .2;
				saveData();
			}
		}
		
		public function saveLevel(lvl:int, Score:int):void
		{
			if (int(Levels[lvl]) < Score)
			{
				Levels[lvl] = Score;
				saveData();
				
			}
		}
		
		
		
		public function addCredit(amount)
		{
			credits += amount;
			GameData.data.credits = credits;
			saveData();
		}
		// loading///////////////////////////////////
		public function LoadData():void
		{
			GameData.data.bPlayed = 1;
			credits = int(GameData.data.credits);

			Levels = new Array();
			for (var i = 0; i < 46; i++)
			{
				Levels.push(int(GameData.data["Level" + i]));
				
			}
			playerSpeed = GameData.data.speed;
			playerShots = GameData.data.shots;
			playerBounce = GameData.data.bounce;
			shotSpeed = GameData.data.shotSpeed;
			
		}
		//Saving//////////////////////////////////////
		public function saveData():void
		{
			GameData.data.bPlayed = 1;
			GameData.data.credits = credits;
			
			GameData.data.speed = playerSpeed;
			GameData.data.shotSpeed = shotSpeed;
			GameData.data.bounce = playerBounce;
			GameData.data.shots = playerShots;
			
			for (var i = 0; i < 50; i++)
			{
				GameData.data["Level" + i] = int(Levels[i]);
				
			}
			
			
		}
		// build new data///////////////////////////////
		public function createNewData():void
		{
			credits = 50;
			
			Levels = new Array();
			
			
			
			for (var i = 0; i < 50; i++)
			{
				Levels.push(0);
				
			}
			Levels[0] = 1;
			saveData();
			
		}
		

	}
	
}