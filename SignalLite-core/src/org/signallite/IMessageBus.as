package org.signallite
{
    import flash.events.IEventDispatcher;

    public interface IMessageBus
    {
        /**
         * Bind a signal to a <code>MessageType</code>.
         */
        function bindSignal(signal:ISignal, type:MessageType):void;
        /**
         * Unbind a signal to a <code>MessageType</code>.
         */
        function unbindSignal(signal:ISignal, type:MessageType):void;
        /**
         * Bind an event to a <code>MessageType</code>.
         * All listeners added to this type will be called when this eventDispatcher dispatches this eventType.
         */
        function bindEvent(eventDispatcher:IEventDispatcher, eventType:String, type:MessageType):void;
        /**
         * Unbind an event to a <code>MessageType</code>.
         */
        function unbindEvent(eventDispatcher:IEventDispatcher, eventType:String, type:MessageType):void;
        /**
         * Add listener to a MessageType.
         * This listener will be <code>MessageType</code> when any signal bound to this type dispatches.
         */
        function addListener(type:MessageType, listener:Function):Function;
        /**
         * Add listener to a <code>MessageType</code> only once..
         * This listener will be called when any signal bound to this type dispatches,
         * and the listener will be removed at the same time.
         */
        function addListenerOnce(type:MessageType, listener:Function):Function;
        /**
         * Remove a listener to s <code>MessageType</code>.
         */
        function removeListener(type:MessageType, listener:Function):Function;
        /**
         * Dispatch a <code>MessageType</code> directly.
         */
        function dispatch(type:MessageType, messageObject:* = null):void;
    }
}