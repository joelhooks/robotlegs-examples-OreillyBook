package mosaic.view.grid
{

    public interface ITileFactory
    {

        function get tileSize():Number;

        function set tileSize(size:Number):void;

        function get defaultColor():uint;

        function set defaultColor(color:uint):void;

        function createTile():ITileView;

        function createQuarterTile():ITileView;
    }

}

