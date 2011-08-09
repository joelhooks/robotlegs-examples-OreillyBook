package mosaic.controller.commands
{
    import mosaic.model.values.ConfigName;
    import mosaic.services.config.IMosaicConfigLoadingService;

    import org.robotlegs.mvcs.Command;

    public class LoadConfigCommand extends Command
    {
        [Inject]
        public var configName:ConfigName;

        [Inject]
        public var configLoadingService:IMosaicConfigLoadingService;

        override public function execute():void
        {
            configLoadingService.loadConfig(configName.toString());
        }
    }
}