package com.flashsockets.manowar.objects.map
{
	import com.flashsockets.manowar.control.Controller;
	import com.flashsockets.manowar.objects.map.abstract.BasicMap;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class FFAGameMap extends BasicMap
	{
		
		public function FFAGameMap()
		{
			super();
			init();
		}
		private function init():void
		{
			displayerGraphics();
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		override public function displayerGraphics():void
		{
			mapBackground = new MAP_BACKGROUND_BLUE () as MovieClip;
			seaLayer.addChild(mapBackground);
		}
		
		override public function removedFromStage(e:Event):void
		{}
	}
}