package mosaic.controller.commands
{
    import mosaic.controller.events.WorkspaceColorEvent;
    import mosaic.model.IConfigModel;

    import org.robotlegs.mvcs.Command;

    public class ApplyConfigWorkspaceColorCommand extends Command
    {

        [Inject]
        public var configModel:IConfigModel;

        override public function execute():void
        {
            var workspaceColor:uint = configModel.workspaceColor;
            dispatch(new WorkspaceColorEvent(WorkspaceColorEvent.COLOR_LOADED, workspaceColor));
        }
    }
}