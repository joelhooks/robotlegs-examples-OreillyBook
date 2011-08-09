package mosaic.view.ui.colorselectors
{
    import fl.controls.ColorPicker;
    import fl.controls.Label;

    import flash.display.Sprite;
    import flash.events.Event;

    import mosaic.view.ui.colorselectors.events.ColorChangeEvent;
    import mosaic.view.ui.parts.RightAlignedWhiteLabel;

    public class BaseColorSelectorView extends Sprite
    {
        protected var _label:String;
        protected var _defaultColor:uint;
        protected var _colorPicker:ColorPicker;
        protected var _labelField:Label;

        public function BaseColorSelectorView(label:String, defaultColor:uint)
        {
            _label = label;
            _defaultColor = defaultColor;
            addEventListener(Event.ADDED_TO_STAGE, addContents);
        }

        public function get selectedColor():uint
        {
            return _colorPicker.selectedColor;
        }

        public function set selectedColor(color:uint):void
        {
            _colorPicker.selectedColor = color;
        }

        protected function addContents(e:Event):void
        {
            addLabel();
            addColorPicker();
        }

        protected function addLabel():void
        {
            _labelField = new RightAlignedWhiteLabel();
            addChild(_labelField);
            _labelField.text = _label;
        }

        protected function addColorPicker():void
        {
            _colorPicker = new ColorPicker();
            addChild(_colorPicker);
            _colorPicker.x = 110;
            _colorPicker.selectedColor = _defaultColor;
            _colorPicker.addEventListener(Event.CHANGE, relayColorChange);
        }

        protected function relayColorChange(e:Event):void
        {
            var evt:ColorChangeEvent = new ColorChangeEvent(ColorChangeEvent.CHANGED, _colorPicker.selectedColor);
            dispatchEvent(evt);
        }
    }
}