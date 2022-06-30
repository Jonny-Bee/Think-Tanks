package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class shotUp extends powerUp 
	{
		public function shotUp(gm:Game = null,lf:int = 100000)
		{
			
			if (gm != null)
			{
				game = gm;
			}
			else
			{
				game = Game(parent.parent);
				game.objects.push(this);
			}
			life = lf;
			gx = Math.floor(x / game.gridSize);
			gy = Math.floor(y / game.gridSize);
			
			
		}
		override public function collected(col:Boolean = true ):void
		{
			if (bCollectable)
			{
				bCollectable = false;
				visible = false;
				if (col == true)
				{
					game.gameData.playerShots += 1;
					game.player.setPowerUp();
					game.SoundManager.playShot("coin");
				}
				var f = new spriteFX(game, x, y - 5, 0, 0, 9, game.SpritePool.hit, 32);
				
				game.fx.push(f);
				game.removeCoin(this);
			}
		}
	}
	
}