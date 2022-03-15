public with sharing class BatchMonitorServiceImpl implements IBatchMonitorService {
    

    private Batch_Log__c logRecord;
    private AsyncApexJob jobRecord;


    public void startBatchMonitoring(Database.BatchableContext bc,String soqlScope){
        BatchLog log = new BatchLog(getApexJobDetails(bc));
        log.generateDefaultBatchLog(soqlScope);
        insert log.record;
    }

    public void logException(Database.BatchableContext bc,Exception ex){
        fetchJobAndLogRecords(bc);
        BatchLog log = new BatchLog(this.logRecord,this.jobRecord);
        log.setExceptionValues(ex);
        Database.SaveResult results = Database.update(log.record);

    }

    public void logException(Database.BatchableContext bc,DMLException ex){
        fetchJobAndLogRecords(bc);
        BatchLog log = new BatchLog(this.logRecord,this.jobRecord);
        log.setExceptionValues(ex);
        Database.SaveResult results = Database.update(log.record);
    }

     public void commitFinalLog(Database.BatchableContext bc){

        fetchJobAndLogRecords(BC);
        BatchLog log = new BatchLog(logRecord,jobRecord);
        log.setFinalLogValues();    
        update log.record;
    }

    
    private void sendExceptionEmail(){

    }

    public void fetchJobAndLogRecords(Database.BatchableContext bc){
        this.jobRecord = getApexJobDetails(bc);
        this.logRecord = getBatchJobLog(bc);
    }

    public AsyncApexJob getApexJobDetails(Database.BatchableContext bc){
        return BatchMonitorSelectors.getAsyncApexJob(new Set<Id>{bc.getJobId()});
    }

    public Batch_Log__c getBatchJobLog(Database.BatchableContext bc){
        return BatchMonitorSelectors.getBatchJobLog(new Set<Id>{bc.getJobId()});
    }

}
