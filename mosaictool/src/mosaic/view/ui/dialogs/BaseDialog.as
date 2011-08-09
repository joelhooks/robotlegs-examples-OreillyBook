package mosaic.view.ui.dialogs
{
    import fl.controls.Button;

    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import mosaic.view.ui.parts.LabelledTextInput;

    public class BaseDialog extends Sprite
    {
        protected static const Y_SPACING:Number = 40;
        protected static const LEFT_BUTTON_X:Number = -60;
        protected static const RIGHT_BUTTON_X:Number = 10;
        protected var _centerX:Number;
        protected var _centerY:Number;
        protected var _nextLabelY:Number;

        public function BaseDialog(useWidth:Number, useHeight:Number)
        {
            _centerX = useWidth / 2;
            _centerY = _nextLabelY = useHeight / 2;
            addModalBackground(useWidth, useHeight);
        }

        protected function addModalBackground(useWidth:Number, useHeight:Number):void
        {
            graphics.beginFill(0x000000, 0.5);
            graphics.drawRect(0, 0, useWidth, useHeight);
        }

        protected function addTextInput(prompt:String, defaultValue:String, inputWidth:Number, restrict:String = null):LabelledTextInput
        {
            var input:LabelledTextInput = new LabelledTextInput(prompt, defaultValue, inputWidth, restrict);
            addAtPosition(input, _centerX, _nextLabelY);
            _nextLabelY -= Y_SPACING;
            return input;
        }

        protected function addButton(label:String, xPos:Number):Button
        {
            var button:Button = new Button();
            button.label = label;
            button.width = 50;
            button.addEventListener(MouseEvent.CLICK, removeDialog, false, 0, true);
            addAtPosition(button, _centerX + xPos, _centerY + 50);
            return button;
        }

        protected function removeDialog(e:MouseEvent):void
        {
            parent.removeChild(this);
        }

        protected function addAtPosition(item:Sprite, xPos:Number, yPos:Number):void
        {
            addChild(item);
            item.x = xPos;
            item.y = yPos;
        }
    }
}