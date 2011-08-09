package mosaic.view.ui.buttons
{
    import flash.events.MouseEvent;

    import mosaic.controller.events.DesignSaveEvent;

    import org.robotlegs.mvcs.Mediator;

    public class SaveAsButtonMediator extends Mediator
    {
        [Inject]
        public var view:SaveAsButton;

        override public function onRegister():void
        {
            addViewListener(MouseEvent.CLICK, dispatchSaveAsRequestedEvent);
        }

        protected function dispatchSaveAsRequestedEvent(e:MouseEvent):void
        {
            var evt:DesignSaveEvent = new DesignSaveEvent(DesignSaveEvent.SAVE_AS_REQUESTED, '');
            dispatch(evt);
        }

    }
}