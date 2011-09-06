package org.signallite
{
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;

    /**
     * You can bind signal to MessageType in SignalBus ,
     * and listener to the type from the SignalBus instead of the signal itself.
     */
    public class MessageBus implements IMessageBus
    {
        //======================================================================
        // Variables
        //======================================================================
        private var listenerListByTypeMap:Dictionary = new Dictionary();
        private var onceListenerByTypeMap:Dictionary = new Dictionary();
        private var typeListBySignalMap:Dictionary = new Dictionary();
        private var typeListOfEventTypByDispatcherList:Dictionary = new Dictionary();
        //======================================================================
        // Public methods
        //======================================================================
        /**
         * Bind a signal to a MessageType for.
         * All listeners added to this type will be called when this signal dispatches.
         */
        public function bindSignal(signal:ISignal, type:MessageType):void
        {
            if (!(signal is type.messageClass))
            {
                throw new IllegalOperationError("This MessageType need " + getQualifiedClassName(type.messageClass) + " but is " + getQualifiedClassName(signal));
            }
            if (typeListBySignalMap[signal])
            {
                var typeList:Vector.<MessageType> = typeListBySignalMap[signal];
                if (typeList.indexOf(type) == -1)
                {
                    typeList.push(type);
                }
            }
            else
            {
                typeListBySignalMap[signal] = Vector.<MessageType>([type]);
                signal.add(signalHandler);
            }
        }
        /**
         * Unbind a signal to a MessageType.
         */
        public function unbindSignal(signal:ISignal, type:MessageType):void
        {
            var typeList:Vector.<MessageType> = typeListBySignalMap[signal];
            if (!typeList)
            {
                return;
            }
            var index:int = typeList.indexOf(type);
            if (index == -1)
            {
                return;
            }
            typeList.splice(index, 1);
            if (typeList.length == 0)
            {
                delete typeListBySignalMap[signal];
            }
        }
        /**
         * Bind an event to a MessageType.
         * All listeners added to this type will be called when this eventDispatcher dispatches this eventType.
         */
        public function bindEvent(eventDispatcher:IEventDispatcher, eventType:String, type:MessageType):void
        {
            if (!typeListOfEventTypByDispatcherList[eventDispatcher])
            {
                typeListOfEventTypByDispatcherList[eventDispatcher] = new Dictionary();
            }
            var typeListByEventTypeMap:Dictionary = typeListOfEventTypByDispatcherList[eventDispatcher];
            if (typeListByEventTypeMap[eventType])
            {
                var typeList:Vector.<MessageType> = typeListByEventTypeMap[eventType];
                if (typeList.indexOf(type) == -1)
                {
                    typeList.push(type);
                }
            }
            else
            {
                typeListByEventTypeMap[eventType] = Vector.<MessageType>([type]);
                eventDispatcher.addEventListener(eventType, eventHandler);
            }
        }
        /**
         * Unbind an event to a MessageType.
         */
        public function unbindEvent(eventDispatcher:IEventDispatcher, eventType:String, type:MessageType):void
        {
            if (!typeListOfEventTypByDispatcherList[eventDispatcher])
            {
                return;
            }
            var typeListByEventTypeMap:Dictionary = typeListOfEventTypByDispatcherList[eventDispatcher];
            if (!typeListByEventTypeMap[eventType])
            {
                return;
            }
            var typeList:Vector.<MessageType> = typeListByEventTypeMap[eventType];
            var index:int = typeList.indexOf(type);
            if (index == -1)
            {
                return;
            }
            typeList.splice(index, 1);
            if (typeList.length == 0)
            {
                delete typeListByEventTypeMap[eventType];
                for (eventType in typeListByEventTypeMap)
                {
                    return;
                }
                delete typeListOfEventTypByDispatcherList[eventDispatcher];
            }
        }
        /**
         * Add listener to a MessageType.
         * This listener will be called when any signal bound to this type dispatches.
         */
        public function addListener(type:MessageType, listener:Function):Function
        {
            registerListener(type, listener);
            return listener;
        }
        /**
         * Add listener to a MessageType only once..
         * This listener will be called when any signal bound to this type dispatches,
         * and the listener will be removed at the same time.
         */
        public function addListenerOnce(type:MessageType, listener:Function):Function
        {
            registerListener(type, listener, true);
            return listener;
        }
        /**
         * Remove a listener to s MessageType.
         */
        public function removeListener(type:MessageType, listener:Function):Function
        {
            var listenerList:Vector.<Function> = listenerListByTypeMap[type];
            if (!listenerList || listenerList.length == 0)
            {
                return listener;
            }
            var index:int = listenerList.indexOf(listener);
            if (index == -1)
            {
                return listener;
            }
            listenerList.splice(index, 1);
            if (onceListenerByTypeMap[type])
            {
                delete onceListenerByTypeMap[type][listener];
            }
            return listener;
        }
        /**
         * Dispatch a MessageType directly.
         */
        public function dispatch(type:MessageType, messageObject:* = null):void
        {
            var listenerList:Vector.<Function> = listenerListByTypeMap[type];
            if (!listenerList || listenerList.length == 0)
            {
                return;
            }
            var onceListenerMap:Dictionary = onceListenerByTypeMap[type];
            for each (var listener:Function in listenerList.concat())
            {
                if (listener.length == 0)
                {
                    listener();
                }
                else if (listener.length == 1)
                {
                    listener(messageObject);
                }
                else
                {
                    listener(messageObject, type);
                }
                if (onceListenerMap && onceListenerMap[listener])
                {
                    removeListener(type, listener);
                }
            }
        }
        //======================================================================
        // Private methods
        //======================================================================
        private function registerListener(type:MessageType, listener:Function, once:Boolean = false):void
        {
            if (listenerListByTypeMap[type])
            {
                var listenerList:Vector.<Function> = listenerListByTypeMap[type];
                if (listenerList.indexOf(listener) == -1)
                {
                    listenerList.push(listener);
                }
                else
                {
                    var wasOnce:Boolean = onceListenerByTypeMap[type] && onceListenerByTypeMap[type][listener];
                    if (wasOnce && !once)
                    {
                        throw new IllegalOperationError('You cannot addOnce() then add() the same listener without removing the relationship first.');
                    }
                    else if (!wasOnce && once)
                    {
                        throw new IllegalOperationError('You cannot add() then addOnce() the same listener without removing the relationship first.');
                    }
                }
            }
            else
            {
                listenerListByTypeMap[type] = Vector.<Function>([listener]);
            }
            if (!once)
            {
                return;
            }
            if (!onceListenerByTypeMap[type])
            {
                onceListenerByTypeMap[type] = new Dictionary();
            }
            onceListenerByTypeMap[type][listener] = true;
        }
        //======================================================================
        // Signal handlers
        //======================================================================
        private function signalHandler(signal:ISignal):void
        {
            var typeList:Vector.<MessageType> = typeListBySignalMap[signal];
            if (!typeList || typeList.length == 0)
            {
                return;
            }
            for each (var type:MessageType in typeList.concat())
            {
                dispatch(type, signal);
            }
        }
        private function eventHandler(event:Event):void
        {
            var typeListByEventTypeMap:Dictionary = typeListOfEventTypByDispatcherList[event.currentTarget];
            if (!typeListByEventTypeMap)
            {
                return;
            }
            var typeList:Vector.<MessageType> = typeListByEventTypeMap[event.type];
            if (!typeList || typeList.length == 0)
            {
                return;
            }
            for each (var type:MessageType in typeList.concat())
            {
                if (event is type.messageClass)
                {
                    dispatch(type, event);
                }
            }
        }
    }
}