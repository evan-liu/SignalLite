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
        private var playerActView:PlayerActView;
        private var flowView:GameFlowView;
        private var playInfoView:PlayInfoView;
        //======================================================================
        //  Private methods
        //======================================================================
        private function build():void
        {
            flowView = new GameFlowView();
            flowView.y = 10;
            addChild(flowView);

            playerActView = new PlayerActView();
            playerActView.y = 50;
            addChild(playerActView);

            playInfoView = new PlayInfoView();
            playInfoView.y = 100;
            addChild(playInfoView);
        }
    }
}