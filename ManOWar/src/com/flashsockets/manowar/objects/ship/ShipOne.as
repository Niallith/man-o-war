package com.flashsockets.manowar.objects.ship
{
	import com.flashsockets.manowar.objects.ship.abstract.PlayerShip;
	
	import flash.display.MovieClip;

	public class ShipOne extends PlayerShip
	{
		public function ShipOne()
		{
			super();
			init();
		}
		private function init():void
		{
			setGraphics();
			setStats();
		}
		private function setGraphics():void
		{
			var shipOneDisplay:MovieClip = new BOAT_ONE () as MovieClip;
			addChild(shipOneDisplay);
		}
		private function setStats():void
		{
			setSpeed(80);
			setCurrentSpeed(80);
			setEquipageSpeed(500);
			setCurrentEquipageSpeed(500);
		}
	}
}