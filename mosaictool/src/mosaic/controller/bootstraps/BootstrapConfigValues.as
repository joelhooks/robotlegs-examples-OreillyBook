package mosaic.controller.bootstraps
{
    import mosaic.model.values.ConfigName;
    import mosaic.model.values.DefaultDesignName;
    import mosaic.model.values.DefaultGridSize;
    import mosaic.model.values.DefaultTileColor;
    import mosaic.model.values.DefaultWorkspaceColor;

    import org.robotlegs.core.IInjector;

    public class BootstrapConfigValues
    {
        public function BootstrapConfigValues(injector:IInjector)
        {
            injector.mapValue(ConfigName, new ConfigName("MosaicDesignerConfig"));
            injector.mapValue(DefaultDesignName, new DefaultDesignName("Practice Design"));
            injector.mapValue(DefaultGridSize, new DefaultGridSize(15, 20));
            injector.mapValue(DefaultTileColor, new DefaultTileColor(0x333333));
            injector.mapValue(DefaultWorkspaceColor, new DefaultWorkspaceColor(0x000000));
        }
    }
}