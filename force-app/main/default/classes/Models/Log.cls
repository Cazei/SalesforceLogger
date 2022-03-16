public with sharing class Log {
    
    private static final String STANDARD_EXCEPTION_LOG_STRING_FORMAT = 'Exception: [{0}] {1} \n Stack Trace: {2}';
    private static final String STANDARD_INFO_LOG_STRING_FORMAT = 'INFO: [{0}] {1} \n Stack Trace: {2}';
    private static final String BATCH_EXCEPTION_LOG_STRING_FORMAT = 'Failed in Phase: {0} - Exception: [{1}] \n Stack Trace: {2}';
    private static final String BATCH_INFO_LOG_STRING_FORMAT = 'INFO: {0} - Exception: [{1}] \n Stack Trace: {2}';
    private static final String FLOW_EXCEPTION_LOG_STRING_FORMAT = 'FLOW EXCEPTION: \n Stack Trace: {0}';
    private static final String FLOW_INFO_LOG_STRING_FORMAT = 'FLOW INFO: \n {0}';


    private enum LogSeverity {
        DEBUG,
        WARN,
        INFO,
        ERROR
    }

    LogUtils utils;

    public Log(){
        this.utils = LogUtils.getInstance(); 
    }

    List<Log__c> records { get; private set; }

    public Quiddity quiddity { get {
        if(quiddity == null){
            quiddity = Request.getCurrent().getQuiddity();
        }
        return quiddity;
        } 
        set; 
    }

    public Log createBatchExceptionLog(BatchApexErrorEvent ex, Id recordTypeId) {

        AsyncApexJob jobDetails = LogServiceSelectors.getAsyncApexJob(new Set<Id>{ex.AsyncApexJobId});

        this.records.add( new Log__c(
            Stack_Trace__c = ex.StackTrace,
            Batch_Job_ID__c = ex.AsyncApexJobId,
            Exception_Type__c = ex.ExceptionType,
            Batch_Phase__c = ex.Phase,
            Records_In_Scope__c	= ex.JobScope,
            Log_Data__c = String.format(BATCH_EXCEPTION_LOG_STRING_FORMAT, new List<String>{ex.Phase,ex.ExceptionType ,ex.StackTrace}),
            RecordTypeId = RecordTypeId,
            Context__c = jobDetails.JobType,
            Severity__c = Log.LogSeverity.ERROR.name()
        ));
        return this;
    }

    public Log createExceptionLog(Exception ex, Id recordTypeId){
        this.records.add(  new Log__c(
            Context__c = this.quiddity?.name(),
            Severity__c = Log.LogSeverity.ERROR.name(),
            Log_Data__c = String.format(STANDARD_EXCEPTION_LOG_STRING_FORMAT, new List<String>{ex.getTypeName() ,ex.getMessage(),ex.getStackTraceString()}),
            Stack_Trace__c = ex.getStackTraceString(),
            RecordTypeId = RecordTypeId,
            Running_User__c = UserInfo.getUserId(),
            Exception_Type__c = ex.getTypeName()
        ));
        return this;
    }

    public Log createLog(String message, Id recordTypeId,Boolean isException) {

        Log__c newLogRecord = new Log__c(
            RecordTypeId = RecordTypeId,
            Context__c = this.quiddity?.name()
        );

        if(isException){
            newLogRecord.Severity__c = Log.LogSeverity.ERROR.name();
            if(utils.invocableQuiddities.contains(quiddity?.name())){
                newLogRecord.Log_Data__c = String.format(FLOW_EXCEPTION_LOG_STRING_FORMAT,new List<String>{message});
            }
        }
        else{
            newLogRecord.Severity__c =  Log.LogSeverity.INFO.name();

            if(utils.invocableQuiddities.contains(quiddity?.name())){
                newLogRecord.Log_Data__c = String.format(FLOW_INFO_LOG_STRING_FORMAT,new List<String>{message});
            }else{
                newLogRecord.Log_Data__c = String.format(STANDARD_INFO_LOG_STRING_FORMAT,new List<String>{message});
            }
        }
        this.records.add(newLogRecord);
        return this;
    }

    public List<Log__c> getRecords(){
        return this.records;
    }

}
