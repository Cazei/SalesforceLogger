public interface ILoggingService {
    void generateLog(Exception record);
    void generateLogs(List<Exception> records);
    void generateInvocableLog(String message,Boolean isException);
    void generateLogs(List<String> messages,Boolean isExceptions);
    void generateLog(String message,Boolean isException);
    void generateLogs(List<BatchApexErrorEvent> records);
    void generateLog(BatchApexErrorEvent record);
} 
