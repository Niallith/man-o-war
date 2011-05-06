package com.flashsockets.manowar.control
{
	import com.flashsockets.manowar.model.Model;
	import com.flashsockets.manowar.objects.map.FFAGameMap;
	import com.flashsockets.manowar.objects.map.abstract.BasicMap;
	import com.flashsockets.manowar.objects.ship.ShipOne;
	import com.flashsockets.manowar.objects.ship.abstract.BasicShip;
	import com.flashsockets.manowar.util.Calcul;
	import com.flashsockets.manowar.view.MainView;
	import com.flashsockets.manowar.view.abstract.BasicView;
	import com.flashsockets.manowar.view.game.FFAGameView;
	import com.flashsockets.manowar.view.ui.FirstScreenView;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import fl.controls.listClasses.ListData;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	import playerio.Client;
	import playerio.Connection;
	import playerio.Message;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;
	import playerio.RoomInfo;

	public class Controller
	{

		
		private var model:Model = Model.getInstance();
		
		public function Controller()
		{}
		
		//Singleton du controller
		private static var controller:Controller;
		public static function getInstance():Controller
		{
			if(controller == null)
				controller = new Controller();
			
			return controller;
		}
	
		/**
		 * Application chargée
		 * Set le state
		 * Set la MainView
		 * Set la View (FIRST_SCREEN) de la MainView
		 */
		public function applicationLoaded(app:ManOWar, mainView:MainView):void
		{
			//On set le stage (seté dans ManOWar.as)
			//model.setStage(app.stage);
			
			//On set la mainView
			model.setMainView(mainView);
				
			//On set la view
			model.setView(Model.VIEW_FIRST_SCREEN);	
		}
	
		/**
		 * VIEW UPDATED
		 * Animation Changement View -
		 * Remove la oldView si elle existe -
		 * Recupère la Class de la view -
		 * Change la view dans la MainView -
		 * Update la oldView
		 */ 
		//List des views
		com.flashsockets.manowar.view.ui.FirstScreenView;
		com.flashsockets.manowar.view.ui.LobbyView;
		com.flashsockets.manowar.view.ui.LoginView;
		com.flashsockets.manowar.view.game.FFAGameView;
		
		public function viewUpdated(e:Event):void
		{
			trace("CONTROLLER : viewUpdated");
			startAnimationTransition();
		}
		public function startAnimationTransition():void
		{
			
			//Fin animation de début
			setOldAndCurrentView();
		}
		public function setOldAndCurrentView():void
		{
			//Récupère la class de la view
			var ViewClass:Class = getDefinitionByName(model.getView()) as Class;
			//Ajoute la view dans la main view
			var newView:BasicView = new ViewClass();
			model.getMainView().addChild(newView);
			trace("MAINVIEW UPDATED :"+model.getView());
			
			//On supprime la oldView si elle n'est pas null
			if(model.getOldView() != null)
				model.getMainView().removeChild(model.getOldView());
			
			//On set la nouvelle oldView
			model.setOldView(newView);
			
			//Démarre la fin de la transition
			endAnimationTransition();
		}
		public function endAnimationTransition():void
		{
			trace("ANIMATION_TRANSITION_FIN");
		}

		/**
		 *USER INTERFACE FIRST_SCREEN_VIEW 
		 */
		/**
		 *BT_PLAY HANDLER
		 *Change la view sur login view
		 */ 
		public function uiFirstScreenViewBtPlayHandler(e:MouseEvent):void
		{
			trace("BT_Play clicked");
			model.setView(Model.VIEW_LOGIN);
		}
		
		/**
		 *USER INTERFACE LOGIN_VIEW 
		 */
		/**
		 *BT_GUEST HANDLER
		 *Se connect au serveur en Guest, handleConnect & handleError
		 *Puis change la view sur lobby
		 */ 
		public function uiLoginViewBtGuestHandler(e:MouseEvent):void
		{
			trace("BT_GUEST clicked");
			//On détermine un usernameGuest
			model.setUsername("Guest-"+Math.round(Math.random()*99999));
			//Update la state
			model.setStateViewLogin(Model.VIEW_LOGIN_STATE_CONNECTING);
			
			PlayerIO.connect(
				model.getStage(),					//Referance to stage
				"manowar-1wphsniuf0mnoyalg2b4a",	//Game id (Get your own at playerio.com)
				"public",							//Connection id, default is public
				model.getUsername(),				//Username
				"",									//User auth. Can be left blank if authentication is disabled on connection
				null,								//Current PartnerPay partner.
				handleConnect,						//Function executed on successful connect
				handleError							//Function executed if we recive an error
			);  
		}
		/**
		 *CONNECTION AU SERVEUR, SWITCH SUR SERVEUR DE DEVELLOPEMENT
		 */ 
		public function handleConnect(client:Client):void
		{
			//Set developmentsever (Comment out to connect to your server online)
			//client.multiplayer.developmentServer = "localhost:8184";
			
			//Set le client
			model.setClient(client);
			
			//Se connect au lobby
			connectLobby();
			
		}
		public function handleError(e:PlayerIOError):void
		{
			model.setStateViewLogin(Model.VIEW_LOGIN_STATE_LOGIN);
			trace("Got", e);
		}
		
		/**
		 * USER INTERFACE LOBBY_VIEW
		 */
		public function resetPlayerList():void
		{
			model.getPlayerList().removeAll();
		}
		public function addPlayerInPlayerList(playerID:String,username:String):void
		{
			var tilePlayer:MovieClip = new TilePlayerLobby () as MovieClip;
			tilePlayer.txt_username.autoSize =  TextFieldAutoSize.LEFT;
			tilePlayer.txt_username.text = username;
			tilePlayer.clip_medal.gotoAndStop("Newbie");
			tilePlayer.txt_title.text = "Newbie";
			model.getPlayerList().addItem({source:tilePlayer, id:playerID});
			
			trace("Ajout de tilePlayer dans le dataProvider : "+username);
		}
		public function removePlayerInPlayerList():void
		{
			
		}
		public function createGameRoom(e:MouseEvent):void
		{
			//Envoi un msg indiquant qu'on quitte la room
			model.getConnection().createMessage(Model.SERVER_MESSAGE_TYPE_PLAYER_EXIT,model.getConnection());
				
			//Quitte la room en cours
			model.getConnection().disconnect();
			
			//Create pr join the room FFAGAME
			model.getClient().multiplayer.createJoinRoom(
				"",                         //Room id. If set to null a random roomid is used
				"FFAGame",                         //The game type started on the server
				false,                          //Should the room be hidden from the lobby?
				{},                             //Room data. This data is returned to lobby list. Variabels can be modifed on the server
				{username:model.getUsername()},                             //User join data
				handleFFAGameJoin,                     //Function executed on successful joining of the room
				function(e:PlayerIOError):void{
					
					//If the lobby is full, join another lobby!
					if(e.type == PlayerIOError.RoomIsFull){
						//Join another lobby
					}else handleError(e); //Handle all other errors with the basic handler
				}
			);
		}
		public function handleFFAGameJoin(connection:Connection):void
		{
			//Set la connection
			model.setConnection(connection);
			//Update la view sur la gameFFA
			//Attention dans cet ordre
			model.setView(Model.VIEW_FFA_GAME);
			trace("JOINED FFA GAME");
			
		}
		/**
		 * SERVER GAME LOGIC
		 */ 
		public function connectLobby():void
		{
			
			//Create pr join the room lobby
			model.getClient().multiplayer.createJoinRoom(
				"Lobby",                        //Room id. If set to null a random roomid is used
				"Lobby",                        //The game type started on the server
				false,                          //Should the room be hidden from the lobby?
				{},                             //Room data. This data is returned to lobby list. Variabels can be modifed on the server
				{username:model.getUsername()}, //User join data
				handleLobbyJoin,                //Function executed on successful joining of the room
				function(e:PlayerIOError):void{
					
					//If the lobby is full, join another lobby!
					if(e.type == PlayerIOError.RoomIsFull){
						//Join another lobby
					}else handleError(e); //Handle all other errors with the basic handler
				}
			);
		}
		public function handleLobbyJoin(connection:Connection):void
		{
			//Set la connection
			model.setConnection(connection);
			
			//Update la view sur le lobby
			//Attention dans cet ordre car le lobby possède des écouteurs sur la connection
			model.setView(Model.VIEW_LOBBY);
			
		}
		//Envoi un message public à tous les joueurs de la room
		public function sendPublicMessage(message:String):Boolean
		{
			var flagEnvoi:Boolean = true;
			
			//Test Flood
			var currentDate:Number = new Date().getTime();
			var diffDate:Number = currentDate - model.getFlooderTime();
			trace("Current date - last flooderDate = "+diffDate);
			if(diffDate/1000 > Model.FLOOD_TIME_MAX)
			{
				//Envoi message
				trace("ENVOI PUBLIC MESSAGE : "+message);
				model.setFlooderTime(currentDate);
				var msg:Message = model.getConnection().createMessage(Model.SERVER_MESSAGE_TYPE_PUBLIC_MESSAGE, message);
				model.getConnection().sendMessage(msg);
			}else{
				flagEnvoi = false;
			}
			return flagEnvoi;
		}
		//Récupère la liste des joueurs de la room
		public function getPlayerList():void
		{
			var playerListRequest:Message = model.getConnection().createMessage(Model.SERVER_MESSAGE_TYPE_GET_PLAYER_LIST);
			model.getConnection().sendMessage(playerListRequest);
		}
		
		//Récupère la liste des games rooms
		public function getRoomList():void
		{
			trace("GETTING ROOM LIST");
			trace("TYPE DE ROOM RECHERCHE : "+Model.TYPE_GAME_FFA);
			model.getClient().multiplayer.listRooms(Model.TYPE_GAME_FFA, {}, 50, 0, function(rooms:Array):void{
					//Trace out returned rooms
				trace(rooms.length);
					for( var a:int=0;a<rooms.length;a++){
						trace(a);
					}
				}, function(e:PlayerIOError):void{
					trace("Unable to list rooms", e)
				})
		}

		/**
		 * GLOBAL GAME LOGIC
		 * 
		 */ 
		//Ajoute le carte
		public function createMap():void
		{
			//Créé la carte
			var map:BasicMap = new FFAGameMap();
			model.setMap(map);
		}
		public function startPingTimer(e:Event):void
		{
			var timer:Timer = new Timer(Model.DELAY_PING);
			timer.addEventListener(TimerEvent.TIMER,sendPingMessage);
			timer.start();
		}
		public function sendPingMessage(e:TimerEvent):void
		{
			var timestamp:String = new Date().getTime().toString();
			var msg:Message = model.getConnection().createMessage(Model.SERVER_MESSAGE_TYPE_PING,timestamp);
			model.getConnection().sendMessage(msg);
		}
		/**
		 * TODO DISPLAY SHIP SELECTION PANNEL
		 */ 
		public function createShipSelection():void
		{
			var playerShip:BasicShip = new ShipOne();
			model.setPlayerShip(playerShip);
		}
		public function onShipSelected(e:Event):void
		{
			//Envoi de l'annonce aux autres joueurs
			
			//Va ajouter notre bateau quand on recoit l'annonce en même tps que les autres joueurs
			trace("DISPLAY THE SHIP ON THE MAP");
			//Ajoute le bateau sur la couche sea
			model.getPlayerShip().x = 300;
			model.getPlayerShip().y = 300
			model.getMap().seaLayer.addChild(model.getPlayerShip());		
		}
		
		public function onSeaLayerClicked(e:MouseEvent):void
		{
			trace("SEA CLICKED, MOVING SHIP?");
			//Calcul du point d'ancre
			var angle:Number = 2*Math.PI*(model.getPlayerShip().rotation/360);
			var ax:Number = model.getPlayerShip().x + 150*Math.cos(angle);
			var ay:Number = model.getPlayerShip().y + 150*Math.sin(angle);
			var ancrePoint:Point = new Point(ax, ay);
			
			//Position du bateau
			var bateauPoint:Point = new Point(model.getPlayerShip().x, model.getPlayerShip().y);
			
			//Point d'arrivé du bateau
			var arrivePoint:Point = new Point(model.getMap().seaLayer.mouseX,model.getMap().seaLayer.mouseY);
			
			//Calcul de la longueur de la courbe
			var longueur:Number = Calcul.getLongueurCourbeBezier(bateauPoint.x,bateauPoint.y,ancrePoint.x,ancrePoint.y,arrivePoint.x,arrivePoint.y);
			
			//Récupération des stats du bateau
			var speed:Number = model.getPlayerShip().getCurrentSpeed();
			var equipageSpeed:Number = model.getPlayerShip().getCurrentEquipageSpeed();
			
			//Durée du trajet
			var duration:Number = longueur/speed;
			
			//Check si on donner l'ordre de bouger le bateau
			//On calcul la futur position du bateau
			var futurPosition:Point = Calcul.calculateFuturPosition(bateauPoint,ancrePoint,arrivePoint,model.getPlayerShip().getDateStartMovement(),
				model.getPlayerShip().getMovementDuration(),model.getPlayerShip().getEquipageSpeed());

			//Test si on peut cliquer
			if(Calcul.isTheShipMovementGood(futurPosition))
			{
				//Envoi les données à tous les joueurs
				TweenMax.to(model.getPlayerShip(), duration, {bezier:[{x:ax, y:ay}, {x:arrivePoint.x, y:arrivePoint.y}], orientToBezier:true, ease:Linear.easeNone}); 
			}else{
				
			}
			
			
		}
		
		public function moveShip():void
		{
			//Bouge le bateau de l'id du joueur
			
			
		}
	}
}