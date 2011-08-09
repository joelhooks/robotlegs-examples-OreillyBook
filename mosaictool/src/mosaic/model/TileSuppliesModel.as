package mosaic.model
{
    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.controller.events.TileSupplyListEvent;

    import org.robotlegs.mvcs.Actor;

    public class TileSuppliesModel extends Actor implements ITileSuppliesModel
    {
        protected var _supplyList:TileSuppliesList;

        public function switchTiles(idWas:uint, idNow:uint):void
        {
            supplyWithID(idWas).count -= 1;
            supplyWithID(idNow).count += 1;
            dispatchTileSupplyEvent(TileSupplyEvent.QUANTITY_CHANGED, supplyWithID(idWas));
            dispatchTileSupplyEvent(TileSupplyEvent.QUANTITY_CHANGED, supplyWithID(idNow));
        }

        public function addSupply(id:uint, color:uint):void
        {
            _supplyList.addSupply(new TileSupplyVO(id, color, 0));
            dispatchTileSupplyEvent(TileSupplyEvent.SUPPLY_ADDED, supplyWithID(id));
        }

        public function removeSupply(id:uint):void
        {
            _supplyList.removeSupply(id);
        }

        public function changeSupplyColor(id:uint, color:uint):void
        {
            supplyWithID(id).updateColor(color);
            if (id == _supplyList.selectedSupplyID)
            {
                dispatchTileSupplyEvent(TileSupplyEvent.SELECTED_SUPPLY_COLOR_CHANGED, supplyWithID(id));
            }
        }

        public function combineSupplies(idWas:uint, idNow:uint):void
        {
            supplyWithID(idNow).count += supplyWithID(idWas).count;
            removeSupply(idWas);
        }

        public function get supplyList():Vector.<TileSupplyVO>
        {
            if (_supplyList && _supplyList.supplyList)
            {
                return _supplyList.supplyList;
            }
            return new Vector.<TileSupplyVO>();
        }

        public function set supplyList(itemList:Vector.<TileSupplyVO>):void
        {
            _supplyList = new TileSuppliesList(itemList);
            dispatch(new TileSupplyListEvent(TileSupplyListEvent.CHANGED, itemList));
        }

        public function get selectedSupplyID():uint
        {
            return _supplyList.selectedSupplyID;
        }

        public function set selectedSupplyID(value:uint):void
        {
            _supplyList.selectedSupplyID = value;
        }

        protected function supplyWithID(id:uint):TileSupplyVO
        {
            return _supplyList.supplyWithID(id) || new NullTileSupplyVO();
        }

        protected function dispatchTileSupplyEvent(type:String, vo:TileSupplyVO):void
        {
            dispatch(new TileSupplyEvent(type, vo.id, vo.color, vo.count));
        }
    }
}