public with sharing class LogTriggerHandler {


    LogUtils utils;
    List<LogEvent__e> incomingRecords = new List<LogEvent__e>();

    public LogTriggerHandler() {
        this.utils = LogUtils.getInstance();
        this.incomingRecords = (List<LogEvent__e>) Trigger.new;
    }

    public LogTriggerHandler run(){
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

    public void handleIncomingErrorEvents(){

        LoggingService.generateExceptionLogs(records);

    }
}
