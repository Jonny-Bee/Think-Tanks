package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Renderer extends Sprite {
		
		var game:Game;
		
		var canvas:BitmapData;
		var DisplayScreen:Bitmap;
		var clearRec:Rectangle;
		
		var items:Array = new Array();
		
		public function Renderer()
		{
			//mouseEnabled = true;
			game = Game(parent);
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
			
			
			this.mouseEnabled = false;
			canvas = new BitmapData(800, 600, true, 0x000000); // may need changing
	
			clearRec = new Rectangle(0, 0, 768, 512);
			DisplayScreen = new Bitmap(canvas);
			addChild(DisplayScreen);
			mouseEnabled = false;
			mouseChildren = false;
		
		}
		
		
		public function Tick(evt:Event):void
		{
			//clear canvas
			canvas.fillRect(clearRec, 0x000000);
			//render(game.player.x, game.player.y);
			game.sortActors();
			var fxn = game.fx.length;
			for (var i = fxn - 1; i > -1;i-- )
			{
				renderSprite(game.fx[i]);
			}
	
			
		}
		private function renderSprite(sprite:spriteFX):void
		{
			var bSize = sprite.spriteSize;
			var xp = sprite.x;
			var yp = sprite.y;
			var imRec:Rectangle = new Rectangle(sprite.currentFrame * bSize, 0, bSize, bSize);
			
			var sPoint:Point = new Point(xp -(bSize * .5), yp - (bSize * .5));
			canvas.copyPixels(sprite.sheet, imRec, sPoint, null, null, true);
			
				
			
		}
		private function render(xp:Number, yp:Number):void
		{
		
			var imRec:Rectangle = new Rectangle(0, 0, 768, 512);
			var mat = new Matrix(1, 0, 0, 1, 0, 0);
			
			canvas.draw(game.level, mat, null, null, imRec, true);
			
			
				
				
			
		}
		
		
	}
}