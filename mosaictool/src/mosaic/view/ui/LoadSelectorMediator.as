package mosaic.view.ui
{
    import mosaic.controller.events.DesignListEvent;
    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.view.ui.events.LoadSelectorEvent;

    import org.robotlegs.mvcs.Mediator;

    public class LoadSelectorMediator extends Mediator
    {
        [Inject]
        public var view:LoadSelector;

        override public function onRegister():void
        {
            addViewListener(LoadSelectorEvent.LOAD_CLICKED, dispatchLoadRequestedEvent, LoadSelectorEvent);
            addContextListener(DesignListEvent.CHANGED, passDesignListToView, DesignListEvent);
        }

        protected function dispatchLoadRequestedEvent(e:LoadSelectorEvent):void
        {
            var evt:DesignLoadEvent = new DesignLoadEvent(DesignLoadEvent.LOAD_REQUESTED, e.designName);
            dispatch(evt);
        }

        protected function passDesignListToView(e:DesignListEvent):void
        {
            view.designList = e.designList;
        }
    }
}