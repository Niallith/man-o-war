package com.flashsockets.manowar.model
{
	import com.flashsockets.manowar.objects.map.abstract.BasicMap;
	import com.flashsockets.manowar.objects.ship.abstract.BasicShip;
	import com.flashsockets.manowar.view.MainView;
	import com.flashsockets.manowar.view.abstract.BasicView;
	
	import fl.data.DataProvider;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import playerio.Client;
	import playerio.Connection;
	
	public class Model extends EventDispatcher
	{
		//List des variables gloabl
		public static var MAP_SPEED_DEFILLEMENT:Number = 0.3;
		public static var MAP_LONGUEUR_DEFILLEMENT:Number = 75;
		//List des types message recu par le serveur
		public static var SERVER_MESSAGE_TYPE_PUBLIC_MESSAGE:String = "m";
		public static var SERVER_MESSAGE_TYPE_GET_PLAYER_LIST:String = "pl";
		public static var SERVER_MESSAGE_TYPE_PING:String = "pg";
		public static var SERVER_MESSAGE_TYPE_PLAYER_EXIT:String = "pe";
		
		//List des events
		//Views
		public static var EVENT_VIEW_UPDATED:String = "VIEW_UPDATED";
		public static var EVENT_OLDVIEW_UPDATED:String = "OLD_VIEW_UPDATED";
		public static var EVENT_STATE_VIEW_LOGIN_UPDATED:String = "STATE_VIEW_LOGIN_UPDATED";
	
		//PlayerIO 
		//Connection
		public static var EVENT_PLAYERIO_CONNECTION_CREATED:String = "PLAYERIO_CONNEXION_CREATED";
		
		//Ping delay
		public static var DELAY_PING:Number = 5000;
		
		//Map
		public static var EVENT_MAP_CREATED:String = "MAP_CREATED";
		//Ship
		//Ship selected
		public static var EVENT_SHIP_SELECTED:String = "SHIP_SELECTED";
		
		//List des avertissements
		public static var AVERTISSEMENT_FLOOD_BASIC:String = "FLOOD IS NOT ALLOWED";
		
		//list des types de game
		public static var TYPE_GAME_FFA:String = "FFAGame";
		
		//Singleton du model
		private static var model:Model;
		public static function getInstance():Model
		{
			if(model == null)
				model = new Model();
			
			return model;
		}
		//Stage
		private var stage:Stage;
		public function setStage(stage:Stage):void
		{
			this.stage = stage;
		}
		public function getStage():Stage
		{
			return this.stage;
		}
		
		//VIEWS DE LA MAIN VIEW
		public static const VIEW_FIRST_SCREEN:String = "com.flashsockets.manowar.view.ui.FirstScreenView";
		public static const VIEW_LOGIN:String = "com.flashsockets.manowar.view.ui.LoginView";
		public static const VIEW_FFA_GAME:String = "com.flashsockets.manowar.view.game.FFAGameView";
			//STATE DU LOGIN
			public static const VIEW_LOGIN_STATE_LOGIN:String = "login";
			public static const VIEW_LOGIN_STATE_CONNECTING:String = "connecting";
		public static const VIEW_LOBBY:String = "com.flashsockets.manowar.view.ui.LobbyView";

		//Main View
		private var mainView:MainView;
		public function getMainView():MainView
		{
			return this.mainView;
		}
		public function setMainView(mainView:MainView):void
		{
			this.mainView = mainView;
		}
		
		//View
		private var view:String;
		private var oldView:BasicView;
		public function getView():String
		{
			return this.view;
		}
		public function setView(view:String):void
		{
			this.view = view;
			trace("dispatchEvent : EVENT_VIEW_UPDATED");
			dispatchEvent(new Event(Model.EVENT_VIEW_UPDATED));
		}
		public function getOldView():BasicView
		{
			return this.oldView;
		}
		public function setOldView(oldView:BasicView):void
		{
			this.oldView = oldView;
		}
		
		//State des views
		//Login state
		private var stateViewLogin:String;
		public function setStateViewLogin(state:String):void
		{
			trace("MODEL : Setting state viewLogin");
			this.stateViewLogin = state;
			dispatchEvent(new Event(EVENT_STATE_VIEW_LOGIN_UPDATED));
		}
		public function getStateViewLogin():String
		{
			return stateViewLogin;
		}
		
		//PlayerIO Client
		private var client:Client;
		public function getClient():playerio.Client
		{
			return this.client
		}
		public function setClient(client:playerio.Client):void
		{
			this.client = client;
		}
	
		//PlayerIO Connection
		private var connection:Connection;
		public function getConnection():Connection
		{
			return connection;
		}
		public function setConnection(connection:Connection):void
		{
			this.connection = connection;
			dispatchEvent(new Event(Model.EVENT_PLAYERIO_CONNECTION_CREATED));
		}
	
		//Player stats
		private var username:String;
		public function setUsername(username:String):void
		{
			this.username = username;
		}
		public function getUsername():String
		{
			return username;
		}
	
		private var flooderTime:Number = new Date().getTime();
		public static const FLOOD_TIME_MAX:Number = 1;
		public function setFlooderTime(date:Number):void
		{
			this.flooderTime = date;
		}
		
		public function getFlooderTime():Number
		{
			return flooderTime;
		}
		
		

		
		//Lobby game logic
		private var lastChatSpeaker:String;
		public function setLastChatSpeaker(speaker:String):void
		{
			this.lastChatSpeaker = speaker;
		}
		public function getLastChatSpeaker():String
		{
			return lastChatSpeaker;
		}
		
		private var playerList:DataProvider = new DataProvider();
		public function setPlayerList(playerList:DataProvider):void
		{
			this.playerList = playerList;
		}
		public function getPlayerList():DataProvider
		{
			return playerList;
		}
		//GLOBAL GAME LOGIC
		private var map:BasicMap;
		public function setMap(map:BasicMap):void
		{
			this.map = map;
			dispatchEvent(new Event(Model.EVENT_MAP_CREATED));
		}
		public function getMap():BasicMap
		{
			return map;
		}
		
		private var playerShip:BasicShip;
		public function setPlayerShip(playerShip:BasicShip):void
		{
			this.playerShip = playerShip;
			dispatchEvent(new Event(Model.EVENT_SHIP_SELECTED));
		}
		public function getPlayerShip():BasicShip
		{
			return playerShip;
		}
		
		//FFA Game Logic
		private var mapScrollSpeed:Number = 0.5;
		public function setMapScrollSpeed(speed:Number):void
		{
			this.mapScrollSpeed = speed;
		}
		public function getMapScrollSpeed():Number
		{
			return this.mapScrollSpeed;
		}

		private var mapDefillementSpeed:Number = 10;
		public function setMapDefillementSpeed(speed:Number):void
		{
			this.mapDefillementSpeed = speed;
		}
		public function getMapDefillementSpeed():Number
		{
			return this.mapDefillementSpeed
		}
	
	}
}