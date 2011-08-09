package robotlegs.examples.kanban.service
{
    import robotlegs.examples.kanban.model.vo.Task;

    public interface ITaskService
    {
        function loadAllTasks():void;

        function loadTaskById(id:int):void;

        function save(task:Task):void;

        function deleteTask(task:Task):void
    }
}