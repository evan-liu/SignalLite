package org.signallite.examples.sixNumberGame.view
{
    import org.signallite.examples.sixNumberGame.message.GameFlowEvent;
    import org.signallite.examples.sixNumberGame.view.controls.GameFlowButton;

    import flash.display.Sprite;
    import flash.events.MouseEvent;


    public class GameFlowView extends Sprite
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var startButton:Sprite;
        private var restartButton:Sprite;
        //======================================================================
        //  Public methods
        //======================================================================
        public function showStart():void
        {
            if (!startButton)
            {
                startButton = new GameFlowButton("Play Game");
                startButton.addEventListener(MouseEvent.CLICK, startButton_clickHandler);
            }
            render(startButton);
        }
        public function showPlaying():void
        {
            clean();
        }
        public function showEnd():void
        {
            if (!restartButton)
            {
                restartButton = new GameFlowButton("Play Again");
                restartButton.addEventListener(MouseEvent.CLICK, restartButton_clickHandler);
            }
            render(restartButton);
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function clean():void
        {
            while (numChildren > 0)
            {
                removeChildAt(0);
            }
        }
        private function render(content:Sprite):void
        {
            clean();
            content.x = 10;
            addChild(content);
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function startButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new GameFlowEvent(GameFlowEvent.START_GAME));
        }
        private function restartButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new GameFlowEvent(GameFlowEvent.RESTART_GAME));
        }
    }
}