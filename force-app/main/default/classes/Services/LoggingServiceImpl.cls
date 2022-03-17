public with sharing class LoggingServiceImpl implements ILoggingService {

    public final String TYPE_EXCEPTION_MESSAGE = '[Invalid Type] We dont take kindly to your type around here! (You should call another method)';

    LogUtils utils;

    public LoggingServiceImpl(){
        this.utils = LogUtils.getInstance();
    }

    public class NotImplementedException extends Exception{}

    public void generateExceptionLog(Exception record){
        Log newLog = new Log();
        
        newLog.createExceptionLog(record,utils.getQuiddityBasedRecordTypeId(Request.getCurrent().getQuiddity()));
        insert newLog.getRecords();
    } 

    public void generateExceptionLogs(List<Exception> records){
        throw new NotImplementedException();
    } 

    public void generateLogs(List<String> messages){
        throw new NotImplementedException();
    }

    public void generateLog(String message){
        throw new NotImplementedException();
    }

    public void generateInvocableLog(String message,Boolean isException){

        if(utils.invocableQuiddities.contains(Request.getCurrent().getQuiddity().name())){
            Log newLog = new Log();

            newLog.createLog(message,utils.getQuiddityBasedRecordTypeId(Request.getCurrent().getQuiddity()),isException);
            insert newLog.getRecords();
        }else{
            throw new LoggingService.LoggingServiceTypeException(TYPE_EXCEPTION_MESSAGE);
        }

    }

    public void generateBatchExceptionLog(BatchApexErrorEvent batchErrorEvent){
        Log newLog = new Log();
        newLog.createBatchExceptionLog(batchErrorEvent, utils.getBatchLogRecordTypeId());
        
        insert newLog.getRecords();
    }

    public void generateBatchExceptionLogs(List<BatchApexErrorEvent> batchErrorEvents){
        Log newLog = new Log();

        for(BatchApexErrorEvent bex : batchErrorEvents){
            newLog.createBatchExceptionLog(bex, utils.getBatchLogRecordTypeId());
        }
        
        insert newLog.getRecords();
    }

    public void generateBatchLog(String message){

        if(utils.asyncQuiddities.contains(Request.getCurrent().getQuiddity().name())){
            Log newLog = new Log();

            newLog.createLog(message,utils.getBatchLogRecordTypeId(),false);
            
            insert newLog.getRecords();
        }else{
            throw new LoggingService.LoggingServiceTypeException(TYPE_EXCEPTION_MESSAGE);
        }
    }

    public void generateBatchLogs(List<String> messages){
        throw new NotImplementedException();
    }
}
