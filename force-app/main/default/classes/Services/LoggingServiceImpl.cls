public with sharing class LoggingServiceImpl implements ILoggingService {

    LogUtils utils;

    public LogginServiceImpl(){
        this.utils = LogUtils.getInstance();
    }

    public class NotImplementedException extends Exception{}
    

    public static void generateExceptionLog(Exception record){
        throw new NotImplementedException();
    } 


    public static void generateExceptionLogs(List<Exception> records){
        throw new NotImplementedException();
    } 

 
    public static void generateLogs(List<String> messages){
        throw new NotImplementedException();
    }


    public static void generateLog(String message){
        throw new NotImplementedException();
    }


    public static void generateBatchExceptionLogs(List<BatchApexErrorEvent> records){
        throw new NotImplementedException();
    }


    public static void generateBatchExceptionLog(String record){
        throw new NotImplementedException();
    }


    public static void genetateBatchLogs(List<String> records){
        throw new NotImplementedException();
    }

 
    public static void genetateBatchLog(BatchApexErrorEvent record){

        Log__c log = new Log__c(record,utils.getBatchLogRecordTypeId());
        
        insert log;

    }

    public void generateBatchExceptionLogs(List<BatchApexErrorEvent> batchErrorEvents){
        List<Log__c> logList = new List<Log__c>();
        
        for(BatchApexErrorEvent batchError : batchErrorEvents){
            logList.add(new Log__c(batchError,utils.getBatchLogRecordTypeId()));
        }

       insert logList;
    }
}
