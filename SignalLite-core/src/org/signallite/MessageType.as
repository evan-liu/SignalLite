package org.signallite
{
    /**
     * Type of message like <code>Event.type</code> to be used by <code>MessageBus</code>.
     */
    public class MessageType
    {
        //======================================================================
        // Constructor
        //======================================================================
        /**
         * @param messageClass Message class that can bind to this type.
         */
        public function MessageType(messageClass:Class)
        {
            _messageClass = messageClass;
        }
        //======================================================================
        // Properties
        //======================================================================
        //------------------------------
        // messageClass
        //------------------------------
        /**
         * @private
         */
        private var _messageClass:Class;
        /**
         * Message class that can bind to this type.
         */
        public function get messageClass():Class
        {
            return _messageClass;
        }
    }
}