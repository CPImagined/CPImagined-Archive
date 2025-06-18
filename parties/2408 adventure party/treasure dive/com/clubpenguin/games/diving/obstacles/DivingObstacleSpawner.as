package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.DivingObstacleTypes;
	import com.clubpenguin.games.diving.obstacles.DivingObstacle;
	import com.clubpenguin.games.diving.obstacles.FluffyDivingObstacle;
	import com.clubpenguin.games.diving.obstacles.SharkDivingObstacle;
	import com.clubpenguin.games.diving.obstacles.MulletDivingObstacle;
	import com.clubpenguin.games.diving.obstacles.CrabDivingObstacle;
	import com.clubpenguin.games.diving.obstacles.TreasureDivingObstacle;
	import com.clubpenguin.games.diving.obstacles.TreasureReturnDivingObstacle;
	import com.clubpenguin.games.diving.obstacles.TreasureCrabDivingObstacle;
	import com.clubpenguin.games.object.GameObject;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class DivingObstacleSpawner extends GameObject
	{
		private var __direction:int;
		
		private var __obstacles:Array;
		
		private var __spawnTimer:Timer;
		
		private var __obstacleType:uint;
		
		private var __initCooldown:Number;
		private var __cooldown:Number;
		
		private var __maxObstacles:uint;
		
		private var __continueSpawning:Boolean = true;
		
		public function DivingObstacleSpawner($obstacleType:uint, $maxObstacles:uint, $cooldown:Number, $direction:int, $initCooldown:Number)
		{
			super();
			
			if (!this._engine.isDebugMode())
			{
				// Players don't need to see these.
				this.visible = false;
			}
			
			this.__obstacleType = $obstacleType;
			
			this.__obstacles = new Array();
			
			this.__direction = $direction;
			
			// initCooldown is for the first spawn only.
			this.__initCooldown = $initCooldown;
			this.__cooldown = $cooldown;
			
			this.__maxObstacles = $maxObstacles;
			
			this.__spawnTimer = new Timer(this.__initCooldown, 1);
			this.resetTimer();
		}
		
		public function reset():void
		{
			this.__spawnTimer.removeEventListener(TimerEvent.TIMER, this.doSpawn);
			this.__spawnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.doInitSpawn);
			
			this.__spawnTimer.reset();
			
			// Change this back if it was false.
			this.__continueSpawning = true;
			
			this.resetTimer(true);
		}
		
		private function resetTimer(reinit:Boolean=false):void
		{
			if (reinit)
			{
				this.__spawnTimer.delay = this.__initCooldown;
				this.__spawnTimer.repeatCount = 1;
			}
			
			this.__spawnTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.doInitSpawn);
		}
		
		public function startTimer():void
		{
			if (!this.__spawnTimer.running)
			{
				this.__spawnTimer.start();
			}
		}
		
		public function get obstacleType():uint
		{
			return this.__obstacleType;
		}
		
		public function get obstacles():Array
		{
			return this.__obstacles;
		}
		
		public function set direction(dir:int):void
		{
			this.__direction = dir;
			
			for each (var obstacle in this.__obstacles)
			{
				if (obstacle.hasOwnProperty("direction"))
				{
					obstacle.direction = this.__direction;
				}
			}
		}
		
		public function set continueSpawning($continueSpawning:Boolean):void
		{
			this.__continueSpawning = $continueSpawning;
			
			if (this.__continueSpawning)
			{
				this.__spawnTimer.start();
			}
			else
			{
				this.__spawnTimer.reset();
			}
		}
		
		override public function getUniqueName():String
		{
			return "DivingObstacleSpawner";
		}
		
		public function addObstacle(obstacleType:uint=10000, force:Boolean=false):DivingObstacle
		{
			if (force || (this.__obstacles.length < this.__maxObstacles && this.__continueSpawning))
			{
				var obstacle;
				
				// Just some arbitrarily high number we'll never use
				if (obstacleType == 10000)
				{
					obstacleType = this.__obstacleType;
				}
			
				switch (obstacleType)
				{
					case DivingObstacleTypes.DIVING_OBSTACLE_FLUFFY:
						obstacle = new FluffyDivingObstacle(this);
						
						obstacle.direction = this.__direction;
						break;
						
					case DivingObstacleTypes.DIVING_OBSTACLE_SHARK:
						obstacle = new SharkDivingObstacle(this);
						
						obstacle.direction = this.__direction;
						break;
						
					case DivingObstacleTypes.DIVING_OBSTACLE_MULLET:
						obstacle = new MulletDivingObstacle(this);
						
						obstacle.direction = this.__direction;
						break;
						
					case DivingObstacleTypes.DIVING_OBSTACLE_CRAB:
						obstacle = new CrabDivingObstacle(this);
						
						obstacle.direction = this.__direction;
						break;
					
					/*
					These are not something the player wants to avoid, but
					this system serves the needs of what we want these to do.
					*/
					case DivingObstacleTypes.DIVING_OBSTACLE_TREASURE:
						obstacle = new TreasureDivingObstacle(this);
						break;
						
					case DivingObstacleTypes.DIVING_OBSTACLE_RETURN:
						obstacle = new TreasureReturnDivingObstacle(this);
						break;
					
					case DivingObstacleTypes.DIVING_OBSTACLE_TREASURE_CRAB:
						obstacle = new TreasureCrabDivingObstacle(this);
						
						obstacle.direction = this.__direction;
						break;
					
					default:
						throw "Unknown obstacle! type: " + obstacleType;
				}
				
				this.__obstacles.push(obstacle);
				
				obstacle.x = this.x;
				obstacle.y = this.y;
				
				this.parent.addChild(obstacle);
				
				obstacle.postInit();
			}
			
			return obstacle;
		}
		
		public function removeObstacles(destroy:Boolean=false):void
		{
			for each (var obstacle in this.__obstacles)
			{
				this.parent.removeChild(obstacle);
				obstacle.dispose();
			}
			
			if (destroy)
			{
				this.__obstacles = null;
			}
			else
			{
				this.__obstacles = new Array();
			}
		}
		
		public function removeObstacle(obstacle:DivingObstacle):void
		{
			var index = this.__obstacles.indexOf(obstacle);
			if (index != -1)
			{
				this.parent.removeChild(obstacle);
				
				this.__obstacles.splice(index, 1);
			}
		}
		
		private function doInitSpawn(evt:TimerEvent):void
		{
			this.addObstacle();
			
			// Initial spawn done; setup the timer for future spawns.
			this.__spawnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.doInitSpawn);
			this.__spawnTimer.reset();
			
			this.__spawnTimer.delay = this.__cooldown;
			// Repeat infinitely so fish can come and go when scared off by a puffle.
			this.__spawnTimer.repeatCount = 0;
			
			this.__spawnTimer.addEventListener(TimerEvent.TIMER, this.doSpawn);
			this.__spawnTimer.start();
		}
		
		private function doSpawn(evt:TimerEvent):void
		{
			this.addObstacle();
		}
		
		override public function update():void
		{
			for each (var obstacle in this.__obstacles)
			{
				obstacle.update();
			}
		}
		
		override public function dispose():void
		{
			this.__spawnTimer.removeEventListener(TimerEvent.TIMER, this.doSpawn);
			this.__spawnTimer.stop();
			this.__spawnTimer = null;
			
			// Cleanup all our obstacles.
			this.removeObstacles(true);
			this.__obstacles = null;
			
			super.dispose();
		}
	}
}