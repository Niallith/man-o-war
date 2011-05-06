package com.flashsockets.manowar.objects.ship.abstract
{
	import flash.display.MovieClip;
	
	public class BasicShip extends MovieClip
	{
		protected var isVisible:Boolean;
		protected var life:int;
		protected var currentLife:int;
		protected var armor:int;
		protected var currentArmor:int;
		protected var positionX:int;
		protected var positionY:int;
		protected var anchorX:int;
		protected var anchorY:int;
		protected var destinationX:int;
		protected var destinationY:int;
		protected var startX:int;
		protected var startY:int;
		protected var duration:int;
		protected var speed:int;
		protected var currentSpeed:int;
		protected var equipageSpeed:int;
		protected var currentEquipageSpeed:int;
		protected var dateStartMovement:Date = new Date();
		protected var movementDuration:Number = 0;
		
		public function BasicShip()
		{
			super();
		}
		public function curveTo(startX:int, startY:int, anchorX:int, anchorY:int, destinationX:int, destinationY:int, duration:int):void
		{
			
		}
		public function moveTo(startX:int, startY:int, destinationX:int, destinationY:int, duration:int):void
		{
			
		}
		public function useSkill():void
		{
			
		}
		public function getSpeed():int
		{
			return speed;
		}
		public function setSpeed(speed:int):void
		{
			this.speed = speed;
		}
		public function getEquipageSpeed():int
		{
			return equipageSpeed;
		}
		public function setEquipageSpeed(equipageSpeed:int):void
		{
			this.equipageSpeed = equipageSpeed;
		}
		public function getCurrentSpeed():int
		{
			return currentSpeed;
		}
		public function setCurrentSpeed(currentSpeed:int):void
		{
			this.currentSpeed = currentSpeed;
		}
		public function getCurrentEquipageSpeed():int
		{
			return currentEquipageSpeed;
		}
		public function setCurrentEquipageSpeed(currentEquipageSpeed:int):void
		{
			this.currentEquipageSpeed = currentEquipageSpeed;
		}
		public function getMovementDuration():Number
		{
			return movementDuration;
		}
		public function setMovementDuration(movementDuration:Number):void
		{
			this.movementDuration = movementDuration;
		}
		public function setDateStartMovement(date:Date):void
		{
			this.dateStartMovement = date;
		}
		public function getDateStartMovement():Date
		{
			return dateStartMovement;
		}
	}
}