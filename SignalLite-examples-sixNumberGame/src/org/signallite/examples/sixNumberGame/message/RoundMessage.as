package org.signallite.examples.sixNumberGame.message
{
    import org.signallite.MessageType;
    import org.signallite.examples.sixNumberGame.events.PlayerActEvent;
    import org.signallite.examples.sixNumberGame.signals.PlayActSignal;
    import org.signallite.examples.sixNumberGame.signals.PlayResultSignal;
    public class RoundMessage
    {
        public static const ROUND_STARTED:MessageType = new MessageType();

        public static const PLAYER_ACT:MessageType = new MessageType(PlayerActEvent);

        public static const CENTER_ROUND_READY:MessageType = new MessageType(PlayActSignal);
        public static const PLAYER_ROUND_READY:MessageType = new MessageType(PlayActSignal);
        public static const COMPETITOR_ROUND_READY:MessageType = new MessageType(PlayActSignal);

        public static const ROUND_ENDED:MessageType = new MessageType(PlayResultSignal);
    }
}