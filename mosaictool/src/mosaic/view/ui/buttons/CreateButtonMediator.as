package mosaic.view.ui.buttons
{
    import flash.events.MouseEvent;

    import mosaic.controller.events.CreateMosaicEvent;

    import org.robotlegs.mvcs.Mediator;

    public class CreateButtonMediator extends Mediator
    {
        [Inject]
        public var view:CreateButton;

        override public function onRegister():void
        {
            addViewListener(MouseEvent.CLICK, dispatchNewMosaicRequested);
        }

        protected function dispatchNewMosaicRequested(e:MouseEvent):void
        {
            var evt:CreateMosaicEvent = new CreateMosaicEvent(CreateMosaicEvent.NEW_MOSAIC_REQUESTED);
            dispatch(evt);
        }

    }
}