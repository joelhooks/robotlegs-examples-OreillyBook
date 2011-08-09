package robotlegs.examples.kanban.controller
{
    import org.robotlegs.mvcs.Command;

    import robotlegs.examples.kanban.controller.events.DeleteTaskEvent;
    import robotlegs.examples.kanban.model.StatusListModel;
    import robotlegs.examples.kanban.service.ITaskService;

    public class DeleteTaskCommand extends Command
    {
        [Inject]
        public var event:DeleteTaskEvent;

        [Inject]
        public var taskService:ITaskService;

        [Inject]
        public var statusListModel:StatusListModel;

        override public function execute():void
        {
            statusListModel.removeTaskFromAllStatuses(event.task);
            taskService.deleteTask(event.task);
        }
    }
}