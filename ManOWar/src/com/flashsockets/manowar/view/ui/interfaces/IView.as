package com.flashsockets.manowar.view.ui.interfaces
{
	import flash.events.Event;

	public interface IView
	{
		function displayerGraphics():void;
		function setEventListeners():void;
		function removedFromStage(e:Event):void;
	}
}