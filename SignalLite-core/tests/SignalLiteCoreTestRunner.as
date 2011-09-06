package
{
    import org.flexunit.internals.TraceListener;
    import org.flexunit.runner.FlexUnitCore;

    import flash.display.Sprite;

    public class SignalLiteCoreTestRunner extends Sprite
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function SignalLiteCoreTestRunner()
        {
            flexUnit = new FlexUnitCore();
            flexUnit.addListener(new TraceListener());
            flexUnit.run(SignalLiteCoreTests);
        }
        //======================================================================
        // Variables
        //======================================================================
        private var flexUnit:FlexUnitCore;
    }
}