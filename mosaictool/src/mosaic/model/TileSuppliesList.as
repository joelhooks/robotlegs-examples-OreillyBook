package mosaic.model
{
    import flash.utils.Dictionary;

    import mosaic.model.utils.ID;
    import mosaic.model.utils.IDIndexer;

    import utils.vector.VectorUtils;

    public class TileSuppliesList
    {
        protected var _supplyList:Vector.<TileSupplyVO>;
        protected var _suppliesByID:Dictionary;
        protected var _selectedSupplyID:uint;

        public function TileSuppliesList(supplyList:Vector.<TileSupplyVO>)
        {
            _supplyList = supplyList;
            _selectedSupplyID = supplyList[0].id;
            _suppliesByID = new IDIndexer().createIndex(Vector.<ID>(supplyList));
        }

        public function supplyWithID(id:uint):TileSupplyVO
        {
            return _suppliesByID[id];
        }

        public function get supplyList():Vector.<TileSupplyVO>
        {
            return _supplyList;
        }

        public function removeSupply(id:uint):void
        {
            var item:TileSupplyVO = _suppliesByID[id];
            VectorUtils.removeItem(_supplyList, item);
            delete _suppliesByID[id];
        }

        public function addSupply(tileSupply:TileSupplyVO):void
        {
            _supplyList.push(tileSupply);
            _suppliesByID[tileSupply.id] = tileSupply;
        }

        public function get selectedSupplyID():uint
        {
            return _selectedSupplyID;
        }

        public function set selectedSupplyID(value:uint):void
        {
            _selectedSupplyID = value;
        }
    }
}