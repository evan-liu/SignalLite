package org.signallite
{
    /**
     * A signal about progress.
     */
    public class ProgressSignal extends SignalBase
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function ProgressSignal(target:Object = null, value:Number = 0,
                                       current:Number = -1, total:Number = -1)
        {
            _value = value;
            _current = current;
            _total = total;
            super(target);
        }
        //------------------------------
        // total
        //------------------------------
        private var _total:Number = -1;
        /**
         * Total value of the progress, like ProgressEvent.bytesTotal.
         */
        public function get total():Number
        {
            return _total;
        }
        //------------------------------
        // current
        //------------------------------
        private var _current:Number = -1;
        /**
         * Current value of the progress, like ProgressEvent.bytesLoaded.
         */
        public function get current():Number
        {
            return _current;
        }
        //------------------------------
        // value
        //------------------------------
        private var _value:Number = 0;
        /**
         * Progress value form 0 to 1.
         */
        public function get value():Number
        {
            return _value;
        }
        //======================================================================
        // Public methods
        //======================================================================
        /**
         * Dispatch this signal to listeners.
         */
        public function dispatch(value:Number, current:Number = -1, total:Number = -1):void
        {
            _value = value;
            _current = current;
            _total = total;
            callListeners();
        }
    }
}