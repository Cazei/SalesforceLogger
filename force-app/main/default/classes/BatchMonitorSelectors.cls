public with sharing class BatchMonitorSelectors {
  


    public static AsyncApexJob getAsyncApexJob(Set<Id> ids){
        AsyncApexJob job = [SELECT Id, JobType,Status,CompletedDate,MethodName,CreatedDate,JobItemsProcessed,ApexClass.Name,NumberOfErrors,TotalJobItems FROM AsyncApexJob WHERE Id = :ids LIMIT 1];
        return job;
    }

    public static Batch_Log__c getBatchJobLog(Set<Id> ids){
        Batch_Log__c log = [SELECT  Id,Apex_Class_Name__c, Batch_Id__c, Batch_Scope__c, Batch_Start_Date__c, Batch_Type__c, Chunks_Processed__c, Chunks_With_Errors__c, Completed_Date__c, CreatedById, CreatedDate, Cron_Trigger__c, DML_Type__c, Error_Message__c, Items_in_Scope__c, Items_Processed__c, Name, Number_Of_DML_Errors__c, Number_of_Errors__c, Stack_Trace__c, Status__c, Total_Batch_Chunks__c FROM Batch_Log__c WHERE Batch_Id__c = :ids LIMIT 1];
        return log;
    }





}
