package org.signallite.integrations.robotlegs
{
    import org.signallite.IMessageBus;

    public interface ISignalContext
    {
        function get messageBus():IMessageBus;
    }
}