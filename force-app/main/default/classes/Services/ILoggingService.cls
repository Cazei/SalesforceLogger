public interface ILoggingService {
    void generateExceptionLog(Exception record);
    void generateExceptionLogs(List<Exception> records);
    void generateLogs(List<String> messages);
    void generateLog(String message);
    void generateInvocableLog(String message,Boolean isException);
    void generateBatchLogs(List<String> messages);
    void generateBatchLog(String message);
    void generateBatchExceptionLogs(List<BatchApexErrorEvent> records);
    void generateBatchExceptionLog(BatchApexErrorEvent record);
} 
