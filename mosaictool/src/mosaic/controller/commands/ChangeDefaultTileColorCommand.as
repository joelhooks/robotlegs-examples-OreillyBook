package mosaic.controller.commands
{
    import mosaic.controller.events.TileColorChangeEvent;
    import mosaic.model.IMosaicSpecModel;

    import org.robotlegs.mvcs.Command;

    public class ChangeDefaultTileColorCommand extends Command
    {
        [Inject]
        public var specModel:IMosaicSpecModel;

        [Inject]
        public var defaultColorChangeEvent:TileColorChangeEvent;

        override public function execute():void
        {
            specModel.defaultTileColor = defaultColorChangeEvent.color;
        }
    }
}