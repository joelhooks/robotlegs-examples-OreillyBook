package robotlegs.examples.kanban.controller
{
    import org.robotlegs.mvcs.Command;

    import robotlegs.examples.kanban.service.ITaskService;

    public class LoadTasksCommand extends Command
    {
        [Inject]
        public var taskService:ITaskService;

        override public function execute():void
        {
            taskService.loadAllTasks();
        }
    }
}