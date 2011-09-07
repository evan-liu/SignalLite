package org.signallite.examples.sixNumberGame.commands
{
    import org.robotlegs.core.IMediatorMap;
    import org.signallite.examples.sixNumberGame.view.GameFlowMediator;
    import org.signallite.examples.sixNumberGame.view.GameFlowView;
    import org.signallite.examples.sixNumberGame.view.PlayerActMediator;
    import org.signallite.examples.sixNumberGame.view.PlayerActView;
    public class SetUpViewCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var mediator:IMediatorMap;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute():void
        {
            mediator.mapView(PlayerActView, PlayerActMediator);
            mediator.mapView(GameFlowView, GameFlowMediator);
        }
    }
}