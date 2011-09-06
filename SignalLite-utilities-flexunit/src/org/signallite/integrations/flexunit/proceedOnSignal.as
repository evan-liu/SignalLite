package org.signallite.integrations.flexunit
{
    import org.flexunit.async.Async;
    import org.signallite.ISignal;

    /**
     * Delegate function for <code>Async.proceedOnSignal()</code>.
     * @author eidiot
     */
    public function proceedOnSignal(testCase:Object, signal:ISignal, timeout:int = 500, timeoutHandler:Function = null):void
    {
        Async.proceedOnEvent(testCase, new SignalAsyncHelper(signal), SignalAsyncHelper.SIGNAL_ASYNC, timeout, timeoutHandler);
    }
}