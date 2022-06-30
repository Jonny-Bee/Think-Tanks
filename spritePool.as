package {
	import flash.display.BitmapData;
	
	public class spritePool {
		
		
		public var hit:BitmapData;
		public var trail:BitmapData;
		public var explosion1:BitmapData;
	
		
		public function spritePool()
		{
			hit = new hit1(320, 32);
			trail = new trail1(320, 32);
			explosion1 = new explode1(640, 64);
			
	
		}
		
		
	}
	
	
	
}