package org.signallite.examples.sixNumberGame.commands
{
    import org.signallite.examples.sixNumberGame.view.GameView;

    import flash.display.DisplayObjectContainer;
    public class LaunchGameCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var contextView:DisplayObjectContainer;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute():void
        {
            contextView.addChild(new GameView());
        }
    }
}