package mosaic.controller.commands
{

    import mosaic.model.values.ConfigName;
    import mosaic.services.config.IMosaicConfigSavingService;

    import org.robotlegs.mvcs.Command;

    public class SaveConfigCommand extends Command
    {
        [Inject]
        public var configSavingService:IMosaicConfigSavingService;

        [Inject]
        public var configName:ConfigName;

        override public function execute():void
        {
            configSavingService.saveConfig(configName.toString());
        }
    }
}