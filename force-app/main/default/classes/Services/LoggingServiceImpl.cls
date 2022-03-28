public with sharing class LoggingServiceImpl implements ILoggingService {

    public final String TYPE_EXCEPTION_MESSAGE = '[Invalid Type] We dont take kindly to your type around here! This method cannot be called from your current context';


    public final String FLOW_EXCEPTION_TYPE = 'FlowException';

    LogUtils utils;
    Quiddity quiddityContext;

    public LoggingServiceImpl(){
        this.utils = LogUtils.getInstance();
        this.quiddityContext = Request.getCurrent().getQuiddity();
    }

    public class NotImplementedException extends Exception{}

    public void generateLog(Exception record){

        Log newLog = new Log();
        
        newLog.createLog(record,utils.getStandardLogRecordTypeId());
        insert newLog.getRecords();
    } 

    public void generateLog(BatchApexErrorEvent batchErrorEvent){
        Log newLog = new Log();
        newLog.createLog(batchErrorEvent, utils.getBatchLogRecordTypeId());
        
        insert newLog.getRecords();
    }

    public void generateLog(String message,Boolean isException){

        Log newLog = new Log();
        newLog.createLog(message, utils.getStandardLogRecordTypeId(), isException);  

        if(utils.invocableQuiddities.contains(quiddityContext.name())){
            newLog.getRecords()[0].Exception_Type__c = FLOW_EXCEPTION_TYPE;
        }
        insert newLog.getRecords();
    }

    public void generateLogs(List<String> messages,Boolean isException){

        Log newLogs = new Log();
        for(String message : messages){
            newLogs.createLog(message, utils.getStandardLogRecordTypeId(), isException);
        }
        insert newLogs.getRecords();
    }

    public void generateLogs(List<BatchApexErrorEvent> batchErrorEvents){
        Log newLogs = new Log();

        for(BatchApexErrorEvent bex : batchErrorEvents){
            newLogs.createLog(bex, utils.getBatchLogRecordTypeId());
        }
        insert newLogs.getRecords();
    }

    public void generateLogs(List<Exception> exceptionRecords){

        Log newLog = new Log();
        
        for(Exception ex : exceptionRecords){
            newLog.createLog(ex,utils.getStandardLogRecordTypeId());
        }
        insert newLog.getRecords();
    } 

}
