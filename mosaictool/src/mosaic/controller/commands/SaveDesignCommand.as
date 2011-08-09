package mosaic.controller.commands
{
    import mosaic.model.IConfigModel;
    import mosaic.services.design.IDesignSavingService;

    import org.robotlegs.mvcs.Command;

    public class SaveDesignCommand extends Command
    {
        [Inject]
        public var designSavingService:IDesignSavingService;

        [Inject]
        public var configModel:IConfigModel

        override public function execute():void
        {
            designSavingService.saveDesign(configModel.currentDesign);
        }
    }
}