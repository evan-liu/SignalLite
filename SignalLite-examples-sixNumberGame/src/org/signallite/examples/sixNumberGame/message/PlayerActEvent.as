package org.signallite.examples.sixNumberGame.message
{
    import flash.events.Event;

    public class PlayerActEvent extends Event
    {
        //======================================================================
        //  Class constants
        //======================================================================
        public static const PLAYER_ACT:String = "playerAct";
        //======================================================================
        //  Constructor
        //======================================================================
        public function PlayerActEvent(value:int)
        {
            super(PLAYER_ACT, true);
            _value = value;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  value
        //------------------------------
        private var _value:int;
        public function get value():int
        {
            return _value;
        }
        //======================================================================
        //  Overridden methods
        // ======================================================================
        override public function clone():Event
        {
            return new PlayerActEvent(_value);
        }
    }
}