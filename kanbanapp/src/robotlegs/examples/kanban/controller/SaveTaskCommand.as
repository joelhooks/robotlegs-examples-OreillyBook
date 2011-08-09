package robotlegs.examples.kanban.controller
{
    import robotlegs.examples.kanban.controller.events.SaveTaskEvent;
    import robotlegs.examples.kanban.service.ITaskService;

    public class SaveTaskCommand
    {
        [Inject]
        public var event:SaveTaskEvent;

        [Inject]
        public var taskService:ITaskService;

        public function execute():void
        {
            taskService.save(event.task);
        }
    }
}