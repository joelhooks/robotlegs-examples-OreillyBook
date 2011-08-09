package mosaic.view.ui.parts
{
    import fl.controls.Label;
    import fl.controls.TextInput;

    import flash.display.Sprite;

    public class LabelledTextInput extends Sprite
    {
        public static const DIGITS:String = '0123456789'
        protected var _input:TextInput;

        public function LabelledTextInput(prompt:String, defaultValue:String, inputWidth:Number, restrict:String = "")
        {
            addPrompt(prompt);
            addInput(prompt, defaultValue, inputWidth, restrict);
        }

        public function get text():String
        {
            return _input.text;
        }

        public function set text(value:String):void
        {
            _input.text = value;
        }

        protected function addPrompt(prompt:String):void
        {
            var label:Label = new RightAlignedWhiteLabel();
            label.text = prompt;
            label.x = -(label.width + 5);
            addChild(label);
        }

        protected function addInput(prompt:String, defaultValue:String, inputWidth:Number, restrict:String = ""):void
        {
            _input = new TextInput();
            _input.name = prompt;
            _input.text = defaultValue;
            _input.width = inputWidth;
            _input.restrict = restrict;
            _input.x = 5;
            addChild(_input);
        }
    }
}