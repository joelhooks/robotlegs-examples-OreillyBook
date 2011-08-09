package utils.vector
{
    public class VectorUtils extends Object
    {
        public static function removeItem(vector:*, item:*):void
        {
            var asVector:Vector.<*> = Vector.<*>(vector);

            var itemIndex:int = asVector.indexOf(item);
            if (itemIndex >= 0)
            {
                asVector.splice(itemIndex, 1);
            }
        }
    }
}