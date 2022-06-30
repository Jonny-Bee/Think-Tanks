package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class breakBlock extends Sprite 
	{
		var gx:int;
		var gy:int;
		var game:Game;
		var hits:int = 0;
		
		public function breakBlock()
		{
			game = Game(parent.parent);
			gx = Math.floor(x / game.gridSize);
			gy = Math.floor(y / game.gridSize);
			game.objects.push(this);
		}
		public function update(dt):void
		{
			for (var q in game.projectiles)
			{
				var f = game.projectiles[q];
			
					if (f.gx == gx && f.gy == gy)
					{
						
							f.destroy();
							takeHit();
							
							
						
					}
					
				
			}
		}
		public function takeHit():void
		{
			hits ++;
			block.nextFrame();
			if (hits > 2)
			{
				destroyed();
			}
		}
		public function collected(actor)
		{
			
		}
		public function destroyed( ):void
		{
				visible = false;
				game.map.setGrid(gx, gy, 0);
				game.SoundManager.playShot("explode");
				var f = new spriteFX(game, x, y, 0, 0, 9, game.SpritePool.explosion1, 128, .3);
				game.decalFX.Crater(x,y);
				game.fx.push(f);
				game.removeCoin(this);
			
		}
	}
	
}