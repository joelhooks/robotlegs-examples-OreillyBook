package mosaic.view.tilesupply
{
    import fl.controls.RadioButtonGroup;

    import flash.display.Sprite;
    import flash.utils.Dictionary;

    import mosaic.view.ui.parts.AddTileSupplyButton;

    public class TileSupplyMenu extends Sprite
    {
        protected static const SPACING:Number = 30;
        protected static const ADD_BUTTON_X_POS:Number = 120;
        protected var _addButton:Sprite;
        protected var _suppliesByID:Dictionary;
        protected var _tileSupplyGroup:RadioButtonGroup;

        public function TileSupplyMenu()
        {
            _addButton = addChild(new AddTileSupplyButton()) as Sprite;
            _addButton.x = ADD_BUTTON_X_POS;
            clear();
        }

        public function addSupply(id:uint, color:uint, count:Number):void
        {
            var supplyView:TileSupplyDetailView = new TileSupplyDetailView(id, color, count);
            supplyView.y = SPACING * numChildren - 1;
            addChildAt(supplyView, numChildren - 1);
            _addButton.y = SPACING * numChildren - 1;
            _suppliesByID[id] = supplyView;
            _tileSupplyGroup.addRadioButton(supplyView.radioButton);
            _tileSupplyGroup.selection = _tileSupplyGroup.selection || supplyView.radioButton;
        }

        public function get addButton():Sprite
        {
            return _addButton;
        }

        public function removeSupplyWithID(id:uint):void
        {
            var tileSupplyToRemove:TileSupplyDetailView = _suppliesByID[id];
            if (tileSupplyToRemove)
            {
                var removedItemDepth:uint = this.getChildIndex(tileSupplyToRemove);
                removeChild(tileSupplyToRemove);
                closeGapAfter(removedItemDepth);
                _tileSupplyGroup.removeRadioButton(tileSupplyToRemove.radioButton);
                delete _suppliesByID[id];
            }
        }

        public function clear():void
        {
            _suppliesByID = new Dictionary();
            _tileSupplyGroup = new RadioButtonGroup('Tile Supplies');
            while (numChildren > 1)
            {
                removeChildAt(0);
            }
        }

        protected function closeGapAfter(removedItemDepth:uint):void
        {
            var iLength:uint = numChildren;
            for (var i:int = removedItemDepth; i < iLength; i++)
            {
                getChildAt(i).y -= SPACING;
            }
        }
    }
}