package org.signallite
{
    /**
     * Interface for signals.
     */
    public interface ISignal
    {
        //======================================================================
        // Properties
        //======================================================================
        /** Target who dispatched the signal. */
        function get target():Object;
        /** The current number of listeners for the signal. */
        function get numListeners():uint;
        //======================================================================
        // Methods
        //======================================================================
        /**
         * Subscribes a listener for the signal.
         * @param	listener A function to handle the signal.
         * @return the listener Function passed as the parameter.
         */
        function add(listener:Function):Function;
        /**
         * Subscribes a one-time listener for this signal.
         * The signal will remove the listener automatically the first time it is called,
         * after the dispatch to all listeners is complete.
         * @param	listener A function to handle the signal.
         * @return the listener Function passed as the parameter
         */
        function addOnce(listener:Function):Function;
        /**
         * Unsubscribes a listener from the signal.
         * @param	listener
         * @return the listener Function passed as the parameter
         */
        function remove(listener:Function):Function;
        /**
         * Unsubscribes all listeners from the signal.
         */
        function removeAll():void
    }
}