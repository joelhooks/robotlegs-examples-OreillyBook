package mosaic.view.ui.parts
{

    import fl.controls.Label;

    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class RightAlignedWhiteLabel extends Label
    {

        public function RightAlignedWhiteLabel()
        {
            init();
        }

        protected function init():void
        {
            autoSize = TextFieldAutoSize.RIGHT;
            var textFormat:TextFormat = new TextFormat();
            textFormat.font = 'Arial';
            textFormat.color = 0xFFFFFF;
            textFormat.size = 16;
            setStyle('textFormat', textFormat);
        }

    }

}