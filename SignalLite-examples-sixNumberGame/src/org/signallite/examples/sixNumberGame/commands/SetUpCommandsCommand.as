package org.signallite.examples.sixNumberGame.commands
{
    import org.signallite.examples.sixNumberGame.message.GameMessage;
    import org.signallite.integrations.robotlegs.ISignalCommandMap;
    public class SetUpCommandsCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var commandMap:ISignalCommandMap;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute():void
        {
            commandMap.map(GameMessage.GAME_STARTED, StartGameCommand);
        }
    }
}