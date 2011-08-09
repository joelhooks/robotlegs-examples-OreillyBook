package mosaic.model
{
    public interface IMosaicSpecModel
    {
        function get rows():uint;

        function set rows(value:uint):void;

        function get columns():uint;

        function set columns(value:uint):void;

        function get defaultTileColor():uint;

        function set defaultTileColor(value:uint):void;

        function get groutColor():uint;

        function set groutColor(value:uint):void;
    }
}

