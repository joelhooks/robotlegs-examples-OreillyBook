package mosaic.view.ui.colorselectors
{
    import mosaic.controller.events.TileColorChangeEvent;
    import mosaic.view.ui.colorselectors.events.ColorChangeEvent;

    import org.robotlegs.mvcs.Mediator;

    public class DefaultTileColorSelectorViewMediator extends Mediator
    {
        [Inject]
        public var view:DefaultTileColorSelectorView;

        override public function onRegister():void
        {
            addViewListener(ColorChangeEvent.CHANGED, dispatchDefaultColorChange);
            addContextListener(TileColorChangeEvent.DEFAULT_LOADED, changeViewColor);
        }

        protected function dispatchDefaultColorChange(e:ColorChangeEvent):void
        {
            var evt:TileColorChangeEvent = new TileColorChangeEvent(TileColorChangeEvent.DEFAULT_CHANGED, 0, 0, e.color);
            dispatch(evt);
        }

        protected function changeViewColor(e:TileColorChangeEvent):void
        {
            view.selectedColor = e.color;
        }

    }
}