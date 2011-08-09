package mosaic.model
{
    import flash.events.IEventDispatcher;

    public interface ITileSuppliesModel
    {
        function switchTiles(idWas:uint, idNow:uint):void;

        function addSupply(id:uint, color:uint):void;

        function changeSupplyColor(id:uint, color:uint):void;

        function removeSupply(id:uint):void;

        function combineSupplies(idWas:uint, idNow:uint):void;

        function get supplyList():Vector.<TileSupplyVO>;

        function set supplyList(value:Vector.<TileSupplyVO>):void;

        function get selectedSupplyID():uint;

        function set selectedSupplyID(value:uint):void;

        function get eventDispatcher():IEventDispatcher;

        function set eventDispatcher(value:IEventDispatcher):void;
    }
}