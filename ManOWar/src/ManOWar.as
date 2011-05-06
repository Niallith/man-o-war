package
{
	import com.flashsockets.manowar.control.Controller;
	import com.flashsockets.manowar.model.Model;
	import com.flashsockets.manowar.view.MainView;
	import com.flashsockets.manowar.view.abstract.BasicView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	[ SWF ( width = '640', height = '480', backgroundColor = '#5DBCFF', frameRate = '100'  ) ]
	//[ Frame ( factoryClass = "com.flashsockets.manowar.objects.preloader.Preloader" ) ]
	
	public class ManOWar extends Sprite
	{
		private var model:Model = Model.getInstance();
		private var controller:Controller = Controller.getInstance();
		
		public function ManOWar()
		{
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		/**
		 * Ajoute la MainView qui ecoute le changement de view de l'application
		 * applicationLoaded du controller prend en argument l'app (pour le stage) et la mainView
		 * le controller va update la view sur FirstScreen
		 */
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//On définit le stage
			model.setStage(stage);
			//On ajoute la mainView qui écoute le changement de State de l'application
			var mainView:MainView = new MainView(this);
			addChild(mainView);
			trace("MAIN_VIEW ADDED TO STAGE");
			
		}
	}
}