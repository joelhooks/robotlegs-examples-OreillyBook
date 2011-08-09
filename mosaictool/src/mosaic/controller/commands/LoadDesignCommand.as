package mosaic.controller.commands
{
    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.services.design.IDesignLoadingService;

    import org.robotlegs.mvcs.Command;

    public class LoadDesignCommand extends Command
    {
        [Inject]
        public var designLoadingService:IDesignLoadingService;

        [Inject]
        public var designLoadEvent:DesignLoadEvent;

        override public function execute():void
        {
            var designName:String = designLoadEvent.designName;
            designLoadingService.loadDesign(designName);
        }
    }
}