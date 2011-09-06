package org.signallite
{
    import flash.errors.IllegalOperationError;
    import flash.utils.Dictionary;

    /**
     * Base class for signals.
     */
    public class SignalBase implements ISignal
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function SignalBase(target:Object = null)
        {
            _target = target;
        }
        //======================================================================
        // Variables
        //======================================================================
        protected var listeners:Vector.<Function> = new Vector.<Function>();
        protected var onceListeners:Dictionary = new Dictionary();
        protected var listenersNeedCloning:Boolean = false;
        //======================================================================
        // Properties
        //======================================================================
        //------------------------------
        // target
        //------------------------------
        protected var _target:Object;
        /** @inheritDoc */
        public function get target():Object
        {
            return _target;
        }
        //------------------------------
        // numListeners
        //------------------------------
        /** @inheritDoc */
        public function get numListeners():uint
        {
            return listeners.length;
        }
        //======================================================================
        // Public methods
        //======================================================================
        /** @inheritDoc */
        public function add(listener:Function):Function
        {
            registerListener(listener);
            return listener;
        }
        /** @inheritDoc */
        public function addOnce(listener:Function):Function
        {
            registerListener(listener, true);
            return listener;
            ;
        }
        /** @inheritDoc */
        public function remove(listener:Function):Function
        {
            var index:int = listeners.indexOf(listener);
            if (index == -1) return listener;
            if (listenersNeedCloning)
            {
                listeners = listeners.concat();
                listenersNeedCloning = false;
            }
            listeners.splice(index, 1);
            delete onceListeners[listener];
            return listener;
        }
        public function removeAll():void
        {
            // Looping backwards is more efficient when removing array items.
            for (var i:uint = listeners.length; i--; )
            {
                remove(listeners[i] as Function);
            }
        }
        /**
         * Call this function in the subclasses' dispatch() method.
         */
        public function callListeners():void
        {
            if (!listeners.length) return;

            // During a dispatch, add() and remove() should clone listeners array instead of modifying it.
            listenersNeedCloning = true;

            for each (var listener:Function in listeners)
            {
                if (onceListeners[listener]) remove(listener);
                if (listener.length == 0)
                {
                    listener();
                }
                else
                {
                    listener(this);
                }
            }
            listenersNeedCloning = false;
        }
        //======================================================================
        // Protected methods
        //======================================================================
        protected function registerListener(listener:Function, once:Boolean = false):void
        {
            // If there are no previous listeners, add the first one as quickly as possible.
            if (!listeners.length)
            {
                listeners[0] = listener;
                if (once) onceListeners[listener] = true;
                return;
            }
            if (listeners.indexOf(listener) >= 0)
            {
                // If the listener was previously added, definitely don't add it again.
                // But throw an exception in some cases, as the error messages explain.
                if (onceListeners[listener] && !once)
                {
                    throw new IllegalOperationError('You cannot addOnce() then add() the same listener without removing the relationship first.');
                }
                else if (!onceListeners[listener] && once)
                {
                    throw new IllegalOperationError('You cannot add() then addOnce() the same listener without removing the relationship first.');
                }
                // Listener was already added, so do nothing.
                return;
            }
            if (listenersNeedCloning)
            {
                listeners = listeners.concat();
                listenersNeedCloning = false;
            }
            listeners.push(listener);
            if (once) onceListeners[listener] = true;
        }
    }
}