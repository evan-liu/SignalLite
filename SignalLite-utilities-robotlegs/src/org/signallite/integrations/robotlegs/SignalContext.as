package org.signallite.integrations.robotlegs
{
    import org.robotlegs.mvcs.Context;
    import org.signallite.IMessageBus;
    import org.signallite.MessageBus;

    import flash.display.DisplayObjectContainer;

    public class SignalContext extends Context implements ISignalContext
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function SignalContext(contextView:DisplayObjectContainer = null,
                                      autoStartup:Boolean = true)
        {
            super(contextView, autoStartup);
        }
        //======================================================================
        // Properties
        //======================================================================
        //------------------------------
        // messageBus
        //------------------------------
        protected var _messageBus:IMessageBus;
        public function get messageBus():IMessageBus
        {
            return _messageBus ||= new MessageBus();
        }
        public function set messageBus(value:IMessageBus):void
        {
            _messageBus = value;
        }
        //------------------------------
        // signalCommandMap
        //------------------------------
        private var _signalCommandMap:ISignalCommandMap;
        public function get signalCommandMap():ISignalCommandMap
        {
            return _signalCommandMap ||= new SignalCommandMap(injector, reflector, messageBus);
        }
        public function set signalCommandMap(value:ISignalCommandMap):void
        {
            _signalCommandMap = value;
        }
        //======================================================================
        // Overridden methods
        //======================================================================
        override protected function mapInjections():void
        {
            super.mapInjections();
            injector.mapValue(IMessageBus, messageBus);
            injector.mapValue(ISignalCommandMap, signalCommandMap);
        }
        override public function startup():void
        {
            messageBus.dispatch(ContextMessage.STARTUP_COMPLETE);
        }
        override public function shutdown():void
        {
            messageBus.dispatch(ContextMessage.SHUTDOWN_COMPLETE);
        }
    }
}