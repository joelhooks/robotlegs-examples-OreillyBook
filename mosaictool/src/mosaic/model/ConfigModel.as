package mosaic.model
{
    import mosaic.controller.events.ConfigChangedEvent;
    import mosaic.controller.events.DesignListEvent;

    import org.robotlegs.mvcs.Actor;

    public class ConfigModel extends Actor implements IConfigModel
    {
        protected var _designNamesList:DesignNamesList;
        protected var _workspaceColor:uint;

        public function get designNames():Vector.<String>
        {
            if (_designNamesList && _designNamesList.designNames)
            {
                return _designNamesList.designNames;
            }
            return new Vector.<String>();
        }

        public function set designNames(names:Vector.<String>):void
        {
            _designNamesList = new DesignNamesList(names);
            dispatchDesignListChange();
        }

        public function get hasDesign():Boolean
        {
            return (_designNamesList && _designNamesList.hasItems);
        }

        public function get currentDesign():String
        {
            return _designNamesList.selectedItem;
        }

        public function set currentDesign(designName:String):void
        {
            if (hasDesign && currentDesign == designName) return;

            if (_designNamesList.selectAndAddIfNeeded(designName))
            {
                dispatchDesignListChange();
            }
            dispatchChange();
        }

        public function get workspaceColor():uint
        {
            return _workspaceColor;
        }

        public function set workspaceColor(color:uint):void
        {
            if (_workspaceColor != color)
            {
                _workspaceColor = color;
                dispatchChange();
            }
        }

        protected function dispatchChange():void
        {
            dispatch(new ConfigChangedEvent(ConfigChangedEvent.CHANGED));
        }

        protected function dispatchDesignListChange():void
        {
            dispatch(new DesignListEvent(DesignListEvent.CHANGED, designNames));
        }
    }
}