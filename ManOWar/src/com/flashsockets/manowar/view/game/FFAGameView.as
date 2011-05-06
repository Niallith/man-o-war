package com.flashsockets.manowar.view.game
{
	import com.flashsockets.manowar.control.Controller;
	import com.flashsockets.manowar.model.Model;
	import com.flashsockets.manowar.objects.map.FFAGameMap;
	import com.flashsockets.manowar.objects.map.abstract.BasicMap;
	import com.flashsockets.manowar.objects.picker.abstract.BasicShipPicker;
	import com.flashsockets.manowar.view.game.abstract.MainGameView;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.BezierPlugin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class FFAGameView extends MainGameView
	{
		private var map:BasicMap;
		private var shipPicker:BasicShipPicker;
		private var controller:Controller = Controller.getInstance();
		private var model:Model = Model.getInstance();
		
		public function FFAGameView()
		{
			init();
		}
		protected function init():void
		{
			setListeners();
			setMap();
		}
		private function setListeners():void
		{
			model.addEventListener(Model.EVENT_MAP_CREATED, onMapCreated);
			model.addEventListener(Model.EVENT_SHIP_SELECTED, controller.onShipSelected);
		}
		override protected function setMap():void
		{
			controller.createMap();
		}
		protected function onMapCreated(e:Event):void
		{
			//Ajoute la map
			addChild(model.getMap());
			setSelection();
		}
		protected function setSelection():void
		{
			//Affiche le panneau de sélection
			controller.createShipSelection();
		}
		/*private function onShipSelected(e:Event):void
		{
			
			//Ecouteur sur click de la map quand le ship est ajouté à la carte
			//model.getMap().seaLayer.addEventListener(MouseEvent.CLICK, controller.onSeaLayerClicked);
		}*/
	}
}