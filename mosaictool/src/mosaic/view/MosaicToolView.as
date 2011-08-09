package mosaic.view
{
    import flash.display.Sprite;

    import mosaic.view.grid.GridLayout;
    import mosaic.view.grid.GridView;
    import mosaic.view.grid.ITileFactory;
    import mosaic.view.ui.EditPanelView;
    import mosaic.view.ui.Workspace;
    import mosaic.view.ui.dialogs.CreateMosaicDialog;
    import mosaic.view.ui.dialogs.SaveAsDialog;

    public class MosaicToolView extends Sprite
    {
        protected var _tileFactory:ITileFactory;
        protected var _grid:GridView;
        protected var _toolAreaWidth:Number;

        public function MosaicToolView(tileFactory:ITileFactory, toolAreaWidth:Number)
        {
            _tileFactory = tileFactory;
            _toolAreaWidth = toolAreaWidth;
            addWorkspace();
            addEditPanel();
        }

        public function changeDefaultColor(color:uint):void
        {
            _tileFactory.defaultColor = color;
        }

        public function showGrid(rows:uint, columns:uint):void
        {
            clear();
            _grid = new GridView(_tileFactory);
            _grid.setGridSize(rows, columns);
            addChild(_grid);

            new GridLayout(_grid, stage.stageWidth, stage.stageHeight, _toolAreaWidth, _tileFactory.tileSize)
                    .resizeGridToFit(rows, columns)
                    .centerGrid();
        }

        public function showCreationDialog():void
        {
            addChild(new CreateMosaicDialog(stage.stageWidth, stage.stageHeight));
        }

        public function showSaveAsDialog():void
        {
            addChild(new SaveAsDialog(stage.stageWidth, stage.stageHeight));
        }

        protected function addEditPanel():void
        {
            addChild(new EditPanelView());
        }

        protected function addWorkspace():void
        {
            var workspaceWidth:Number = 970 - _toolAreaWidth;
            var workspace:Workspace = new Workspace(workspaceWidth, 550);
            workspace.x = _toolAreaWidth;
            addChild(workspace);
        }

        protected function clear():void
        {
            if (_grid && contains(_grid))
            {
                removeChild(_grid);
            }
        }
    }
}