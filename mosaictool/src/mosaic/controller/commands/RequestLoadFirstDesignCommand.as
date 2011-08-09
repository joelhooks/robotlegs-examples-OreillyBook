package mosaic.controller.commands
{
    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.model.IConfigModel;

    import org.robotlegs.mvcs.Command;

    public class RequestLoadFirstDesignCommand extends Command
    {
        [Inject]
        public var configModel:IConfigModel;

        override public function execute():void
        {
            dispatch(new DesignLoadEvent(DesignLoadEvent.LOAD_REQUESTED, configModel.currentDesign));
        }
    }
}