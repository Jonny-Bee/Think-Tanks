package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class shotUpgradeButton extends MovieClip 
	{

		var game:Game;
		var limit:int;
		var unlocked:Boolean;
		var cost:int;
		
		public function shotUpgradeButton(gm,lvl,cst)
		{
			game = gm;
			limit = lvl;
			buttonMode = true;
			mouseChildren = false;
			gotoAndStop(1);
			cost = cst;
			
			addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, hover, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, off, false, 0, true);
			
			if (game.gameData.playerShots == limit)
			{
				unlocked = true;
				if (game.gameData.credits < cost)
			{
				unlocked = false;
				alpha = .2;
			}
			}
			else if(game.gameData.playerShots > limit){
				unlocked = false;
				gotoAndStop(4);
			}
			else {
				unlocked = false;
				gotoAndStop(3);
			}
			
			
		}
		public function refresh():void
		{
				if (game.gameData.playerShots == limit)
			{
				unlocked = true;
				gotoAndStop(1);
				if (game.gameData.credits < cost)
			{
				unlocked = false;
				alpha = .2;
			}
			}
			else if(game.gameData.playerShots > limit){
				unlocked = false;
				gotoAndStop(4);
			}
			else {
				unlocked = false;
				gotoAndStop(3);
			}
		}
		public function clicked(evt:MouseEvent)
		{
			doAction();
		}
		public function doAction():void
		{
			if (unlocked)
			{
				game.gameData.upgradeShots();
				game.gameData.credits -= cost;
				unlocked = false;
				gotoAndStop(4);
				UpgradeMenu(parent).refresh();
				
			}
		}
		public function hover(evt:MouseEvent)
		{
			if (unlocked)
			{
				gotoAndStop(2);
			}
		}
		public function off(evt:MouseEvent)
		{
			if (unlocked)
			{
				gotoAndStop(1);
			}
		}
	
	

	}
	
}