package com.flashsockets.manowar.view.ui
{
	import com.flashsockets.manowar.control.Controller;
	import com.flashsockets.manowar.model.Model;
	import com.flashsockets.manowar.view.abstract.BasicView;
	
	import fl.controls.ScrollBarDirection;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import playerio.Message;
	
	public class LobbyView extends BasicView
	{
		private var uiLobbyScreen:MovieClip;
		private var tilePlayer:MovieClip;
		private var model:Model = Model.getInstance();
		private var controller:Controller = Controller.getInstance();
		
		public function LobbyView()
		{
			init();
		}
		private function init():void
		{
			displayerGraphics();
			setEventListeners();
			setupLobby();
		}
		override public function displayerGraphics():void
		{

			uiLobbyScreen = new VIEW_LOBBY() as MovieClip;
			addChild(uiLobbyScreen);
			trace("LOBBY_VIEW GRAPHICS ADDED");
		}
		override public function setEventListeners():void
		{
			//Ecouteur sur message public reçu
			model.getConnection().addMessageHandler(Model.SERVER_MESSAGE_TYPE_PUBLIC_MESSAGE, publicMessageHandler);
			model.getConnection().addMessageHandler(Model.SERVER_MESSAGE_TYPE_GET_PLAYER_LIST, publicMessageHandler);
			uiLobbyScreen.bt_enter.addEventListener(MouseEvent.CLICK, enterMessageClickHandler);
			addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			uiLobbyScreen.bt_create.addEventListener(MouseEvent.CLICK, controller.createGameRoom);
		}
		
		private function setupLobby():void
		{
			//Initialisation de la playerTileList
			uiLobbyScreen.playerList.addItem(tilePlayer);
			uiLobbyScreen.playerList.direction = ScrollBarDirection.VERTICAL;
			uiLobbyScreen.playerList.rowCount = 5;
			uiLobbyScreen.playerList.columnCount = 0;
			uiLobbyScreen.playerList.rowHeight = 37.05;
			uiLobbyScreen.playerList.columnWidth = 220.05;
			uiLobbyScreen.playerList.width = 226.90;
			uiLobbyScreen.playerList.height = 296.75;
			
			//Reset le dataProvider
			controller.resetPlayerList();
			
			//Set le dataProvider sur la listPlayerTile
			uiLobbyScreen.playerList.dataProvider = model.getPlayerList();
			
			//Demande la liste des joueurs au serveur
			controller.getPlayerList();
			
			//Demade la liste des rooms au serveur
			controller.getRoomList();
		}
		/**
		 *Handle server message
		 * type : m Public message
		 * 0 : username du sender
		 * 1 : message du sender
		 * 
		 * type : pl PlayerList
		 * 0 : playerID
		 * 1 : playerUsername
		 * 
		 * type pe : Player Exit
		 * Le joueur quitte la room en cours (lobby)
		 * 0 : playerID
		 */
		private function publicMessageHandler(message:Message):void
		{
			trace("RECEIVED A MESSAGE DE TYPE :"+message.type);
			var username:String;
			var playerID:String;
			var msgReceived:String;
			switch(message.type)
			{
				case Model.SERVER_MESSAGE_TYPE_PUBLIC_MESSAGE:
					username = message.getString(0);
					msgReceived = message.getString(1);
					
					if(model.getLastChatSpeaker() != null)
					{
						//Ecrit à la suite (type msn)
						if(model.getLastChatSpeaker() == username)
						{
							uiLobbyScreen.txt_chat.htmlText += msgReceived;
						}else{
							model.setLastChatSpeaker(username);
							uiLobbyScreen.txt_chat.htmlText += "<b>"+username+" says : </b>"+msgReceived;
						}
					}else{
						model.setLastChatSpeaker(username);
						uiLobbyScreen.txt_chat.htmlText += "<b>"+message.getString(0)+" says : </b>"+msgReceived;
					}
					//Keep the scroll at the bottom
					uiLobbyScreen.txt_chat.verticalScrollPosition = uiLobbyScreen.txt_chat.maxVerticalScrollPosition;
				break;
				
				case Model.SERVER_MESSAGE_TYPE_GET_PLAYER_LIST:
					playerID = message.getString(0);
					username = message.getString(1);
					//Ajout du player dans la liste
					controller.addPlayerInPlayerList(playerID,username);
					
					trace("UN PLAYER DE LA LISTE RECU : "+message.getString(0));
				break;
			}
		}

		
		
		
		/**
		 * Handle envoi message
		 */ 
		private function enterMessageClickHandler(e:MouseEvent):void
		{
			sendMessage();
		}
		private function keyboardHandler(e:KeyboardEvent):void
		{
			if(e.keyCode  == Keyboard.ENTER)
				sendMessage();
		}
		private function sendMessage():void
		{
			//Texte à envoyer :
			var message:String = uiLobbyScreen.txt_inputChat.text;
			//Filtre le message ( remove < et > )
			message = message.replace("<","");
			message = message.replace(">", "");
			
			//On envoi pas le message si il n'est pas vide
			var flagEnvoi:Boolean = true;
			if(message.length > 0 && message != null)
			{
				trace("ENVOI MESSAGE AU CONTROLLEUR : "+message);
				flagEnvoi = controller.sendPublicMessage(message);
			}
			//On test si le msg a été envoyé sinon annonce flood
			if(!flagEnvoi)
			{
				uiLobbyScreen.txt_chat.htmlText += "<b> Admin says : </b>"+Model.AVERTISSEMENT_FLOOD_BASIC;
				//Keep the scroll at the bottom
				uiLobbyScreen.txt_chat.verticalScrollPosition = uiLobbyScreen.txt_chat.maxVerticalScrollPosition;	
			}
			
			//On reset le message
			uiLobbyScreen.txt_inputChat.text = "";
		}
		override public function removedFromStage(e:Event):void
		{
			trace("LOBBY_VIEW REMOVED FROM STAGE");
		}
	}
}