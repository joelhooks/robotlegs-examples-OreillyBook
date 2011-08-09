package mosaic.view.ui
{
    import mosaic.controller.events.WorkspaceColorEvent;

    import org.robotlegs.mvcs.Mediator;

    public class WorkspaceMediator extends Mediator
    {
        [Inject]
        public var view:Workspace;

        override public function onRegister():void
        {
            addContextListener(WorkspaceColorEvent.COLOR_CHANGED, changeWorkspaceColor, WorkspaceColorEvent);
            addContextListener(WorkspaceColorEvent.COLOR_LOADED, changeWorkspaceColor, WorkspaceColorEvent);
        }

        protected function changeWorkspaceColor(e:WorkspaceColorEvent):void
        {
            view.color = e.color;
        }
    }
}