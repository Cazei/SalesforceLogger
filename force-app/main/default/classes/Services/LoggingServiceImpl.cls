public with sharing class LoggingServiceImpl implements ILoggingService {

    public final String TYPE_EXCEPTION_MESSAGE = '[Invalid Type] We dont take kindly to your type around here! (You should call another method)';

    LogUtils utils;
    Quiddity quiddityContext;

    public LoggingServiceImpl(){
        this.utils = LogUtils.getInstance();
        this.quiddityContext = Request.getCurrent().getQuiddity();
    }

    public class NotImplementedException extends Exception{}

    public void generateLog(Exception record){

        system.debug(quiddityContext);
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
        insert newLog.getRecords();
    }

    public void generateInvocableLog(String message,Boolean isException){

        if(utils.invocableQuiddities.contains(quiddityContext.name())){
            Log newLog = new Log();

            newLog.createLog(message,utils.getStandardLogRecordTypeId(),isException);
            insert newLog.getRecords();
        }else{
            throw new LoggingService.LoggingServiceTypeException(TYPE_EXCEPTION_MESSAGE);
        }
    }

    public void generateLogs(List<String> messages,Boolean isException){

        Log newLogs = new Log();
        for(String message : messages){
            newLogs.createLog(message, utils.getStandardLogRecordTypeId(), isException);
        }
    }

    public void generateLogs(List<BatchApexErrorEvent> batchErrorEvents){
        Log newLogs = new Log();
        System.debug(utils.getBatchLogRecordTypeId());

        for(BatchApexErrorEvent bex : batchErrorEvents){
            System.debug(JSON.serializePretty(bex));
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
