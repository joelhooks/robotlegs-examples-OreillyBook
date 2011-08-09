package robotlegs.examples.kanban.view
{
    import org.robotlegs.mvcs.Mediator;

    import robotlegs.examples.kanban.controller.events.SaveTaskEvent;

    public class TaskEntryBarMediator extends Mediator
    {
        override public function onRegister():void
        {
            addViewListener(SaveTaskEvent.SAVE, dispatch);
        }
    }
}