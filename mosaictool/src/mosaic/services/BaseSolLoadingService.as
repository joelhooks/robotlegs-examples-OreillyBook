package mosaic.services
{
    import flash.net.SharedObject;

    import mosaic.model.utils.FileNameFixer;

    import org.robotlegs.mvcs.Actor;

    public class BaseSolLoadingService extends Actor
    {
        protected var _requiredPropertyName:String;

        protected function loadSolData(solName:String):void
        {
            var loadedData:Object = getSolData(solName);
            if (loadedData == null)
            {
                dispatchNotFound(solName);
            }
            else
            {
                processData(loadedData, solName);
            }
        }

        protected function getSolData(solName:String):Object
        {
            var solFileName:String = new FileNameFixer(solName).fileName;
            var sol:SharedObject = SharedObject.getLocal(solFileName);
            var dataOnSol:Object = sol.data;

            if (!dataOnSol.hasOwnProperty(_requiredPropertyName))
            {
                return null;
            }

            return sol.data;
        }

        protected function processData(data:Object, solName:String):void
        {
            if (updateModel(data))
            {
                dispatchLoadCompleted(solName);
            }
            else
            {
                dispatchLoadFailed(solName);
            }
        }

        // abstract methods to be overridden
        protected function updateModel(data:Object):Boolean { return false; }

        protected function dispatchNotFound(solName:String):void { }

        ;
        protected function dispatchLoadCompleted(solName:String):void { }

        ;
        protected function dispatchLoadFailed(solName:String):void { }
    }
}