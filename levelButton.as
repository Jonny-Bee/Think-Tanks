package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class levelButton extends MovieClip 
	{
		var game:Game;
		var level:int;
		var unlocked:Boolean;
		
		public function levelButton(gm,lvl)
		{
			game = gm;
			level = lvl;
			buttonMode = true;
			mouseChildren = false;
			gotoAndStop(1);
			lvlNum.text = String(lvl);
			lvlNum.selectable = false;
			addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, hover, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, off, false, 0, true);
			if (game.gameData.Levels[lvl-1] != 0)
			{
				unlocked = true;
			}
			else {
				unlocked = false;
				gotoAndStop(3);
			}
			lvlScore.text = String(game.gameData.Levels[lvl]);
		}
		public function clicked(evt:MouseEvent)
		{
			doAction();
		}
		public function doAction():void
		{
			if (unlocked)
			{
				game.newLevel(level);
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