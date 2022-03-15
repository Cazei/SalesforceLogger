public interface ILoggingService {
    void generateExceptionLog(Exception record);
    void generateExceptionLogs(List<Exception> records);
    void generateLogs(List<String> messages);
    void generateLog(String message);
    void generateInvocableExceptionLog();
    void generateInvocableLog();
    void publishLogEvents();
    void generateBatchLogs(List<BatchApexErrorEvent> records);
    void generateBatchLogs(BatchApexErrorEvent record);
    void generateBatchExceptionLogs(List<BatchApexErrorEvent> records);
    void generateBatchExceptionLog(BatchApexErrorEvent record);
} 
