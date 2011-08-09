package mosaic.controller.commands
{
    import mosaic.controller.events.GroutEvent;
    import mosaic.model.IMosaicSpecModel;

    import org.robotlegs.mvcs.Command;

    public class ChangeGroutColorCommand extends Command
    {
        [Inject]
        public var groutEvent:GroutEvent;

        [Inject]
        public var mosaicSpecModel:IMosaicSpecModel;

        override public function execute():void
        {
            mosaicSpecModel.groutColor = groutEvent.color;
        }
    }
}