package mosaic.view.grid
{
    public interface IGridView
    {
        function setGridSize(rows:uint, columns:uint):void;

        function applyColorsToWholeGrid(colorDataGrid:Vector.<Vector.<uint>>):void;

        function set selectionColor(color:uint):void;

        function set groutColor(color:uint):void;
    }
}