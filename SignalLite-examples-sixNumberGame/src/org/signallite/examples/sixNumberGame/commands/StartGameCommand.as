package org.signallite.examples.sixNumberGame.commands
{
    import org.signallite.examples.sixNumberGame.model.PlayModel;
    public class StartGameCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var model:PlayModel;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute():void
        {
            model.startGame();
        }
    }
}