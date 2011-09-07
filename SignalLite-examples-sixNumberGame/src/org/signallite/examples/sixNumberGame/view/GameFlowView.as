package org.signallite.examples.sixNumberGame.view
{
    import org.signallite.examples.sixNumberGame.events.GameFlowEvent;
    import org.signallite.examples.sixNumberGame.view.controls.GameFlowButton;

    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class GameFlowView extends Sprite
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var startButton:Sprite;
        //======================================================================
        //  Public methods
        //======================================================================
        public function showStart():void
        {
            if (!startButton)
            {
                startButton = new GameFlowButton("Start Game");
                startButton.addEventListener(MouseEvent.CLICK, startButton_clickHandler);
            }
            render(startButton);
        }
        public function showPlaying():void
        {
            clean();
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
            content.x = (stage.stageWidth - content.width) / 2;
            addChild(content);
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function startButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new GameFlowEvent(GameFlowEvent.START_GAME));
        }
    }
}