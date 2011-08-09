package mosaic
{
    import flash.display.DisplayObjectContainer;

    import mosaic.controller.bootstraps.BootstrapClasses;
    import mosaic.controller.bootstraps.BootstrapCommands;
    import mosaic.controller.bootstraps.BootstrapConfigValues;
    import mosaic.controller.bootstraps.BootstrapModels;
    import mosaic.controller.bootstraps.BootstrapServices;
    import mosaic.controller.bootstraps.BootstrapTileSupplyCommands;
    import mosaic.controller.bootstraps.BootstrapViewMediators;
    import mosaic.view.MosaicToolView;
    import mosaic.view.grid.ITileFactory;
    import mosaic.view.grid.TileFactory;

    import org.robotlegs.mvcs.Context;

    public class MosaicContext extends Context
    {
        public function MosaicContext(contextView:DisplayObjectContainer)
        {
            super(contextView, true);
        }

        override public function startup():void
        {
            new BootstrapConfigValues(injector);
            new BootstrapModels(injector);
            new BootstrapServices(injector);
            new BootstrapCommands(commandMap);
            new BootstrapTileSupplyCommands(commandMap);
            new BootstrapClasses(injector);
            new BootstrapViewMediators(mediatorMap);

            addRootView();
            // and we're done
            super.startup();
        }

        protected function addRootView():void
        {
            var tileFactory:ITileFactory = new TileFactory(20, 0x333333);
            var mainView:MosaicToolView = new MosaicToolView(tileFactory, 150);
            contextView.addChild(mainView);
        }
    }
}