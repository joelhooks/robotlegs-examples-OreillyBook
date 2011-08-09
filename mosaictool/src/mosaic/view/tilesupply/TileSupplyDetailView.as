package mosaic.view.tilesupply
{
    import fl.controls.RadioButton;

    import flash.display.Sprite;

    import mosaic.view.ui.colorselectors.BaseColorSelectorView;
    import mosaic.view.ui.parts.DeleteTileSupplyButton;

    public class TileSupplyDetailView extends BaseColorSelectorView
    {
        protected var _deleteButton:DeleteTileSupplyButton;
        protected var _id:uint;
        protected var _radioButton:RadioButton;

        public function TileSupplyDetailView(id:uint, defaultColor:uint, count:Number)
        {
            _id = id;
            super(String(count), defaultColor);
            addDeleteButton();
            addRadioButton();
        }

        public function get count():Number
        {
            return Number(_labelField.text);
        }

        public function set count(value:Number):void
        {
            _label = String(value);
            _labelField.text = _label;
        }

        public function get radioButton():RadioButton
        {
            return _radioButton;
        }

        public function get deleteButton():Sprite
        {
            return _deleteButton;
        }

        public function get id():uint
        {
            return _id;
        }

        protected function addDeleteButton():void
        {
            _deleteButton = new DeleteTileSupplyButton();
            _deleteButton.x = 30;
            _deleteButton.y = 2;
            addChild(_deleteButton);
        }

        protected function addRadioButton():void
        {
            _radioButton = new RadioButton();
            _radioButton.label = '';
            _radioButton.x = 140;
            addChild(_radioButton);
        }
    }
}