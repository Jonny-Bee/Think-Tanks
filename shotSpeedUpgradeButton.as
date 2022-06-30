package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class shotSpeedUpgradeButton extends MovieClip 
	{

		var game:Game;
		var limit:Number;
		var unlocked:Boolean;
		var cost:int;
		
		public function shotSpeedUpgradeButton(gm,lvl,cst)
		{
			game = gm;
			limit = Math.floor(lvl*10);
			buttonMode = true;
			mouseChildren = false;
			gotoAndStop(1);
			cost = cst;
			addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, hover, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, off, false, 0, true);
			var ps = Math.floor(game.gameData.shotSpeed * 10);
			if (ps == limit)
			{
				unlocked = true;
				if (game.gameData.credits < cost)
				{
				unlocked = false;
				alpha = .2;
				}
			}
			else if(ps > limit){
				unlocked = false;
				gotoAndStop(4);
			}
			else {
				unlocked = false;
				gotoAndStop(3);
			}
			trace(ps + " " + limit);
			
			
		}
		public function refresh():void
		{
			var ps = Math.floor(game.gameData.shotSpeed * 10);
			if (ps == limit)
			{
				unlocked = true;
				gotoAndStop(1);
				if (game.gameData.credits < cost)
				{
				unlocked = false;
				alpha = .2;
				}
			}
			else if(ps > limit){
				unlocked = false;
				gotoAndStop(4);
			}
			else {
				unlocked = false;
				gotoAndStop(3);
			}
			trace(ps + " " + limit);
		}
		public function clicked(evt:MouseEvent)
		{
			doAction();
		}
		public function doAction():void
		{
			if (unlocked)
			{
				game.gameData.upgradeShotSpeed();
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