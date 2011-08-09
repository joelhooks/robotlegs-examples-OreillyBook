package mosaic.view.ui.buttons
{
    import flash.events.MouseEvent;

    import mosaic.controller.events.DesignSaveEvent;

    import org.robotlegs.mvcs.Mediator;

    public class SaveButtonMediator extends Mediator
    {
        [Inject]
        public var view:SaveButton;

        override public function onRegister():void
        {
            addViewListener(MouseEvent.CLICK, dispatchSaveRequestedEvent);
        }

        protected function dispatchSaveRequestedEvent(e:MouseEvent):void
        {
            var evt:DesignSaveEvent = new DesignSaveEvent(DesignSaveEvent.SAVE_REQUESTED, '');
            dispatch(evt);
        }

    }
}