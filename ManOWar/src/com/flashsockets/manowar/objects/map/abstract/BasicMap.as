package com.flashsockets.manowar.objects.map.abstract
{
	import com.flashsockets.manowar.control.Controller;
	import com.flashsockets.manowar.model.Model;
	import com.flashsockets.manowar.view.ui.interfaces.IView;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;

	
	public class BasicMap extends MovieClip implements IView
	{
		//Map a la souris
		protected var mapBackground:MovieClip;
		protected var mouseXStart:Number;
		protected var mouseYStart:Number;
		protected var mapXStart:Number;
		protected var mapYStart:Number;
		protected var model:Model = Model.getInstance();
		protected var controller:Controller = Controller.getInstance();
		public var globalLayer:MovieClip = new MovieClip();
		public var seaLayer:MovieClip = new MovieClip();
		
		//Map au clavier
		
		public function BasicMap()
		{
			trace("CREATED BASIC MAP");
			setLayers();
			setEventListeners();
		}
		private function setLayers():void
		{
			addChild(globalLayer);
			globalLayer.addChild(seaLayer);

		}
		//Override
		public function displayerGraphics():void
		{}
		//Commun à toutes les maps
		public function setEventListeners():void
		{
			trace("layerSea ADDED EVENTLISTENER");
			model.getStage().addEventListener(KeyboardEvent.KEY_DOWN, onMapKeyDown);
			model.getStage().addEventListener(KeyboardEvent.KEY_UP, onMapKeyUp);
			model.addEventListener(Model.EVENT_MAP_CREATED, activateShipMovementDetection);
			
		}
		protected function activateShipMovementDetection(e:Event):void
		{
			model.getMap().seaLayer.addEventListener(MouseEvent.CLICK, controller.onSeaLayerClicked);
		}
		protected function onMapKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT)
				addEventListener(Event.ENTER_FRAME, moveMapLeft);
			if(e.keyCode == Keyboard.RIGHT)
				addEventListener(Event.ENTER_FRAME, moveMapRight);
				
			if(e.keyCode == Keyboard.DOWN)
				addEventListener(Event.ENTER_FRAME, moveMapDown);
			
			if(e.keyCode == Keyboard.UP)
				addEventListener(Event.ENTER_FRAME, moveMapUp);
		}
		protected function moveMapUp(e:Event):void
		{
			TweenLite.to(globalLayer,Model.MAP_SPEED_DEFILLEMENT,{x:globalLayer.x,y:globalLayer.y+Model.MAP_LONGUEUR_DEFILLEMENT});
		}
		protected function moveMapDown(e:Event):void
		{
			TweenLite.to(globalLayer,Model.MAP_SPEED_DEFILLEMENT,{x:globalLayer.x,y:globalLayer.y-Model.MAP_LONGUEUR_DEFILLEMENT});
		}
		protected function moveMapRight(e:Event):void
		{
			TweenLite.to(globalLayer,Model.MAP_SPEED_DEFILLEMENT,{x:globalLayer.x-Model.MAP_LONGUEUR_DEFILLEMENT,y:globalLayer.y});
		}
		protected function moveMapLeft(e:Event):void
		{
			TweenLite.to(globalLayer,Model.MAP_SPEED_DEFILLEMENT,{x:globalLayer.x+Model.MAP_LONGUEUR_DEFILLEMENT,y:globalLayer.y});
		}
		protected function onMapKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT)
				removeEventListener(Event.ENTER_FRAME, moveMapLeft);
			if(e.keyCode == Keyboard.RIGHT)
				removeEventListener(Event.ENTER_FRAME, moveMapRight);
			
			if(e.keyCode == Keyboard.DOWN)
				removeEventListener(Event.ENTER_FRAME, moveMapDown);
			
			if(e.keyCode == Keyboard.UP)
				removeEventListener(Event.ENTER_FRAME, moveMapUp);
		}
		/*protected function onMapMouseDown(e:MouseEvent):void
		{
			trace("MOUSE DOWN");
			//On set les mouseStart
			mapXStart = globalLayer.x;
			mapYStart = globalLayer.y;
			mouseXStart = globalLayer.mouseX;
			mouseYStart = globalLayer.mouseY;
			
			
			trace("x: "+mouseXStart+ " y : "+mouseYStart);
			//Ecouteur sur le mouvement de la souris pour bouger la map
			addEventListener(Event.ENTER_FRAME, onMapDrag);
		}*/
		/*protected function onMapDrag(e:Event):void
		{
			var newposX:Number = mapXStart+(globalLayer.mouseX-mouseXStart);
			var newposY:Number = mapYStart+(globalLayer.mouseY-mouseYStart);
			if(newposX >0) newposX = 0;
			if(newposY >0) newposY = 0;
			TweenLite.to(globalLayer,model.getMapScrollSpeed(),{x:newposX, y:newposY});
		}*/
		/*protected function onMapMouseUp(e:MouseEvent):void
		{
			trace("MOUSE UP");
			removeEventListener(Event.ENTER_FRAME, onMapDrag);
		}*/
		public function removedFromStage(e:Event):void
		{}
	}
}