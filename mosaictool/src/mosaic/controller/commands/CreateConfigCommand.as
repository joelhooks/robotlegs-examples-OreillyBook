package mosaic.controller.commands
{
    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.controller.events.MosaicConfigServiceEvent;
    import mosaic.model.IConfigModel;
    import mosaic.model.values.DefaultDesignName;
    import mosaic.model.values.DefaultGridSize;
    import mosaic.model.values.DefaultWorkspaceColor;

    import org.robotlegs.mvcs.Command;

    public class CreateConfigCommand extends Command
    {
        [Inject]
        public var configModel:IConfigModel;

        [Inject]
        public var defaultWorkspaceColor:DefaultWorkspaceColor;

        [Inject]
        public var firstDesignName:DefaultDesignName;

        [Inject]
        public var defaultGridSize:DefaultGridSize;

        override public function execute():void
        {
            var designName:String = firstDesignName.toString();

            configModel.workspaceColor = defaultWorkspaceColor.value;
            configModel.designNames = Vector.<String>([designName]);

            // TODO: Point where order of operations matters!
            var evt:MosaicConfigServiceEvent = new MosaicConfigServiceEvent(MosaicConfigServiceEvent.CONFIG_CREATED);
            dispatch(evt);

            var gridEvent:DesignCreationEvent = new DesignCreationEvent(DesignCreationEvent.DESIGN_CREATED,
                    defaultGridSize.rows, defaultGridSize.columns, designName);
            dispatch(gridEvent);
        }
    }
}