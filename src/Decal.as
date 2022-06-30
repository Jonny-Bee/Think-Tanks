package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	
	public class Decal extends Sprite {
		
		var game:Game;
		
		var canvas:BitmapData;
		var DisplayScreen:Bitmap;
		var clearRec:Rectangle;
		var items:Array = new Array();
		
		var crater:BitmapData;
		var Track:BitmapData;
		
		
		
		var gs:int;
		var hs:int;
		
		public function Decal()
		{
			game = Game(parent);
			game.decalFX = this;
			gs = game.gridSize;
			hs = gs * .5;
			crater = new crater1(192, 48);
			Track = new Track1(32, 32);
			
			
		
			
			this.mouseEnabled = false;
			
			canvas = new BitmapData(768, 512, true, 0x000000); // may need changing
			clearRec = new Rectangle(0, 0, 800, 600);
			DisplayScreen = new Bitmap(canvas);
			addChild(DisplayScreen);
		}
		
		public function trax(xp, yp, angle)
		{
			var angle_in_radians = angle/180*Math.PI;
            var rotationMatrix:Matrix = new Matrix();
			rotationMatrix.translate(-16,-16);
			rotationMatrix.rotate(angle_in_radians);
			rotationMatrix.translate(16,16);
			var matrixImage:BitmapData = new BitmapData(32, 32, true, 0x00000000);
			matrixImage.draw(Track, rotationMatrix);
			var rec = new Rectangle(0, 0, 32, 32);
			canvas.copyPixels(matrixImage, rec, new Point(xp - 16, yp - 16), null, null, true);

		}
		public function Crater(xp, yp)
		{
			xp += (-4 + Math.random() * 8)
			yp += (-4 + Math.random() * 8)
			var frame = Math.random() * 3.9;
			var rec = new Rectangle(Math.floor(frame)*64, 0, 64, 64);
			canvas.copyPixels(crater, rec, new Point(xp - 32, yp - 32), null, null, true);
			
			
		}
		
		
		
		
	}
}