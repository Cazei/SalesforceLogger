public with sharing class LogUtils {
    
    private static final String BATCH_LOG_RECORD_TYPE = 'Batch Log';
    private static final String STANDARD_LOG_RECORD_TYPE = 'Standard Log';
    private static final String FLOW_LOG_RECORD_TYPE = 'FlowLog';

    private static final String ANONYMOUS = 'ANONYMOUS ';
    private static final String AURA = 'AURA';
    private static final String BATCH_ACS = 'BATCH_ACS';
    private static final String BATCH_APEX = 'BATCH_APEX';
    private static final String BATCH_CHUNK_PARALLEL = 'BATCH_CHUNK_PARALLEL';
    private static final String BATCH_CHUNK_SERIAL = 'BATCH_CHUNK_SERIAL';
    private static final String BULK_API = 'BULK_API';
    private static final String COMMERCE_INTEGRATION = 'COMMERCE_INTEGRATION';
    private static final String DISCOVERABLE_LOGIN = 'DISCOVERABLE_LOGIN';
    private static final String FUNCTION_CALLBACK = 'FUNCTION_CALLBACK';
    private static final String FUTURE = 'FUTURE';
    private static final String INBOUND_EMAIL_SERVICE = 'INBOUND_EMAIL_SERVICE';
    private static final String INVOCABLE_ACTION = 'INVOCABLE_ACTION';
    private static final String IOT = 'IOT';
    private static final String POST_INSTALL_SCRIPT = 'POST_INSTALL_SCRIPT';
    private static final String QUEUEABLE = 'QUEUEABLE';
    private static final String QUICK_ACTION = 'QUICK_ACTION';
    private static final String REMOTE_ACTION = 'REMOTE_ACTION';
    private static final String REST = 'REST';
    private static final String RUNTEST_ASYNC = 'RUNTEST_ASYNC';
    private static final String RUNTEST_DEPLOY = 'RUNTEST_DEPLOY';
    private static final String RUNTEST_SYNC = 'RUNTEST_SYNC';
    private static final String SCHEDULED = 'SCHEDULED';
    private static final String SOAP = 'SOAP';
    private static final String SYNCHRONOUS = 'SYNCHRONOUS';
    private static final String TRANSACTION_FINALIZER_QUEUEABLE = 'TRANSACTION_FINALIZER_QUEUEABLE';
    private static final String VF = 'VF';

    private static Set<String> asyncQuiddities  = new Set<String>{
        BATCH_ACS,BATCH_ACS,BATCH_APEX,BATCH_CHUNK_PARALLEL,BATCH_CHUNK_SERIAL,BULK_API,QUEUEABLE,SCHEDULED,FUTURE
    };

    private static Set<String> calloutQuiddities = new Set<String>{
        SOAP,REST
    };

    private static Set<String> testQuiddities = new Set<String>{
        RUNTEST_ASYNC,RUNTEST_DEPLOY,RUNTEST_SYNC
    };

    private static Set<String> frontEndQuiddities = new Set<String>{
        AURA, VF
    };

    private static Set<String> invocableQuiddities = new Set<String>{
        INVOCABLE_ACTION
    };

    public class LogUtilsException extends exception{}

    private static LogUtils utils { get; private set; }

    String batchLogRecordTypeId;
    String standardRecordTypeId;
    String FlowLogRecordTypeId;

    public LogUtils(){
        //Currently we only need to fetch this on instantiation... I think.
        this.batchLogRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(BATCH_LOG_RECORD_TYPE).getRecordTypeId();
    }
    
    public static LogUtils getInstance(){
        if(utils == null){
            utils = new LogUtils();
        }
        return utils;
    }

    public Id getQuiddityBasedRecordTypeId(String quiddity){

        if(quiddity == null){
            throw new LogUtilsException('Null Quiddity was passed to LogUtils.getQuiddityBasedRecordTypeId');
        }else if(asyncQuiddities.contains(quiddity)) {

            if(this.batchLogRecordTypeId == null){
                this.batchLogRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(BATCH_LOG_RECORD_TYPE).getRecordTypeId();
            } 
            return this.batchLogRecordTypeId;

        }else if(invocableQuiddities.contains(quiddity)){
            
            if(this.FlowLogRecordTypeId == null){
                this.FlowLogRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(FLOW_LOG_RECORD_TYPE).getRecordTypeId();
            } 
            return this.batchLogRecordTypeId;

        }else{

            if(this.standardRecordTypeId == null){
                this.standardRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(STANDARD_LOG_RECORD_TYPE).getRecordTypeId();
            } 
            return this.standardRecordTypeId;

        }
    }

    public Id getBatchLogRecordTypeId(){
        return this.batchLogRecordTypeId;
    }
}