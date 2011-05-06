package com.flashsockets.manowar.view.ui
{
	import com.flashsockets.manowar.control.Controller;
	import com.flashsockets.manowar.model.Model;
	import com.flashsockets.manowar.view.abstract.BasicView;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LoginView extends BasicView
	{
		public var uiLoginScreen:MovieClip;
		private var controller:Controller = Controller.getInstance();
		private var model:Model = Model.getInstance();
		public function LoginView()
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
			/*uiFirstScreen = new FIRST_SCREEN_VIEW() as MovieClip;
			addChild(uiFirstScreen);*/
			uiLoginScreen = new VIEW_LOGIN() as MovieClip;
			uiLoginScreen.gotoAndStop(Model.VIEW_LOGIN_STATE_LOGIN);
			addChild(uiLoginScreen);
			trace("LOGIN_VIEW GRAPHICS ADDED");
		}
		override public function setEventListeners():void
		{
			uiLoginScreen.bt_guest.addEventListener(MouseEvent.CLICK, controller.uiLoginViewBtGuestHandler);
			model.addEventListener(Model.EVENT_STATE_VIEW_LOGIN_UPDATED, stateUpdate);
		}
		private function stateUpdate(e:Event):void
		{
			trace("STATE UPDATE VIEW LOGIN : "+model.getStateViewLogin());
			uiLoginScreen.gotoAndStop(model.getStateViewLogin());
		}
		override public function removedFromStage(e:Event):void
		{
			uiLoginScreen.bt_guest.removeEventListener(MouseEvent.CLICK, controller.uiLoginViewBtGuestHandler);
			model.removeEventListener(Model.EVENT_STATE_VIEW_LOGIN_UPDATED, stateUpdate);
			trace("LOGIN_VIEW REMOVED FROM STAGE");
		}
	}
}