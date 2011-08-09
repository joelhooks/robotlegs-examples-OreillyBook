package mosaic.view.ui
{
    import flash.display.Sprite;
    import flash.geom.ColorTransform;

    public class Workspace extends Sprite
    {

        public function Workspace(drawWidth:Number, drawHeight:Number)
        {
            init(drawWidth, drawHeight);
        }

        public function set color(workspaceColor:uint):void
        {
            var changedColor:ColorTransform = new ColorTransform();
            changedColor.color = workspaceColor;
            transform.colorTransform = changedColor;
        }

        protected function init(drawWidth:Number, drawHeight:Number):void
        {
            graphics.beginFill(0x000000);
            graphics.drawRect(0, 0, drawWidth, drawHeight);
        }

    }
}