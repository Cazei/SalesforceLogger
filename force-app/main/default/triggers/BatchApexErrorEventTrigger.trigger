trigger BatchApexErrorEventTrigger on BatchApexErrorEvent (after insert) {

    for(BatchApexErrorEvent e : Trigger.new){
        System.debug('Batch error trigger!');
    }

    new BatchApexErrorEventTriggerHandler().run(); 

}