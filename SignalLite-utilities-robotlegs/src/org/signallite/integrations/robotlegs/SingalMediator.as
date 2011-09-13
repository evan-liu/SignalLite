package org.signallite.integrations.robotlegs
{
    import org.robotlegs.base.MediatorBase;
    import org.signallite.IMessageBus;
    import org.signallite.ISignal;
    import org.signallite.MessageType;

    import flash.events.IEventDispatcher;

    public class SingalMediator extends MediatorBase
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var messageBus:IMessageBus;
        //======================================================================
        //  Variables
        //======================================================================
        protected var cleanFunctionList:Vector.<FunctionWrapper> = new Vector.<FunctionWrapper>();
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function preRemove():void
        {
            for each (var cleanFunction:FunctionWrapper in cleanFunctionList)
            {
                cleanFunction.apply();
            }
            super.preRemove();
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        //------------------------------
        //  Dispatch
        //------------------------------
        public function dispatchMessage(type:MessageType, messageObject:* = null):void
        {
            messageBus.dispatch(type, messageObject);
        }
        //------------------------------
        //  Add listeners
        //------------------------------
        public function addMessageListener(type:MessageType, listener:Function):Function
        {
            addCleanFuncion(messageBus.removeListener, type, listener);
            return messageBus.addListener(type, listener);
        }
        public function addMessageListenerOnce(type:MessageType, listener:Function):Function
        {
            addCleanFuncion(messageBus.removeListener, type, listener);
            return messageBus.addListenerOnce(type, listener);
        }
        public function addSignalListener(signal:ISignal, listener:Function):void
        {
            addCleanFuncion(signal.remove, listener);
            signal.add(listener);
        }
        public function addSignalListenerOnce(signal:ISignal, listener:Function):void
        {
            addCleanFuncion(signal.remove, listener);
            signal.addOnce(listener);
        }
        public function addEventListener(eventDispatcher:IEventDispatcher, type:String,
                                         listener:Function, useCapture:Boolean = false,
                                         priority:int = 0, useWeakReference:Boolean = false):void
        {
            addCleanFuncion(eventDispatcher.removeEventListener, type, listener, useCapture);
            eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }
        //------------------------------
        //  Bind messages
        //------------------------------
        public function bindEventToMessage(eventDispatcher:IEventDispatcher, eventType:String, type:MessageType):void
        {
            addCleanFuncion(messageBus.unbindEvent, eventDispatcher, eventType, type);
            messageBus.bindEvent(eventDispatcher, eventType, type);
        }
        public function bindSignalToMessage(signal:ISignal, type:MessageType):void
        {
            addCleanFuncion(messageBus.unbindSignal, signal, type);
            messageBus.bindSignal(signal, type);
        }
        //------------------------------
        //  Remove listeners
        //------------------------------
        public function removeMessageListener(type:MessageType, listener:Function):Function
        {
            return messageBus.removeListener(type, listener);
        }
        public function unbindEventToMessage(eventDispatcher:IEventDispatcher, eventType:String, type:MessageType):void
        {
            messageBus.unbindEvent(eventDispatcher, eventType, type);
        }
        public function unbindSignalToMessage(signal:ISignal, type:MessageType):void
        {
            messageBus.unbindSignal(signal, type);
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected function addCleanFuncion(target:Function, ...args):void
        {
            cleanFunctionList.push(new FunctionWrapper(target, args));
        }
    }
}
internal class FunctionWrapper {
    private var target:Function;
    private var args:Array;
    public function FunctionWrapper(target:Function, args:Array)
    {
        this.target = target;
        this.args = args;
    }
    public function apply():void
    {
        target.apply(null, args);
    }
}