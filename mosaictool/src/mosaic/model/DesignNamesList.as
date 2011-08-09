package mosaic.model
{
    public class DesignNamesList
    {
        protected var _items:Vector.<String>;
        protected var _selectedItem:String;

        public function DesignNamesList(items:Vector.<String>)
        {
            _items = items;
            if (_items.length > 0)
            {
                _selectedItem = _items[0];
            }
        }

        public function selectAndAddIfNeeded(item:String):Boolean
        {
            _selectedItem = item;
            if (!contains(item))
            {
                _items.push(item);
                return true;
            }
            return false;
        }

        public function get selectedItem():String
        {
            return _selectedItem;
        }

        public function get designNames():Vector.<String>
        {
            return _items;
        }

        public function get hasItems():Boolean
        {
            return (_items && _items.length > 0);
        }

        public function contains(searchFor:String):Boolean
        {
            return (_items.indexOf(searchFor) != -1);
        }
    }
}