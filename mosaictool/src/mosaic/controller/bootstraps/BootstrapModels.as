package mosaic.controller.bootstraps
{
    import mosaic.model.ConfigModel;
    import mosaic.model.IConfigModel;
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.ITileSuppliesModel;
    import mosaic.model.MosaicDesignModel;
    import mosaic.model.MosaicSpecModel;
    import mosaic.model.TileSuppliesModel;
    import mosaic.model.utils.AutoIncrementor;
    import mosaic.model.utils.IAutoIncrementor;

    import org.robotlegs.core.IInjector;

    public class BootstrapModels
    {
        public function BootstrapModels(injector:IInjector)
        {
            injector.mapSingletonOf(IConfigModel, ConfigModel);
            injector.mapSingletonOf(IMosaicDesignModel, MosaicDesignModel);
            injector.mapSingletonOf(ITileSuppliesModel, TileSuppliesModel);
            injector.mapSingletonOf(IMosaicSpecModel, MosaicSpecModel);
            injector.mapSingletonOf(IAutoIncrementor, AutoIncrementor);
        }
    }
}