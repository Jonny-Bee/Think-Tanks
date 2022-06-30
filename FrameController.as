package{
	
	import flash.display.Sprite;
	import Game;
	import flash.events.Event;
	
	public class FrameController extends Sprite{
		
		var targetFrame:int;
		var owner:Game;
		var bRunning:Boolean = false;
		var arrived:Boolean;
		
		public function FrameController()
		{
			owner = Game(parent);
			owner.frameController = this;
			addEventListener(Event.ENTER_FRAME, tick);
			alpha = 1;
			visible = true;
			mouseEnabled = false;
			getFrame(1);
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		public function getFrame(num:int):void
		{
			targetFrame = num;
			bRunning = true;
			visible = true;
			arrived = false;
			
			
		}
		
		private function tick(evt:Event):void
		{
			if(bRunning)
			{
				if(!arrived)
				{
					if(alpha < 1)
					{
						alpha += .02;
					}
					else
					{
						arrived = true;
						owner.gotoAndStop(5);
						owner.gotoAndStop(targetFrame);
						owner.arrived(targetFrame);
						
					}
				}
				else
				{
					if(alpha > 0)
					{
						alpha -= .02;
					}
					else
					{
						bRunning = false;
						visible = false
						
						alpha = 0;
						
					}
				}
			}
		}
		
		
		
		
		
		
	}
	
	
	
}