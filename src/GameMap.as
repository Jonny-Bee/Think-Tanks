package 
{
	
	/**
	 * ...
	 * @author J Bartram
	 */
	public class GameMap
	{
		public var grid:Array;
		public var width:int;
		public var height:int;
		private const blank:int = 0;
		
		public function GameMap(wid:int, hgt:int)
		{
			width = wid;
			height = hgt;
			grid = new Array();
			{
				for (var i = 0; i < wid; i++)
				{
					grid[i] = new Array();
					for (var j = 0; j < hgt; j++)
					{
						grid[i].push(0);
					}
				}
			}
		}
		
		public function setGrid(xp, yp, val):void
		{
			if (xp >= 0 && xp < width)
			{
				if (yp >= 0 && yp < height)
				{
					grid[xp][yp] = val;
				}
			}
			
		}
		
		public function getGrid(xp, yp):int
		{
			if (xp >= 0 && xp < width)
			{
				if (yp >= 0 && yp < height)
				{
					return int(grid[xp][yp]);
				}
				else
				{
					return 1;
				}
			}
			else
			{
				return 1;
			}
			
		}
		private function getArray(xp, yp):int
		{
			if (xp >= 0 && xp < width)
			{
				if (yp >= 0 && yp < height)
				{
					return int(grid[xp][yp]);
				}
				else
				{
					return 1;
				}
			}
			else
			{
				return 1;
			}
			
		}
		public function findPath(tx, ty, fx, fy)
		{
			
			var tempPath = {};
			var newPath = [];
			tempPath.unchecked = [];
			tempPath.done = false;
			var cost = Math.abs(tx-fx)+Math.abs(ty-fy);
			tempPath.name = "cell_"+ty+"_"+tx;
			tempPath[tempPath.name] = {x:tx, y:ty, visited:true, px:null, py:null, cost:cost};
			tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
			
			
			
			while (tempPath.unchecked.length>0)
			{
				
				
				var N = tempPath.unchecked.shift();
				var tcost:Number = 0;
				
				if (N.x == fx && N.y == fy)
				{
					
					while (N.px != null)
					{
						newPath[newPath.length] = N.x;
						newPath[newPath.length] = N.y;
						N = tempPath["cell_"+N.py+"_"+N.px];

					}
					tempPath.done = true;
					break;
				}
				else
				{
					N.visited = true;
					var badded = false;
					
					if (getArray(N.x+1,N.y) == blank)
					{

						tcost = Math.abs(N.x+1-fx)+Math.abs(N.y-fy);

						tempPath.name = "cell_"+N.y+"_"+(N.x+1);

						if (tempPath[tempPath.name] == undefined)
						{
							tempPath[tempPath.name] = {x:N.x+1, y:N.y, visited:false, px:N.x, py:N.y, cost:tcost};
						
							if (badded == false)
							{
								tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
							}
						}
					}
					
					
					badded = false;
					
					if (getArray(N.x-1,N.y) == blank)
					{
						tcost = Math.abs(N.x-1-fx)+Math.abs(N.y-fy);

						tempPath.name = "cell_"+N.y+"_"+(N.x-1);
						if (tempPath[tempPath.name] == undefined)
						{
							tempPath[tempPath.name] = {x:N.x-1, y:N.y, visited:false, px:N.x, py:N.y, cost:tcost};
						
							if (badded == false)
							{
								tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
							}
						}
					}
					
					
					badded = false;
					
					if (getArray(N.x,N.y+1) == blank)
					{
						tcost = Math.abs(N.x-fx)+Math.abs(N.y+1-fy);

						tempPath.name = "cell_"+(N.y+1)+"_"+N.x;
						if (tempPath[tempPath.name] == undefined)
						{
							tempPath[tempPath.name] = {x:N.x, y:N.y+1, visited:false, px:N.x, py:N.y, cost:tcost};
						
							if (badded == false)
							{
								tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
							}
						}
					}
					
					badded = false;
					
					if (getArray(N.x,N.y-1) == blank)
					{
						tcost = Math.abs(N.x-fx)+Math.abs(N.y-1-fy);

						tempPath.name = "cell_"+(N.y-1)+"_"+N.x;
						if (tempPath[tempPath.name] == undefined)
						{
							tempPath[tempPath.name] = {x:N.x, y:N.y-1, visited:false, px:N.x, py:N.y, cost:tcost};
						
							if (badded == false)
							{
								tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
							}
						}
					}
					
					
				// diagonals
					badded = false;
					
					if (getArray(N.x+1,N.y+1) == blank && getArray(N.x,N.y+1) == blank && getArray(N.x+1,N.y) == blank)
					{

						tcost = Math.abs(N.x+1-fx)+Math.abs(N.y+1-fy);

						tempPath.name = "cell_"+(N.y+1)+"_"+(N.x+1);

						if (tempPath[tempPath.name] == undefined)
						{
							tempPath[tempPath.name] = {x:N.x+1, y:N.y+1, visited:false, px:N.x, py:N.y, cost:tcost};
						
							if (badded == false)
							{
								tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
							}
						}
					}
					
					badded = false;
					
					if (getArray(N.x-1,N.y-1) == blank && getArray(N.x,N.y-1) == blank && getArray(N.x-1,N.y) == blank)
					{
						tcost = Math.abs(N.x-1-fx)+Math.abs(N.y-1-fy);

						tempPath.name = "cell_"+(N.y-1)+"_"+(N.x-1);
						if (tempPath[tempPath.name] == undefined)
						{
							tempPath[tempPath.name] = {x:N.x-1, y:N.y-1, visited:false, px:N.x, py:N.y, cost:tcost};
						
							if (badded == false)
							{
								tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
							}
						}
					}
					
					badded = false;
					
					if (getArray(N.x-1,N.y+1) == blank && getArray(N.x,N.y+1) == blank && getArray(N.x-1,N.y) == blank)
					{
						tcost = Math.abs(N.x-1-fx)+Math.abs(N.y+1-fy);

						tempPath.name = "cell_"+(N.y+1)+"_"+(N.x-1);
						if (tempPath[tempPath.name] == undefined)
						{
							tempPath[tempPath.name] = {x:N.x-1, y:N.y+1, visited:false, px:N.x, py:N.y, cost:tcost};
						
							if (badded == false)
							{
								tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
							}
						}
					}
					
					badded = false;
					
					if (getArray(N.x+1,N.y-1) == blank && getArray(N.x,N.y-1) == blank && getArray(N.x+1,N.y) == blank)
					{
						tcost = Math.abs(N.x+1-fx)+Math.abs(N.y-1-fy);

						tempPath.name = "cell_"+(N.y-1)+"_"+(N.x+1);
						if (tempPath[tempPath.name] == undefined)
						{
							tempPath[tempPath.name] = {x:N.x+1, y:N.y-1, visited:false, px:N.x, py:N.y, cost:tcost};
						
							if (badded == false)
							{
								tempPath.unchecked[tempPath.unchecked.length] = tempPath[tempPath.name];
							}
						}
					}
					
					
				}
			}
			if (tempPath.done)
			{
				
				return newPath;
			}
			else
			{
				
				trace("impossible");
				return undefined;
			}
		}
		
	}
	
}