public with sharing class BatchApexErrorEventTriggerHandler  {

    List<BatchApexErrorEvent> incomingRecords = new List<BatchApexErrorEvent>();

    public BatchApexErrorEventTriggerHandler(){
        this.incomingRecords = (List<BatchApexErrorEvent>)  Trigger.new;
    }

    public BatchApexErrorEventTriggerHandler run(){

        if(Trigger.isInsert){
            if(Trigger.isAfter){
                afterInsert();
            }
        }
        return this;
    }

    public void afterInsert(){
        handleIncomingErrorEvents();
    }

    private void handleIncomingErrorEvents(){
        Logger.generateLogs(this.incomingRecords);
    }
}