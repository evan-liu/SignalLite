package org.signallite.examples.sixNumberGame
{
    import org.signallite.examples.sixNumberGame.commands.LaunchGameCommand;
    import org.signallite.examples.sixNumberGame.commands.SetUpCommandsCommand;
    import org.signallite.examples.sixNumberGame.commands.SetUpModelCommand;
    import org.signallite.examples.sixNumberGame.commands.SetUpViewCommand;
    import org.signallite.integrations.robotlegs.ContextMessage;
    import org.signallite.integrations.robotlegs.SignalContext;

    import flash.display.DisplayObjectContainer;

    public class SixNumberGameContext extends SignalContext
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function SixNumberGameContext(contextView:DisplayObjectContainer)
        {
            super(contextView);
        }
        //======================================================================
        //  Overridden methods
        // ======================================================================
        override public function startup():void
        {
            signalCommandMap.map(ContextMessage.STARTUP, SetUpModelCommand, true);
            signalCommandMap.map(ContextMessage.STARTUP, SetUpCommandsCommand, true);
            signalCommandMap.map(ContextMessage.STARTUP, SetUpViewCommand, true);

            signalCommandMap.map(ContextMessage.STARTUP_COMPLETE, LaunchGameCommand, true);

            messageBus.dispatch(ContextMessage.STARTUP);
            messageBus.dispatch(ContextMessage.STARTUP_COMPLETE);
        }
    }
}