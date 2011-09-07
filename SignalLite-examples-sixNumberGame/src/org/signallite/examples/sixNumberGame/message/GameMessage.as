package org.signallite.examples.sixNumberGame.message
{
    import org.signallite.MessageType;
    import org.signallite.examples.sixNumberGame.signals.PlayResultSignal;
    public class GameMessage
    {
        public static const GAME_STARTED:MessageType = new MessageType();
        public static const GAME_ENDED:MessageType = new MessageType(PlayResultSignal);
    }
}