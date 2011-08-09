package mosaic.model.utils
{
    public class FileNameFixer extends Object
    {
        protected var _rawText:String;

        public function FileNameFixer(rawText:String)
        {
            _rawText = rawText;
        }

        public function get fileName():String
        {
            return _rawText.replace(/[\s]/, "_");
        }

        public function get realName():String
        {
            return _rawText.replace(/[_]/, " ");
        }

    }

}

