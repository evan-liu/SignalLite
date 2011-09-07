package org.signallite.examples.sixNumberGame.events
{
    import flash.events.Event;

    public class GameFlowEvent extends Event
    {
        //======================================================================
        //  Class constants
        //======================================================================
        public static const START_GAME:String = "startGame";
        public static const RESTART_GAME:String = "restartGame";
        //======================================================================
        //  Constructor
        //======================================================================
        public function GameFlowEvent(type:String)
        {
            super(type, true);
        }
        //======================================================================
        //  Overridden methods
        // ======================================================================
        override public function clone():Event
        {
            return new GameFlowEvent(type);
        }
    }
}