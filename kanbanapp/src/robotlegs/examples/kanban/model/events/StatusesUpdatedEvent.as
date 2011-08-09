package robotlegs.examples.kanban.model.events
{
    import flash.events.Event;

    import mx.collections.ArrayCollection;

    public class StatusesUpdatedEvent extends Event
    {
        public static const UPDATED:String = "StatusesUpdatedEvent";

        private var _statuses:ArrayCollection;

        public function get statuses():ArrayCollection
        {
            return _statuses;
        }

        public function StatusesUpdatedEvent(statuses:ArrayCollection)
        {
            super(UPDATED);

            _statuses = statuses;
        }

        override public function clone():Event
        {
            return new StatusesUpdatedEvent(statuses);
        }
    }
}