package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class SpinButton extends MovieClip 
	{
		var owner:Gambler;
		public function SpinButton()
		{
			owner = Gambler(parent);
			buttonMode = true;
			gotoAndStop(1);
			addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, hover, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, off, false, 0, true);
			
		}
		public function clicked(evt:MouseEvent)
		{
			doAction();
		}
		public function doAction():void
		{
			owner.spin();
		}
		public function hover(evt:MouseEvent)
		{
			gotoAndStop(2);
		}
		public function off(evt:MouseEvent)
		{
			gotoAndStop(1);
		}
		
	}
	
}