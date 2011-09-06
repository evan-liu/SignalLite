package org.signallite.integrations.flexunit
{
    import org.signallite.ISignal;

    import flash.events.Event;
    import flash.events.EventDispatcher;

    internal class SignalAsyncHelper extends EventDispatcher
    {
        //======================================================================
        // Class constants
        //======================================================================
        public static const SIGNAL_ASYNC:String = "signalAsync";
        //======================================================================
        // Constructor
        //======================================================================
        /**
         * Construct a <code>SignalAsync</code>.
         */
        public function SignalAsyncHelper(signal:ISignal, handler:Function = null)
        {
            this.signal = signal;
            this.handler = handler;
            signal.addOnce(onCalled);
        }
        //======================================================================
        // Variables
        //======================================================================
        private var signal:ISignal;
        private var handler:Function;
        //======================================================================
        // Public methods
        //======================================================================
        public function asyncHandler(event:Event, data:Object):void
        {
            if (handler != null)
            {
                switch (handler.length)
                {
                    case 0:
                        handler();
                        break;
                    case 1:
                        handler(signal);
                        break;
                    default:
                        handler(signal, data);
                        break;
                }
            }
        }
        //======================================================================
        // Callbacks
        //======================================================================
        private function onCalled():void
        {
            dispatchEvent(new Event(SIGNAL_ASYNC));
        }
    }
}