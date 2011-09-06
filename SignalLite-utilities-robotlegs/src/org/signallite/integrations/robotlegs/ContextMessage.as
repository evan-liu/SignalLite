package org.signallite.integrations.robotlegs
{
    import org.signallite.MessageType;
    public class ContextMessage
    {
        public static const STARTUP:MessageType = new MessageType();
        public static const STARTUP_COMPLETE:MessageType = new MessageType();

        public static const SHUTDOWN:MessageType = new MessageType();
        public static const SHUTDOWN_COMPLETE:MessageType = new MessageType();
    }
}