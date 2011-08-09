package mosaic.view.ui.colorselectors
{
    import mosaic.controller.events.WorkspaceColorEvent;
    import mosaic.view.ui.colorselectors.events.ColorChangeEvent;

    import org.robotlegs.mvcs.Mediator;

    public class WorkspaceColorSelectorViewMediator extends Mediator
    {
        [Inject]
        public var view:WorkspaceColorSelectorView;

        override public function onRegister():void
        {
            addViewListener(ColorChangeEvent.CHANGED, dispatchWorkspaceColorChange);
            addContextListener(WorkspaceColorEvent.COLOR_LOADED, changeViewColor);
        }

        protected function dispatchWorkspaceColorChange(e:ColorChangeEvent):void
        {
            var evt:WorkspaceColorEvent = new WorkspaceColorEvent(WorkspaceColorEvent.COLOR_CHANGED, e.color);
            dispatch(evt);
        }

        protected function changeViewColor(e:WorkspaceColorEvent):void
        {
            view.selectedColor = e.color;
        }

    }
}