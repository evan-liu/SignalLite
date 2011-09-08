package org.signallite.examples.sixNumberGame.view
{
    import flash.text.TextFormat;
    import org.signallite.examples.sixNumberGame.model.PlayResult;

    import flash.display.Sprite;
    import flash.text.TextField;

    public class PlayInfoView extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function PlayInfoView()
        {
            super();
            mouseEnabled = mouseChildren = false;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var roundField:TextField;
        private var centerRoundValueField:TextField;
        private var roundResultField:TextField;
        private var outValueField:TextField;
        private var scoreField:TextField;
        private var resultField:TextField;
        //======================================================================
        //  Public methods
        //======================================================================
        public function renderRoundStart(value:int):void
        {
            if (value == 1 && numChildren > 0) {
                reset();
            }
            var text:String = "Round: " + value;
            if (roundField)
            {
                updateField(roundField, text);
            }
            else
            {
                roundField = createField(text);
            }
        }
        public function renderCenterRoundAction(value:int):void
        {
            var text:String = "Center Round Value: " + value;
            if (centerRoundValueField)
            {
                updateField(centerRoundValueField, text);
            }
            else
            {
                centerRoundValueField = createField(text, 20);
            }
        }
        public function renderRoundResult(result:PlayResult, roundNumber:int,
                                          centerValue:int, competitorValue:int,
                                          playerValue:int):void
        {
            var text:String = "Round " + roundNumber + ": [ " + result.value + " ]";
            text += " - " + getTriadValueText(centerValue, competitorValue, playerValue);
            if (roundResultField && roundResultField.text)
            {
                text += "\n" + roundResultField.text;
            }
            if (roundResultField)
            {
                updateField(roundResultField, text);
            }
            else
            {
                roundResultField = createField(text, 90);
            }
        }
        public function renderOut(centerValue:int, competitorValue:int, playerValue:int):void
        {
            var text:String = "";
            if (centerValue > 0)
            {
                text = "Out values: " + (centerValue + competitorValue + playerValue) +
                       " ( " + getTriadValueText(centerValue, competitorValue, playerValue) + " )";
            }
            if (outValueField)
            {
                updateField(outValueField, text);
            }
            else
            {
                outValueField = createField(text, 70);
            }
        }
        public function renderScore(playerValue:int, competitorValue:int):void
        {
            var text:String = "Total Score \t" + playerValue + " : " + competitorValue;
            if (scoreField)
            {
                updateField(scoreField, text);
            }
            else
            {
                scoreField = createField(text, 50);
            }
        }
        public function renderGameResult(result:PlayResult):void
        {
            var text:String = "Game Result: " + result.value;
            if (resultField)
            {
                updateField(resultField, text);
            }
            else
            {
                resultField = createField(text, 170, new TextFormat("Verdana", 20, 0xFF0000, true));
            }
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function reset():void
        {
            for (var i:int = 0; i < numChildren; i++)
            {
                var field:TextField = getChildAt(i) as TextField;
                if (field)
                {
                    field.text = "";
                }
            }
        }
        private function createField(text:String, y:Number = 0, format:TextFormat = null):TextField
        {
            var result:TextField = new TextField();
            if (format)
            {
                result.defaultTextFormat = format;
            }
            result.text = text;
            result.width = result.textWidth + 4;
            result.height = result.textHeight + 4;
            result.x = 10;
            result.y = y;
            addChild(result);
            return result;
        }
        private function updateField(field:TextField, text:String = ""):void
        {
            if (field)
            {
                field.text = text;
                field.width = field.textWidth + 4;
                field.height = field.textHeight + 4;
            }
        }
        private function getTriadValueText(centerValue:int, competitorValue:int, playerValue:int):String
        {
            return "You: " + playerValue + "  Competitor: " + competitorValue + "  Center: " + centerValue;
        }
    }
}