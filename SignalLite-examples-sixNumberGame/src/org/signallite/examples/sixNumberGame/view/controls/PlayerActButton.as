package org.signallite.examples.sixNumberGame.view.controls
{
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.display.Sprite;

    public class PlayerActButton extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function PlayerActButton(value:int)
        {
            super();

            _value = value;

            build();

            buttonMode = true;
            mouseChildren = false;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  value
        //------------------------------
        private var _value:int;
        public function get value():int
        {
            return _value;
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function build():void
        {
            var field:TextField = new TextField();
            field.defaultTextFormat = new TextFormat("Verdana", 16, 0x0000FF, true);
            field.text = String(_value);
            field.width = field.textWidth + 4;
            field.height = field.textHeight + 4;

            with (graphics)
            {
                lineStyle(0, 0xFF0000, 0.5);
                beginFill(0xDDDDDD);
                drawRoundRect(0, 0, 30, 30, 10);
                endFill();
            }

            field.x = (width - field.width) / 2;
            field.y = (height - field.height) / 2;
            addChild(field);
        }
    }
}