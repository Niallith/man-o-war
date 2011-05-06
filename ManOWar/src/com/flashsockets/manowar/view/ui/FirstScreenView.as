package com.flashsockets.manowar.view.ui
{
	import com.flashsockets.manowar.control.Controller;
	import com.flashsockets.manowar.view.abstract.BasicView;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FirstScreenView extends BasicView
	{
		private var uiFirstScreen:MovieClip;
		private var controller:Controller = Controller.getInstance();
		public function FirstScreenView()
		{
			init();
		}
		private function init():void
		{
			displayerGraphics();
			setEventListeners();
		}
		override public function displayerGraphics():void
		{
			uiFirstScreen = new FIRST_SCREEN_VIEW() as MovieClip;
			addChild(uiFirstScreen);
			trace("FIRST_SCREEN_VIEW GRAPHICS ADDED");
		}
		override public function setEventListeners():void
		{
			uiFirstScreen.bt_play.addEventListener(MouseEvent.CLICK, controller.uiFirstScreenViewBtPlayHandler);
		}
		override public function removedFromStage(e:Event):void
		{
			trace("FIRST_SCREEN_VIEW REMOVED FROM STAGE");
		}
	}
}