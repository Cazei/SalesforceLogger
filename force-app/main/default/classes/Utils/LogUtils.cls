public with sharing class LogUtils {
    
    public final String BATCH_LOG_RECORD_TYPE = 'Async Log';
    public final String STANDARD_LOG_RECORD_TYPE = 'Standard Log';
    public final String INVOCABLE_LOG_RECORD_TYPE = 'Invocable Log';

    public final String ANONYMOUS = 'ANONYMOUS ';
    public final String AURA = 'AURA';
    public final String BATCH_ACS = 'BATCH_ACS';
    public final String BATCH_APEX = 'BATCH_APEX';
    public final String BATCH_CHUNK_PARALLEL = 'BATCH_CHUNK_PARALLEL';
    public final String BATCH_CHUNK_SERIAL = 'BATCH_CHUNK_SERIAL';
    public final String BULK_API = 'BULK_API';
    public final String COMMERCE_INTEGRATION = 'COMMERCE_INTEGRATION';
    public final String DISCOVERABLE_LOGIN = 'DISCOVERABLE_LOGIN';
    public final String FUNCTION_CALLBACK = 'FUNCTION_CALLBACK';
    public final String FUTURE = 'FUTURE';
    public final String INBOUND_EMAIL_SERVICE = 'INBOUND_EMAIL_SERVICE';
    public final String INVOCABLE_ACTION = 'INVOCABLE_ACTION';
    public final String IOT = 'IOT';
    public final String POST_INSTALL_SCRIPT = 'POST_INSTALL_SCRIPT';
    public final String QUEUEABLE = 'QUEUEABLE';
    public final String QUICK_ACTION = 'QUICK_ACTION';
    public final String REMOTE_ACTION = 'REMOTE_ACTION';
    public final String REST = 'REST';
    public final String RUNTEST_ASYNC = 'RUNTEST_ASYNC';
    public final String RUNTEST_DEPLOY = 'RUNTEST_DEPLOY';
    public final String RUNTEST_SYNC = 'RUNTEST_SYNC';
    public final String SCHEDULED = 'SCHEDULED';
    public final String SOAP = 'SOAP';
    public final String SYNCHRONOUS = 'SYNCHRONOUS';
    public final String TRANSACTION_FINALIZER_QUEUEABLE = 'TRANSACTION_FINALIZER_QUEUEABLE';
    public final String VF = 'VF';

    public Set<String> asyncQuiddities  = new Set<String>{
        BATCH_ACS,BATCH_ACS,BATCH_APEX,BATCH_CHUNK_PARALLEL,BATCH_CHUNK_SERIAL,BULK_API,QUEUEABLE,SCHEDULED,FUTURE
    };

    public Set<String> calloutQuiddities = new Set<String>{
        SOAP,REST
    };

    public Set<String> testQuiddities = new Set<String>{
        RUNTEST_ASYNC,RUNTEST_DEPLOY,RUNTEST_SYNC
    };

    public Set<String> frontEndQuiddities = new Set<String>{
        AURA, VF
    };

    public Set<String> invocableQuiddities = new Set<String>{
        INVOCABLE_ACTION
    };

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