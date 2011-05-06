using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PlayerIO.GameLibrary;

namespace MyGame.FFAGameRoom
{
    public class Player : BasePlayer
    {
        public String username;
        public long ping;
    }

    [RoomType("FFAGame")]
    public class GameCode : Game<Player>
    {
        //This method is called when a room is created
        public override void GameStarted()
        {
            //Perform actions to initialize room here
            Console.WriteLine("FFA GAME STARTED");
        }

        //This method is called when the last player leaves the room.
        public override void GameClosed()
        {
            //Do any clean-up here such as saving statistics
        }

        // This method is called whenever a player joins the room
        public override void UserJoined(Player player)
        {
            //Notify other players that someone joined,
            //or inform the new player of the game state
            /* player.X = player.JoinData["x"];
             player.Y = player.JoinData["y"];
             player.username = player.JoinData["username"];
             player.ship = player.JoinData["ship"];
             Broadcast("newPlayer",player.X,player.Y, player.username, player.Id, player.ship);*/


        }

        // This method is called when a player leaves the room
        public override void UserLeft(Player player)
        {
            //Notify other players the someone left
            Console.WriteLine(player.JoinData);

        }

        //This method is called before a user joins a room.
        //If you return false, the user is not allowed to join.
        public override bool AllowUserJoin(Player player)
        {
            return true;
        }

        //This method is called whenever a player sends a message to the room
        /**
         * m : public message (lobby, game ect...)
         */
        public override void GotMessage(Player player, Message message)
        {
            //Handle all different message types here
            //This room broadcasts all incoming messages
            //to all connected players:
            /**
             * m : public message
             * pl : playerList of the room
             */
            Console.WriteLine("Message received, type : " + message.Type);
            switch (message.Type)
            {
                case "pg":
                    {
                        Console.WriteLine("MESSAGE DE TYPE PG");
                        player.ping = long.Parse(getTime()) - long.Parse(message.GetString(0));
                        Console.WriteLine("Ping du joueur : " + player.ping);
                        break;
                    }
            }
        }
        private string getTime()
        {
            return Math.Round((DateTime.Now - new DateTime(1970, 1, 1)).TotalMilliseconds).ToString();
        }
    }
}
