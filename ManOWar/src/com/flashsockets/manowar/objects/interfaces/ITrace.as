package com.flashsockets.manowar.objects.interfaces
{
	import flash.geom.Point;

	public interface ITrace
	{
		function setTopLine(pointA:Point, pointB:Point):void;
		function getTopLine():Array;
		function setLeftLine(pointA:Point, pointD:Point):void;
		function getLeftLine():Array;
		function setRightLine(pointB:Point, pointC:Point):void;
		function getRightLine():Array;
		function setBottomLine(pointC:Point, pointD:Point):void;
		function getBottomLine():Array;
		
	}
}