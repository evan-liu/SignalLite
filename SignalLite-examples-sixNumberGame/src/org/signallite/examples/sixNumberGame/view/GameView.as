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
            playerView = new PlayerActView();
            playerView.y = 300;
            addChild(playerView);

            flowView = new GameFlowView();
            flowView.y = 360;
            addChild(flowView);
        }
    }
}