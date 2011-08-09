package mosaic.controller.bootstraps
{
    import mosaic.services.config.IMosaicConfigLoadingService;
    import mosaic.services.config.IMosaicConfigSavingService;
    import mosaic.services.config.MosaicConfigSolLoadingService;
    import mosaic.services.config.MosaicConfigSolSavingService;
    import mosaic.services.design.DesignFromSolParser;
    import mosaic.services.design.DesignSolLoadingService;
    import mosaic.services.design.DesignSolSavingService;
    import mosaic.services.design.DesignToSolParser;
    import mosaic.services.design.IDesignFromDataParser;
    import mosaic.services.design.IDesignLoadingService;
    import mosaic.services.design.IDesignSavingService;
    import mosaic.services.design.IDesignToDataParser;
    import mosaic.services.design.ITileSupplyFromDataParser;
    import mosaic.services.design.ITileSupplyToDataParser;
    import mosaic.services.design.TileSupplyFromSolParser;
    import mosaic.services.design.TileSupplyToSolParser;

    import org.robotlegs.core.IInjector;

    public class BootstrapServices
    {

        public function BootstrapServices(injector:IInjector)
        {
            injector.mapSingletonOf(IMosaicConfigLoadingService, MosaicConfigSolLoadingService);
            injector.mapSingletonOf(IMosaicConfigSavingService, MosaicConfigSolSavingService);
            injector.mapSingletonOf(IDesignFromDataParser, DesignFromSolParser);
            injector.mapSingletonOf(IDesignToDataParser, DesignToSolParser);
            injector.mapSingletonOf(ITileSupplyToDataParser, TileSupplyToSolParser);
            injector.mapSingletonOf(ITileSupplyFromDataParser, TileSupplyFromSolParser);
            injector.mapSingletonOf(IDesignSavingService, DesignSolSavingService);
            injector.mapSingletonOf(IDesignLoadingService, DesignSolLoadingService);
        }

    }

}