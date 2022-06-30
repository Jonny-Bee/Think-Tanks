package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class Gambler extends Sprite 
	{
		var game:Game;
		var Spinning:Boolean = false;
		var vy1:Number = 0;
		var vy2:Number = 0;
		var vy3:Number = 0;
		var spinSpeed:Number = 10;
		var stopTimer:int = 500;
		
		public function Gambler()
		{
			game = Game(parent);
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			spin();
		}
		
		public function update(evt:Event)
		{
			if (Spinning)
			{
				stopTimer --;
				if (vy1 != 0)
				{
					spinner1.y += vy1;
					spinner2.y += vy2;
					spinner3.y += vy3;
					if (stopTimer <= 0)
					{
						vy1 = 0;
						stopTimer = Math.random() * 100;
						spinner1.y = (Math.round(spinner1.y / 72) * 72);
					}
				}
				else if (vy2 != 0)
				{
					spinner2.y += vy2;
					spinner3.y += vy3;
					if (stopTimer <= 0)
					{
						vy2 = 0;
						stopTimer = Math.random() * 100;
						spinner2.y = (Math.round(spinner2.y / 72) * 72);
					}
				}
				else if (vy3 != 0)
				{
					spinner3.y += vy3;
					if (stopTimer <= 0)
					{
						vy3 = 0;
						spinner3.y = (Math.round(spinner3.y / 72) * 72);
						Spinning = false;
						getPositions();
					}
				}
				if (spinner1.y >= 0)
				{
					spinner1.y -= 288;
				}
				if (spinner2.y >= 0)
				{
					spinner2.y -= 288;
				}
				if (spinner3.y >= 0)
				{
					spinner3.y -= 288;
				}
			}
		}
		public function getPositions()
		{
			var s1 = Math.floor(spinner1.y / 72)-1;
			var s2 = Math.floor(spinner2.y / 72)-1;
			var s3 = Math.floor(spinner3.y / 72)-1;
			if (s1 == -5)
			{
				s1 = -1;
			}
			else if (s1 == -6)
			{
				s1 = -3;
			}
			if (s2 == -5)
			{
				s2 = -1;
			}
			else if (s2 == -6)
			{
				s2 = -3;
			}
			if (s3 == -5)
			{
				s3 = -1;
			}
			else if (s3 == -6)
			{
				s3 = -3;
			}
			trace(s1 + " " + s2 + " " + s3);
			if (s1 == s2 && s2 == s3)
			{
				getWin(s1);
			}
			else {
				getWin(0);
			}
		}
		public function spin()
		{
			vy1 = 10 + Math.random() * spinSpeed;
			vy2 = 10 + Math.random() * spinSpeed;
			vy3 = 10 + Math.random() * spinSpeed;
			Spinning = true;
			stopTimer = 100 + (Math.random() * 200);
		}
		public function getWin(rs:int)
		{
			switch(rs)
			{
				case -4:
				trace("Shot Speed Increased");
				break;
				case -3:
				trace("MaxShots Increased");
				break;
				case -2:
				trace("Tank Top Speed Increased");
				break;
				case -1:
				trace("Shot Bounces Increased");
				break;
				default:
				trace("sorry no prizes this time");
				break;
			}
		}
	}
	
}