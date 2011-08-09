package robotlegs.examples.kanban.service.stub
{
    import mx.collections.ArrayCollection;

    import org.robotlegs.mvcs.Actor;

    import robotlegs.examples.kanban.model.StatusListModel;
    import robotlegs.examples.kanban.model.vo.Status;
    import robotlegs.examples.kanban.service.*;

    public class StubStatusService extends Actor implements IStatusService
    {

        private var statusListModel:StatusListModel;

        public function StubStatusService(statusListModel:StatusListModel)
        {
            this.statusListModel = statusListModel;
        }

        private function createStatuses():ArrayCollection
        {
            var statusCollection:ArrayCollection = new ArrayCollection();

            var backlogStatus:Status = new Status("Backlog");
            var doingStatus:Status = new Status("Doing");
            var doneStatus:Status = new Status("Done");

            statusCollection.addItem(backlogStatus);
            statusCollection.addItem(doingStatus);
            statusCollection.addItem(doneStatus);

            return statusCollection;
        }

        public function loadStatuses():void
        {
            //updating the model directly is something that I don't really have a problem with
            //in general, but I know some prefer a looser coupling via the event->command cycle
            //in this case we are really concerned when the model is updated. It is where the event
            //is dispatched from. If you did it here, you get command explosion.
            statusListModel.statuses = createStatuses();
        }
    }
}