package org.signallite.examples.sixNumberGame.view
{
    import flash.display.Sprite;

    public class GameView extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function GameView()
        {
            super();
            build();
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var playerView:PlayerActView;
        private var flowView:GameFlowView;
        //======================================================================
        //  Private methods
        //======================================================================
        private function build():void
        {
            flowView = new GameFlowView();
            flowView.y = 10;
            addChild(flowView);

            playerView = new PlayerActView();
            playerView.y = 50;
            addChild(playerView);
        }
    }
}