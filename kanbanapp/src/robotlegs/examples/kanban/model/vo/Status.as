package robotlegs.examples.kanban.model.vo
{
    import mx.collections.ArrayCollection;

    [Bindable]
    public class Status
    {
        public function Status(label:String = "")
        {
            this.label = label;
        }

        public var statusId:int;
        public var label:String;
        public var taskLimit:int;

        private var _tasks:ArrayCollection;

        public function get tasks():ArrayCollection
        {
            return _tasks ||= new ArrayCollection();
        }

        public function set tasks(value:ArrayCollection):void
        {
            _tasks = value;
        }

        public function toString():String
        {
            return label + (taskLimit > 0 ? " (" + taskLimit + ")" : "");
        }

        public function get isOverLimit():Boolean
        {
            return taskLimit != 0 && tasks.length >= taskLimit;
        }
    }
}