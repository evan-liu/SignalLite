package org.signallite.integrations.flexunit
{
    import org.flexunit.async.Async;
    import org.signallite.ISignal;

    /**
     * Delegate function for <code>Async.registerFailureEvent()</code>.
     * @author eidiot
     */
    public function registerFailureSignal(testCase:Object, signal:ISignal):void
    {
        Async.registerFailureEvent(testCase, new SignalAsyncHelper(signal), SignalAsyncHelper.SIGNAL_ASYNC);
    }
}