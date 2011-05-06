package com.flashsockets.manowar.view
{
	import com.flashsockets.manowar.control.Controller;
	import com.flashsockets.manowar.model.Model;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class MainView extends MovieClip
	{
		private var model:Model = Model.getInstance();
		private var controller:Controller = Controller.getInstance();
		private var application:ManOWar;
		public function MainView(application:ManOWar)
		{
			this.application = application;
			init();
		}
		private function init():void
		{
			//Ecouteur sur le changement de view, met à jour la vue
			model.addEventListener(Model.EVENT_VIEW_UPDATED, controller.viewUpdated);
			trace("ECOUTEUR_MAIN_VIEW : EVENT_VIEW_UPDATED");
			//Le controller va updater la view sur FirstScreen
			controller.applicationLoaded(application, this);
			
			model.addEventListener(Model.EVENT_PLAYERIO_CONNECTION_CREATED, controller.startPingTimer);
		}	
	}
}