trigger BatchApexErrorEventTrigger on BatchApexErrorEvent (after insert) {

    new BatchApexErrorEventTriggerHandler().run(); 

}