public with sharing class Log {
        
    Log__c record;

    public Log(BatchApexErrorEvent e, Id RecordTypeId) {
        System.debug('Creating new Batch Error log record');
        this.record = new Log__c(
            Stack_Trace__c = e.StackTrace,
            Batch_Job_ID__c = e.AsyncApexJobId,
            Batch_Exception_Type__c = e.ExceptionType,
            Batch_Phase__c = e.Phase,
            Records_In_Scope__c	= e.JobScope,
            Log_Data__c = e.Message,
            RecordTypeId = RecordTypeId
        );
    }

    public Log(LogEvent__e e,Id RecordTypeId){
        System.debug('Creating new standard Log record');
        this.record = new Log__c(
            Stack_Trace__c = e.Stack_Trace__c,
            Quiddity__c = e.Quiddity__c,
            Severity__c = e.Severity__c,
            RecordTypeId = RecordTypeId
        );
    }

    public Log__c getRecord(){
        return this.record;
    }


}
