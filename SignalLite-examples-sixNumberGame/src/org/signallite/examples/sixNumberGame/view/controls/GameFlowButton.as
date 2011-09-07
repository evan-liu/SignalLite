package org.signallite.examples.sixNumberGame.view.controls
{
    import flash.display.Sprite;
    import flash.text.TextField;

    public class GameFlowButton extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function GameFlowButton(label:String, minWidth:Number = 80)
        {
            super();

            buttonMode = true;
            mouseChildren = false;

            var field:TextField = new TextField();
            field.text = label;
            field.width = field.textWidth + 4;
            field.height = field.textHeight + 4;

            const MARGIN:int = 5;
            const W:int = Math.max(minWidth, field.width + MARGIN * 2);
            const H:int = field.height + MARGIN * 2;

            with (graphics)
            {
                lineStyle(0, 0x666666);
                beginFill(0xEEEFF0);
                drawRoundRect(0, 0, W, H, 10);
                endFill();
            }

            field.x = (W - field.width) / 2;
            field.y = MARGIN;
            addChild(field);
        }
    }
}
