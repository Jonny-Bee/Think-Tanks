package 
{
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class spriteFX 
	{
		var x:Number;
		var y:Number;
		var vx:Number;
		var vy:Number;
		var frames:Number;
		var frame:Number = 0;
		var currentFrame:int = 0;
		var sheet:BitmapData;
		var spriteSize:int;
		var game:Game;
		var framerate:Number;
		var drag:Number = 0;
		
		public function spriteFX(gm:Game,xp, yp, velx, vely, frms, sht,spSize,frate:Number = 1,drg:Number = .99)
		{
			game = gm;
			x = xp;
			y = yp;
			vx = velx;
			vy = vely;
			frames = frms;
			sheet = sht;
			spriteSize = spSize;
			framerate = frate;
			drag = drg;
		}
		public function tick(dt):void
		{
			x += vx * dt;
			y += vy * dt;
			vx *= drag;
			vy *= drag;
			frame += (framerate * dt);
			currentFrame = Math.floor(frame);
			if (currentFrame >= frames)
			{
				game.removeSprite(this);
				die();
			}
		}
		public function die():void
		{
			game = null;
			sheet = null;
			
		}
	}
	
}