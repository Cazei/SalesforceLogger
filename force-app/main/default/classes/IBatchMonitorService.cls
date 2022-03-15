public interface IBatchMonitorService {

    void startBatchMonitoring(Database.BatchableContext bc,String soqlScope);
    void logException(Database.BatchableContext bc,Exception ex);
    void logException(Database.BatchableContext bc,DMLException ex);
    void commitFinalLog(Database.BatchableContext bc);
        

} 
