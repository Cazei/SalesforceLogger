public class BatchLog {
    
    public Batch_Log__c record;
    public AsyncApexJob job;

    public BatchLog (Batch_Log__c record,AsyncApexJob job ){
        this.record = record;
        this.job = job;
    }

    public BatchLog (AsyncApexJob job ){
        this.job = job;
    }

    public void generateDefaultBatchLog(){
        this.record = new Batch_Log__c();
        setDefaultBatchLogValues();
    }

    public void generateDefaultBatchLog(String soqlScope){
        this.record = new Batch_Log__c();
        this.record.Batch_Scope__c = soqlScope;
        setDefaultBatchLogValues();
    }

    private void setDefaultBatchLogValues(){
        this.record.Batch_Id__c = this.job.Id;
        this.record.Status__c = this.job.Status;
        this.record.Batch_Start_Date__c = this.job.CreatedDate;
        this.record.Apex_Class_Name__c = this.job.ApexClass.Name;
        this.record.Batch_Type__c = this.job.JobType; 
    }

    public void setFinalLogValues(){
        this.record.Completed_Date__c = this.job.CompletedDate;
        this.record.Items_Processed__c = this.job.JobItemsProcessed;
        this.record.Status__c = this.job.Status;
        this.record.Chunks_Processed__c = this.job.JobItemsProcessed;
        this.record.Total_Batch_Chunks__c = this.job.TotalJobItems;
        this.record.Chunks_With_Errors__c += this.job.NumberOfErrors;
    }

    public void setExceptionValues(Exception ex){
        this.record.Stack_Trace__c = ex.getStackTraceString();
        this.record.Error_Message__c = ex.getMessage();
        this.record.DML_Type__c = String.ValueOf(ex.getDmlType(0));
        this.record.Number_Of_DML_Errors__c += ex.getNumDml();
    }


    public void setExceptionValues(DMLException ex){
        this.record.Stack_Trace__c = ex.getStackTraceString();
        this.record.Error_Message__c = ex.getMessage();
        this.record.DML_Type__c = String.ValueOf(ex.getDmlType(0));
        this.record.Number_Of_DML_Errors__c += ex.getNumDml();
    }
}
