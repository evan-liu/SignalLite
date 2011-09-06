package org.signallite.examples.sixNumberGame.commands
{
    import org.robotlegs.core.IInjector;
    public class SetUpModelCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var injector:IInjector;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute():void
        {
            trace("[SetUpModelCommand/execute]");
        }
    }
}