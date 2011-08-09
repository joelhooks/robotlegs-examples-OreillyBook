package mosaic.controller.commands
{

    import mosaic.controller.events.NamedDesignEvent;
    import mosaic.model.IConfigModel;

    import org.robotlegs.mvcs.Command;

    public class UpdateCurrentDesignOnConfigCommand extends Command
    {
        [Inject]
        public var namedDesignEvent:NamedDesignEvent;

        [Inject]
        public var configModel:IConfigModel;

        override public function execute():void
        {
            configModel.currentDesign = namedDesignEvent.designName;
        }
    }
}