package mosaic.view.ui.colorselectors
{
    import mosaic.controller.events.GroutEvent;
    import mosaic.view.ui.colorselectors.events.ColorChangeEvent;

    import org.robotlegs.mvcs.Mediator;

    public class GroutSelectorViewMediator extends Mediator
    {
        [Inject]
        public var view:GroutSelectorView;

        override public function onRegister():void
        {
            addViewListener(ColorChangeEvent.CHANGED, dispatchGroutColorChange);
            addContextListener(GroutEvent.COLOR_LOADED, changeViewColor);
        }

        protected function dispatchGroutColorChange(e:ColorChangeEvent):void
        {
            var evt:GroutEvent = new GroutEvent(GroutEvent.COLOR_CHANGED, e.color);
            dispatch(evt);
        }

        protected function changeViewColor(e:GroutEvent):void
        {
            view.selectedColor = e.color;
        }

    }
}