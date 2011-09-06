package
{
    import org.flexunit.internals.TraceListener;
    import org.flexunit.runner.FlexUnitCore;
    import flash.display.Sprite;

    public class SixNumberGameTestRunner extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function SixNumberGameTestRunner()
        {
            flexUnit = new FlexUnitCore();
            flexUnit.addListener(new TraceListener());
            flexUnit.run(SixNumberGameTests);
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var flexUnit:FlexUnitCore;
    }
}