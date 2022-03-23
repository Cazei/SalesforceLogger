public interface ILoggingService {
    void generateLog(Exception record);
    void generateLog(BatchApexErrorEvent record);
    void generateLog(String message,Boolean isException);
    void generateLogs(List<BatchApexErrorEvent> records);
    void generateLogs(List<Exception> records);
    void generateLogs(List<String> messages,Boolean isExceptions);
} 
