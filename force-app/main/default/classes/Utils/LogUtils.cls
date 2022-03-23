public with sharing class LogUtils {
    
    public final String BATCH_LOG_RECORD_TYPE = 'Async Log';
    public final String STANDARD_LOG_RECORD_TYPE = 'Standard Log';
    public final String INVOCABLE_LOG_RECORD_TYPE = 'Invocable Log';

    public class LogUtilsException extends exception{}

    private static LogUtils utils { get; private set; }

    String batchLogRecordTypeId {get; private set; }
    String standardRecordTypeId {get; private set; }
    String FlowLogRecordTypeId {get; private set; }

    public LogUtils(){}
    
    public static LogUtils getInstance(){
        if(utils == null){
            utils = new LogUtils();
        }
        return utils;
    }

    public Id getStandardLogRecordTypeId(){
        if(this.standardRecordTypeId == null){
            this.standardRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(STANDARD_LOG_RECORD_TYPE).getRecordTypeId();
        } 
        return this.standardRecordTypeId;
    }

    public Id getBatchLogRecordTypeId(){
        if(this.batchLogRecordTypeId == null){
            this.batchLogRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(BATCH_LOG_RECORD_TYPE).getRecordTypeId();
        } 
        return this.batchLogRecordTypeId;
    }
}