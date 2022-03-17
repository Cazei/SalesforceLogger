public with sharing class LogUtils {
    
    private final String BATCH_LOG_RECORD_TYPE = 'Batch Log';
    private final String STANDARD_LOG_RECORD_TYPE = 'Standard Log';
    private final String INVOCABLE_LOG_RECORD_TYPE = 'Invocable Log';

    private final String ANONYMOUS = 'ANONYMOUS ';
    private final String AURA = 'AURA';
    private final String BATCH_ACS = 'BATCH_ACS';
    private final String BATCH_APEX = 'BATCH_APEX';
    private final String BATCH_CHUNK_PARALLEL = 'BATCH_CHUNK_PARALLEL';
    private final String BATCH_CHUNK_SERIAL = 'BATCH_CHUNK_SERIAL';
    private final String BULK_API = 'BULK_API';
    private final String COMMERCE_INTEGRATION = 'COMMERCE_INTEGRATION';
    private final String DISCOVERABLE_LOGIN = 'DISCOVERABLE_LOGIN';
    private final String FUNCTION_CALLBACK = 'FUNCTION_CALLBACK';
    private final String FUTURE = 'FUTURE';
    private final String INBOUND_EMAIL_SERVICE = 'INBOUND_EMAIL_SERVICE';
    private final String INVOCABLE_ACTION = 'INVOCABLE_ACTION';
    private final String IOT = 'IOT';
    private final String POST_INSTALL_SCRIPT = 'POST_INSTALL_SCRIPT';
    private final String QUEUEABLE = 'QUEUEABLE';
    private final String QUICK_ACTION = 'QUICK_ACTION';
    private final String REMOTE_ACTION = 'REMOTE_ACTION';
    private final String REST = 'REST';
    private final String RUNTEST_ASYNC = 'RUNTEST_ASYNC';
    private final String RUNTEST_DEPLOY = 'RUNTEST_DEPLOY';
    private final String RUNTEST_SYNC = 'RUNTEST_SYNC';
    private final String SCHEDULED = 'SCHEDULED';
    private final String SOAP = 'SOAP';
    private final String SYNCHRONOUS = 'SYNCHRONOUS';
    private final String TRANSACTION_FINALIZER_QUEUEABLE = 'TRANSACTION_FINALIZER_QUEUEABLE';
    private final String VF = 'VF';

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

    public Id getQuiddityBasedRecordTypeId(Quiddity quiddity){

        if(quiddity == null){
            throw new LogUtilsException('Null Quiddity was passed to LogUtils.getQuiddityBasedRecordTypeId');
        }else if(asyncQuiddities.contains(quiddity.name())) {

            return getBatchLogRecordTypeId();

        }else if(invocableQuiddities.contains(quiddity.name())){
        
            if(this.FlowLogRecordTypeId == null){
                this.FlowLogRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(INVOCABLE_LOG_RECORD_TYPE).getRecordTypeId();
            } 
            return this.FlowLogRecordTypeId;

        }else{
            if(this.standardRecordTypeId == null){
                this.standardRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(STANDARD_LOG_RECORD_TYPE).getRecordTypeId();
            } 
            return this.standardRecordTypeId;
        }
    }

    public Id getBatchLogRecordTypeId(){
        if(this.batchLogRecordTypeId == null){
            this.batchLogRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName().get(BATCH_LOG_RECORD_TYPE).getRecordTypeId();
        } 
        return this.batchLogRecordTypeId;
    }
}