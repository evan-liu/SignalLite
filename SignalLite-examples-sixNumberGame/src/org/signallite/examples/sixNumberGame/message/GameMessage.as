package org.signallite.examples.sixNumberGame.message
{
    import org.signallite.MessageType;
    public class GameMessage
    {
        public static const ROUND_STARTED:MessageType = new MessageType();
        public static const ROUND_ENDED:MessageType = new MessageType();
        public static const GAME_STARTED:MessageType = new MessageType();
        public static const GAME_ENDED:MessageType = new MessageType();
    }
}