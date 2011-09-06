package org.signallite.integrations.flexunit
{
    import org.flexunit.async.Async;
    import org.signallite.ISignal;

    /**
     * Delegate function for <code>Async.failOnSignal()</code>.
     * @author eidiot
     */
    public function failOnSignal(testCase:Object, signal:ISignal, timeout:int = 10, timeoutHandler:Function = null):void
    {
        Async.failOnEvent(testCase, new SignalAsyncHelper(signal), SignalAsyncHelper.SIGNAL_ASYNC, timeout, timeoutHandler);
    }
}