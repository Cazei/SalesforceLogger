public with sharing class Logger {

    public static final String BATCH_LOG_RECORD_TYPE = 'Async Log';
    public static final String STANDARD_LOG_RECORD_TYPE = 'Standard Log';

    public static final String FLOW_EXCEPTION_TYPE = 'FlowException';

    public static String batchLogRecordTypeId;
    public static String standardRecordTypeId;

    public static void generateLog(Exception record){

        Log newLog = new Log();
        
        newLog.createLog(record, getStandardLogRecordTypeId());
        insert newLog.getRecords();
    } 

    public static void generateLogs(List<Exception> exceptionRecords){

        Log newLog = new Log();
        
        for(Exception ex : exceptionRecords){
            newLog.createLog(ex, getStandardLogRecordTypeId());
        }
        insert newLog.getRecords();
    } 

    public static void generateLogs(List<BatchApexErrorEvent> batchErrorEvents){
        Log newLogs = new Log();

        for(BatchApexErrorEvent bex : batchErrorEvents){
            newLogs.createLog(bex, getBatchLogRecordTypeId());
        }
        insert newLogs.getRecords();
    }

    public static void generateFlowLog(String message,Boolean isException){

        Log newLog = new Log();
        newLog.createFlowLog(message, getStandardLogRecordTypeId(), isException);  
        newLog.getRecords()[0].Exception_Type__c = FLOW_EXCEPTION_TYPE;
        
        insert newLog.getRecords();
    }

    public static Id getStandardLogRecordTypeId(){
        if(standardRecordTypeId == null){
            standardRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(STANDARD_LOG_RECORD_TYPE).getRecordTypeId();
        } 
        return standardRecordTypeId;
    }

    public static Id getBatchLogRecordTypeId(){
        if(batchLogRecordTypeId == null){
            batchLogRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(BATCH_LOG_RECORD_TYPE).getRecordTypeId();
        } 
        return batchLogRecordTypeId;
    }

}
