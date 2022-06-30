package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class GameTile extends Sprite 
	{
		public var game:Game;
		public var gx:int;
		public var gy:int;
		public var type:int = 1;
		
		public function GameTile()
		{
			game = Game(parent);
			visible = false;
		}
		
		public function addTile():void
		{
			gx = Math.floor(x / game.gridSize);
			gy = Math.floor(y / game.gridSize);
			game.map.setGrid(gx, gy, type);
			//visible = false;
		}
	}
	
	
	
}