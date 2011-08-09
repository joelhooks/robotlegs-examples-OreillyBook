package mosaic.view
{
    import mosaic.controller.events.CreateMosaicEvent;
    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.controller.events.DesignEvent;
    import mosaic.controller.events.DesignSaveEvent;
    import mosaic.controller.events.TileColorChangeEvent;

    import org.robotlegs.mvcs.Mediator;

    public class MosaicToolViewMediator extends Mediator
    {
        [Inject]
        public var view:MosaicToolView;

        override public function onRegister():void
        {
            addContextListener(DesignCreationEvent.DESIGN_CREATED, showGridOnView, DesignCreationEvent);
            addContextListener(CreateMosaicEvent.NEW_MOSAIC_REQUESTED, addCreationDialog, CreateMosaicEvent);
            addContextListener(DesignSaveEvent.SAVE_AS_REQUESTED, showSaveAsDialog, DesignSaveEvent);
            addContextListener(DesignEvent.DESIGN_COLORS_LOADED, showLoadedGridOnView, DesignEvent);
            addContextListener(TileColorChangeEvent.DEFAULT_CHANGED, changeDefaultTileColor, TileColorChangeEvent);
            addContextListener(TileColorChangeEvent.DEFAULT_LOADED, changeDefaultTileColor, TileColorChangeEvent);
        }

        protected function showGridOnView(e:DesignCreationEvent):void
        {
            view.showGrid(e.rows, e.columns);
        }

        protected function addCreationDialog(e:CreateMosaicEvent):void
        {
            view.showCreationDialog();
        }

        protected function showSaveAsDialog(e:DesignSaveEvent):void
        {
            view.showSaveAsDialog();
        }

        protected function showLoadedGridOnView(e:DesignEvent):void
        {
            var rows:uint = e.colors.length;
            var columms:uint = e.colors[0].length;
            view.showGrid(rows, columms);
        }

        protected function changeDefaultTileColor(e:TileColorChangeEvent):void
        {
            view.changeDefaultColor(e.color);
        }
    }
}