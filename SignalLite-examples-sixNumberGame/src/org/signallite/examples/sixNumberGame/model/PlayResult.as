package org.signallite.examples.sixNumberGame.model
{
    public class PlayResult
    {
        //======================================================================
        //  Class constants
        //======================================================================
        public static const WIN:PlayResult = new PlayResult("win");
        public static const LOSE:PlayResult = new PlayResult("lose");
        public static const DRAW:PlayResult = new PlayResult("draw");
        //======================================================================
        //  Constructor
        //======================================================================
        public function PlayResult(value:String)
        {
            _value = value;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  value
        //------------------------------
        private var _value:String;
        public function get value():String
        {
            return _value;
        }
        //======================================================================
        //  Public methods
        //======================================================================
        public function toString():String
        {
            return "[GameResult " + _value + "]";
        }
    }
}