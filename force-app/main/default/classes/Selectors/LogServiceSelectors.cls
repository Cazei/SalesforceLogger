public with sharing class LogServiceSelectors {
    public static AsyncApexJob getAsyncApexJob(Set<Id> ids){
        AsyncApexJob job = [SELECT Id, JobType,Status,CompletedDate,MethodName,CreatedDate,JobItemsProcessed,ApexClass.Name,NumberOfErrors,TotalJobItems FROM AsyncApexJob WHERE Id = :ids LIMIT 1];
        return job;
    }
}
