public with sharing class Log {
    
    private static final String STANDARD_EXCEPTION_LOG_STRING_FORMAT = 'Exception: [{0}] {1} \n Stack Trace: {2}';
    private static final String STANDARD_INFO_LOG_STRING_FORMAT = 'INFO: [{0}] {1} \n Stack Trace: {2}';
    private static final String BATCH_EXCEPTION_LOG_STRING_FORMAT = 'Failed in Phase: {0} - Exception: [{1}] \n Stack Trace: {2}';
    private static final String BATCH_INFO_LOG_STRING_FORMAT = 'INFO: {0} - Exception: [{1}] \n Stack Trace: {2}';
    private static final String FLOW_EXCEPTION_LOG_STRING_FORMAT = 'FLOW EXCEPTION: \n Stack Trace: {0}';
    private static final String FLOW_INFO_LOG_STRING_FORMAT = 'FLOW INFO: \n {0}';

    private static final String SYSTEM_STRING = 'System.';


    private enum LogSeverity {
        INFO,
        ERROR
    }

    public Log(){
        this.records = new List<Log__c>();
    }

    List<Log__c> records { get; private set; }

    public Log createLog(BatchApexErrorEvent ex, Id recordTypeId) {

        AsyncApexJob jobDetails = getAsyncApexJob(new Set<Id>{ex.AsyncApexJobId});

        this.records.add( new Log__c(
            Stack_Trace__c = ex.StackTrace,
            Batch_Job_ID__c = ex.AsyncApexJobId,
            Exception_Type__c = ex.ExceptionType.remove(SYSTEM_STRING),
            Batch_Phase__c = ex.Phase,
            Records_In_Scope__c	= ex.JobScope,
            Log_Data__c = String.format(BATCH_EXCEPTION_LOG_STRING_FORMAT, new List<String>{ex.Phase,ex.ExceptionType ,ex.StackTrace}),
            RecordTypeId = RecordTypeId,
            Job_Type__c = jobDetails.JobType,
            Severity__c = Log.LogSeverity.ERROR.name(),
            Running_User__c = UserInfo.getUserId()
        ));
        return this;
    }

    public Log createLog(Exception ex, Id recordTypeId){
        this.records.add( new Log__c(
            Severity__c = Log.LogSeverity.ERROR.name(),
            Log_Data__c = String.format(STANDARD_EXCEPTION_LOG_STRING_FORMAT, new List<String>{ex.getTypeName() ,ex.getMessage(),ex.getStackTraceString()}),
            Stack_Trace__c = ex.getStackTraceString(),
            RecordTypeId = RecordTypeId,
            Running_User__c = UserInfo.getUserId(),
            Exception_Type__c = ex.getTypeName().remove(SYSTEM_STRING)
        ));
        return this;
    }

    public Log createFlowLog(String message, Id recordTypeId,Boolean isException) {
        Log__c newLogRecord = new Log__c(
            RecordTypeId = RecordTypeId,
            Running_User__c = UserInfo.getUserId()
        );

        if(isException){
            newLogRecord.Severity__c = Log.LogSeverity.ERROR.name();
            newLogRecord.Log_Data__c = String.format(FLOW_EXCEPTION_LOG_STRING_FORMAT,new List<String>{message});
        }
        else{
            newLogRecord.Severity__c =  Log.LogSeverity.INFO.name();
            newLogRecord.Log_Data__c = String.format(FLOW_INFO_LOG_STRING_FORMAT,new List<String>{message});
        }
        this.records.add(newLogRecord);
        return this;
    }

    public List<Log__c> getRecords(){
        return this.records;
    }

    public static AsyncApexJob getAsyncApexJob(Set<Id> ids){
        AsyncApexJob job = [SELECT Id, JobType,Status,CompletedDate,MethodName,CreatedDate,JobItemsProcessed,ApexClass.Name,NumberOfErrors,TotalJobItems FROM AsyncApexJob WHERE Id = :ids LIMIT 1];
        return job;
    }

}
