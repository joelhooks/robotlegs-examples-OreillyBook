package mosaic.view.ui.dialogs
{
    import fl.controls.Button;

    import mosaic.view.ui.parts.LabelledTextInput;

    public class CreateMosaicDialog extends BaseDialog
    {
        protected var _rowsInput:LabelledTextInput;
        protected var _columnsInput:LabelledTextInput;
        protected var _designName:LabelledTextInput;
        protected var _createButton:Button;

        public function CreateMosaicDialog(useWidth:Number, useHeight:Number)
        {
            super(useWidth, useHeight);
            addTextInputs();
            addButtons();
        }

        public function get rows():uint
        {
            return uint(_rowsInput.text);
        }

        public function get columns():uint
        {
            return uint(_columnsInput.text);
        }

        public function get designName():String
        {
            return _designName.text;
        }

        public function get createButton():Button
        {
            return _createButton;
        }

        protected function addTextInputs():void
        {
            _designName = addTextInput('design name', 'Design name', 100);
            _rowsInput = addTextInput('rows', '10', 40, LabelledTextInput.DIGITS);
            _columnsInput = addTextInput('columns', '8', 40, LabelledTextInput.DIGITS);
        }

        protected function addButtons():void
        {
            addButton('cancel', LEFT_BUTTON_X);
            _createButton = addButton('create', RIGHT_BUTTON_X);
        }
    }
}