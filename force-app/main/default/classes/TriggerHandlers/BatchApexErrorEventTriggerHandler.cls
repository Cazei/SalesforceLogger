public with sharing class BatchApexErrorEventTriggerHandler  {

    List<BatchApexErrorEvent> incomingRecords = new List<BatchApexErrorEvent>();
    LogUtils utils;

    public BatchApexErrorEventTriggerHandler(){
        this.utils = LogUtils.getInstance();
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
        LoggingService.generateBatchExceptionLogs(this.incomingRecords);
    }
}
