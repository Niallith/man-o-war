package com.flashsockets.manowar.objects.decor.abstract
{
	import com.flashsockets.manowar.objects.interfaces.ITrace;
	import com.flashsockets.manowar.view.ui.interfaces.IView;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class BasicBlock extends MovieClip implements IView, ITrace
	{
		protected var positionX:int;
		protected var positionY:int;
		
		public function BasicBlock()
		{
			super();
		}
		
		public function displayerGraphics():void
		{
		}
		
		public function setEventListeners():void
		{
		}
		
		public function removedFromStage(e:Event):void
		{
		}
		
		public function setTopLine(pointA:Point, pointB:Point):void
		{
		}
		
		public function getTopLine():Array
		{
			return null;
		}
		
		public function setLeftLine(pointA:Point, pointD:Point):void
		{
		}
		
		public function getLeftLine():Array
		{
			return null;
		}
		
		public function setRightLine(pointB:Point, pointC:Point):void
		{
		}
		
		public function getRightLine():Array
		{
			return null;
		}
		
		public function setBottomLine(pointC:Point, pointD:Point):void
		{
		}
		
		public function getBottomLine():Array
		{
			return null;
		}
	}
}