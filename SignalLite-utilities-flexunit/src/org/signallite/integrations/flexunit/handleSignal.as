package org.signallite.integrations.flexunit
{
    import org.flexunit.async.Async;
    import org.signallite.ISignal;

    /**
     * Delegate function for <code>Async.handleSignal()</code>.
     * @author eidiot
     */
    public function handleSignal(testCase:Object, signal:ISignal, signalHandler:Function, timeout:int = 500, passThroughData:Object = null, timeoutHandler:Function = null):void
    {
        var async:SignalAsyncHelper = new SignalAsyncHelper(signal, signalHandler);
        Async.handleEvent(testCase, async, SignalAsyncHelper.SIGNAL_ASYNC, async.asyncHandler, timeout, passThroughData, timeoutHandler);
    }
}