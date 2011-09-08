package org.signallite.examples.sixNumberGame.message
{
    import org.signallite.SignalBase;
    import org.signallite.examples.sixNumberGame.model.PlayResult;

    public class PlayResultSignal extends SignalBase
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function PlayResultSignal(target:Object = null, result:PlayResult = null)
        {
            super(target);
            _result = result;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  result
        //------------------------------
        private var _result:PlayResult;
        public function get result():PlayResult
        {
            return _result;
        }
        //======================================================================
        //  Public methods
        //======================================================================
        public function dispatch(result:PlayResult):void
        {
            _result = result;
            callListeners();
        }
    }
}