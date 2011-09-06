package org.signallite
{
    /**
     * A simple signal with any arguments or not.
     */
    public class Signal extends SignalBase
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function Signal(target:Object = null)
        {
            super(target);
        }
        //======================================================================
        // Public methods
        //======================================================================
        /**
         * Dispatch this signal to listeners.
         */
        public function dispatch():void
        {
            callListeners();
        }
    }
}