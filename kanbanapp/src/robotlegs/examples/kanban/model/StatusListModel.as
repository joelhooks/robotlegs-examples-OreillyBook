package robotlegs.examples.kanban.model
{
    import mx.collections.ArrayCollection;

    import org.robotlegs.mvcs.Actor;

    import robotlegs.examples.kanban.model.events.StatusTaskLimitReachedEvent;
    import robotlegs.examples.kanban.model.events.StatusesUpdatedEvent;
    import robotlegs.examples.kanban.model.vo.Status;
    import robotlegs.examples.kanban.model.vo.Task;

    /**
     * List of statuses available to the current
     * project.
     */
    public class StatusListModel extends Actor
    {
        private var _statuses:ArrayCollection;

        public function get statuses():ArrayCollection
        {
            return _statuses ||= new ArrayCollection();
        }

        public function set statuses(value:ArrayCollection):void
        {
            _statuses = value;
            dispatch(new StatusesUpdatedEvent(statuses));
        }

        /**
         * Returns a status by its Id if it exists.
         * @param id
         * @return
         */
        public function getStatusFromId(id:int):Status
        {
            for each(var status:Status in statuses)
            {
                if (status.statusId == id)
                    return status;
            }

            return null;
        }

        /**
         * Adds a task to the tasks property of a given status while removing it from its
         * previous status.
         *
         * @param task
         * @param status
         */
        public function addTaskToStatus(task:Task, status:Status):void
        {
            if(status.isOverLimit)
            {
                dispatch(new StatusTaskLimitReachedEvent());
                return;
            }

            if (!status.tasks.contains(task))
            {
                status.tasks.addItem(task);
                if (task.status)
                    removeTaskFromStatus(task, task.status);
                task.status = status;
            }
        }

        private function removeTaskFromStatus(task:Task, status:Status):void
        {
            if (status.tasks.contains(task))
                status.tasks.removeItemAt(status.tasks.getItemIndex(task));
        }

        /**
         * removes ALL tasks from ALL statuses and clears the statuses property of all status
         * items.
         */
        public function reset():void
        {
            removeAllTasks();
            statuses.removeAll();
        }

        public function removeAllTasks():void
        {
            for each(var status:Status in statuses)
            {
                status.tasks.removeAll();
            }
        }

        public function removeTaskFromAllStatuses(task:Task):void
        {
            for each(var status:Status in statuses)
            {
                if (status.tasks.contains(task))
                    removeTaskFromStatus(task, status);
            }
        }
    }
}