package mosaic.model
{
    import flash.events.IEventDispatcher;

    public interface IMosaicDesignModel
    {
        function loadDesign(designGrid:Vector.<Vector.<uint>>):void;

        function getDesign():Vector.<Vector.<uint>>;

        function changeTileColorAt(row:uint, column:uint, colorID:uint):uint;

        function switchTileColors(colorIDWas:uint, colorIDNow:uint):void;

        function get eventDispatcher():IEventDispatcher;

        function set eventDispatcher(value:IEventDispatcher):void;
    }
}