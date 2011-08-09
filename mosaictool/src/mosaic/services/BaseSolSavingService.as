package mosaic.services
{
    import flash.net.SharedObject;

    import mosaic.model.utils.FileNameFixer;

    import org.robotlegs.mvcs.Actor;

    public class BaseSolSavingService extends Actor
    {
        protected var _sol:SharedObject;

        protected function save(solName:String):void
        {
            getSol(solName);
            copyData();
            closeSol();
            dispatchCompleteEvent(solName);
        }

        protected function getSol(solName:String):void
        {
            var solFileName:String = new FileNameFixer(solName).fileName;
            _sol = SharedObject.getLocal(solFileName);
        }

        protected function copyData():void { }

        protected function closeSol():void
        {
            _sol.flush();
            _sol.close();
        }

        protected function dispatchCompleteEvent(solName:String):void { }

    }

}