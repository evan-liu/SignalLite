package org.signallite.examples.sixNumberGame.view
{
    import org.signallite.examples.sixNumberGame.events.PlayerActEvent;
    import org.signallite.examples.sixNumberGame.view.controls.PlayerActButton;

    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class PlayerActView extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function PlayerActView()
        {
            super();
        }
        //======================================================================
        //  Public methods
        //======================================================================
        public function fill(valueList:Vector.<int>):void
        {
            var currentX:Number = 100;
            for each (var value:int in valueList)
            {
                var button:PlayerActButton = new PlayerActButton(value);
                button.addEventListener(MouseEvent.CLICK, button_clickHandler);
                button.x = currentX;
                addChild(button);
                currentX += button.width + 10;
                button.visible = false;
            }
        }
        public function reset():void
        {
            for (var i:int = 0; i < numChildren; i++)
            {
                getChildAt(i).visible = true;
            }
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function button_clickHandler(event:MouseEvent):void
        {
            var button:PlayerActButton = event.currentTarget as PlayerActButton;
            button.visible = false;
            dispatchEvent(new PlayerActEvent(button.value));
        }
    }
}