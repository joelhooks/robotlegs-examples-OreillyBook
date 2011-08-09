package mosaic.model.utils
{
    import flash.utils.Dictionary;

    public class IDIndexer
    {
        public function createIndex(itemList:Vector.<ID>):Dictionary
        {
            var indexByID:Dictionary = new Dictionary();

            var iLength:uint = itemList.length;
            for (var i:int = 0; i < iLength; i++)
            {
                var item:ID = itemList[i];
                indexByID[item.id] = item;
            }

            return indexByID;
        }

    }
}