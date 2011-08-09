package robotlegs.examples.kanban.model.vo
{
    [Bindable]
    public class Task
    {
        public function Task(name:String = "")
        {
            this.name = name;
        }

        public var taskId:int;
        public var name:String;
        public var description:String;
        public var statusId:int;

        private var _status:Status;

        public function get status():Status
        {
            return _status;
        }

        public function set status(value:Status):void
        {
            _status = value;
            statusId = status.statusId;
        }

        public function update(task:Task):Task
        {
            taskId = task.taskId;
            name = task.name;
            description = task.description;
            statusId = task.statusId;

            return this;
        }

        public function toParamObject():Object
        {
            var params:Object = new Object();
            params["taskId"] = taskId > 0 ? taskId : null;
            params["name"] = name;
            params["statusId"] = statusId > 0 ? statusId : 1;
            params["description"] = description;

            return params;
        }
    }
}