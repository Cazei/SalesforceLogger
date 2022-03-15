trigger BatchApexErrorEventTrigger on BatchApexErrorEvent (After insert) {

    System.debug('ERROR EVENT THROWN!');
    System.debug(JSON.serializePretty(trigger.newMap));

    List<Batch_Log__c> eventList = new List<Batch_Log__c>();
    for(BatchApexErrorEvent e : trigger.new){
        Batch_Log__c log = new Batch_Log__c();

        log.Error_Message__c = e.Message;
        log.Stack_Trace__c = e.StackTrace;
        eventList.add(log);
    }
    
    insert  eventList;
}