package mosaic.view.ui.dialogs
{
    import fl.controls.Button;

    import mosaic.view.ui.parts.LabelledTextInput;

    public class SaveAsDialog extends BaseDialog
    {
        protected var _designName:LabelledTextInput;
        protected var _saveButton:Button;

        public function SaveAsDialog(useWidth:Number, useHeight:Number)
        {
            super(useWidth, useHeight);
            addTextInputs();
            addButtons();
        }

        public function get designName():String
        {
            return _designName.text;
        }

        public function get saveButton():Button
        {
            return _saveButton;
        }

        protected function addTextInputs():void
        {
            _designName = addTextInput('design name', 'Design name', 100);
        }

        protected function addButtons():void
        {
            addButton('cancel', LEFT_BUTTON_X);
            _saveButton = addButton('save', RIGHT_BUTTON_X);
        }
    }
}