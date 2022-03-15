
/**
 * TODO::
 * Set Enumerable for Error Types
 * Generate error records
 * Exception handling
 * Valdate CRUD
 * Make sure its Bulkyfied
 * Emails/Notification handling
 * 
 * 
 * 
 */

public with sharing class LoggingService {

	private static ILoggingService service()
	{
		return (ILoggingService) LoggingServiceImpl.class.newInstance();
	}

    /**
     * Generate a single exception log record
     */
    public static void generateExceptionLog( record){
        service().generateExceptionLog(record);
    } 

    /**
     * generate several Exception log records
     */
    public static void generateExceptionLogs(List<Exception> records){
        service().generateExceptionLogs(records);
    } 

    /**
     * Generate several log records
     */
    public static void generateLogs(List<String> messages){
        service().generateLogs(generateLogs(messages));
    }

    /**
     * Generate a single Log record
     */
    public static void generateLog(String message){
        service().generateLog(message);
    }

    /**
     * Generate several batch exception log records
    */
    public static void generateBatchExceptionLogs(List<BatchApexErrorEvent> records){
        service().generateBatchExceptionLogs(records);
    }

    /**
     * Generate a single batch exception log
    */
    public static void generateBatchExceptionLog(BatchApexErrorEvent record){
        service().generateBatchExceptionLogs(records);
    }

    /**
     * Generate a several batch logs
    */
    public static void genetateBatchLogs(List<BatchApexErrorEvent> records){
        service().generateBatchExceptionLogs(records);
    }

    /**
     * Generate a single batch log
    */
    public static void genetateBatchLog(BatchApexErrorEvent record){
        service().generateBatchExceptionLogs(records);
    }

}