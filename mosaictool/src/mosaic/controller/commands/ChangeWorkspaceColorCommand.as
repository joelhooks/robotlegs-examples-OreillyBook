package mosaic.controller.commands
{

    import mosaic.controller.events.WorkspaceColorEvent;
    import mosaic.model.IConfigModel;

    import org.robotlegs.mvcs.Command;

    public class ChangeWorkspaceColorCommand extends Command
    {
        [Inject]
        public var configModel:IConfigModel;

        [Inject]
        public var workspaceColorEvent:WorkspaceColorEvent;

        override public function execute():void
        {
            configModel.workspaceColor = workspaceColorEvent.color;
        }
    }
}