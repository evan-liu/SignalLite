package org.signallite
{
    /**
     * A Signal dispatched when some value changed.
     */
    public class ValueChangedSignal extends SignalBase
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function ValueChangedSignal(target:Object = null, value:* = null,
                                           old:* = null, key:* = null)
        {
            super(target);
            _value = value;
            _old = old;
            _key = key;
        }
        //======================================================================
        // Properties
        //======================================================================
        //------------------------------
        // value
        //------------------------------
        private var _value:*;
        public function get value():*
        {
            return _value;
        }
        //------------------------------
        // old
        //------------------------------
        private var _old:*;
        public function get old():*
        {
            return _old;
        }
        //------------------------------
        // key
        //------------------------------
        private var _key:*;
        public function get key():*
        {
            return _key;
        }
        //======================================================================
        // Public methods
        //======================================================================
        public function dispatch(value:* = null, old:* = null, key:* = null):void
        {
            _value = value;
            _old = old;
            _key = key;
            callListeners();
        }
    }
}