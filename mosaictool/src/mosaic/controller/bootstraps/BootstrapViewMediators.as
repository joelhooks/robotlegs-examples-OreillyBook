package mosaic.controller.bootstraps
{
    import mosaic.view.MosaicToolView;
    import mosaic.view.MosaicToolViewMediator;
    import mosaic.view.grid.GridView;
    import mosaic.view.grid.GridViewMediator;
    import mosaic.view.tilesupply.TileSupplyDetailView;
    import mosaic.view.tilesupply.TileSupplyDetailViewMediator;
    import mosaic.view.tilesupply.TileSupplyMenu;
    import mosaic.view.tilesupply.TileSupplyMenuMediator;
    import mosaic.view.ui.DesignNameView;
    import mosaic.view.ui.DesignNameViewMediator;
    import mosaic.view.ui.LoadSelector;
    import mosaic.view.ui.LoadSelectorMediator;
    import mosaic.view.ui.Workspace;
    import mosaic.view.ui.WorkspaceMediator;
    import mosaic.view.ui.buttons.CreateButton;
    import mosaic.view.ui.buttons.CreateButtonMediator;
    import mosaic.view.ui.buttons.SaveAsButton;
    import mosaic.view.ui.buttons.SaveAsButtonMediator;
    import mosaic.view.ui.buttons.SaveButton;
    import mosaic.view.ui.buttons.SaveButtonMediator;
    import mosaic.view.ui.colorselectors.DefaultTileColorSelectorView;
    import mosaic.view.ui.colorselectors.DefaultTileColorSelectorViewMediator;
    import mosaic.view.ui.colorselectors.GroutSelectorView;
    import mosaic.view.ui.colorselectors.GroutSelectorViewMediator;
    import mosaic.view.ui.colorselectors.WorkspaceColorSelectorView;
    import mosaic.view.ui.colorselectors.WorkspaceColorSelectorViewMediator;
    import mosaic.view.ui.dialogs.CreateMosaicDialog;
    import mosaic.view.ui.dialogs.CreateMosaicDialogMediator;

    import org.robotlegs.core.IMediatorMap;

    public class BootstrapViewMediators extends Object
    {
        public function BootstrapViewMediators(mediatorMap:IMediatorMap)
        {
            mediatorMap.mapView(TileSupplyDetailView, TileSupplyDetailViewMediator);
            mediatorMap.mapView(TileSupplyMenu, TileSupplyMenuMediator);
            mediatorMap.mapView(GridView, GridViewMediator);
            mediatorMap.mapView(CreateButton, CreateButtonMediator);
            mediatorMap.mapView(LoadSelector, LoadSelectorMediator);
            mediatorMap.mapView(SaveAsButton, SaveAsButtonMediator);
            mediatorMap.mapView(SaveButton, SaveButtonMediator);
            mediatorMap.mapView(DesignNameView, DesignNameViewMediator);
            mediatorMap.mapView(DefaultTileColorSelectorView, DefaultTileColorSelectorViewMediator);
            mediatorMap.mapView(GroutSelectorView, GroutSelectorViewMediator);
            mediatorMap.mapView(WorkspaceColorSelectorView, WorkspaceColorSelectorViewMediator);
            mediatorMap.mapView(Workspace, WorkspaceMediator);
            mediatorMap.mapView(MosaicToolView, MosaicToolViewMediator);
            mediatorMap.mapView(CreateMosaicDialog, CreateMosaicDialogMediator);
        }
    }
}