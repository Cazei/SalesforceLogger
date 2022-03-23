
/**
 * Done (Kind of?):
 * Create exception logs for Batch error events
 * Create Single error logs
 * 
 * TODO::
 * Add Batch query to exception object?
 * Exception handling
 * Make sure its Bulkyfied
 * Emails/Notification handling
 * Clean up
 * Performance
 * Surely alot of other stuff.
 * TESTS!!
 * 
 */

public with sharing class LoggingService {

    public class LoggingServiceException extends Exception{}
    public class LoggingServiceTypeException extends Exception{}


	private static ILoggingService service()
	{
		return (ILoggingService) LoggingServiceImpl.class.newInstance();
	}

    /**
     * 
     * Generate a single exception log record
     * @param exception The exception that should be logged
     * 
     */
    public static void generateLog( Exception exceptionRecord){
        service().generateLog(exceptionRecord);
    } 

    /**
     * 
     * Generate several Exception log records
     * @param exception The exceptions that should be logged
     * 
     */
    public static void generateLogs(List<Exception> exceptionRecords){
        service().generateLogs(exceptionRecords);
    } 

    /**
     * 
     * Generate several log records
     * @param messages A list of string that each should generate a separeate log
     * @param isExceptions Indicate if these are log messages or Error messages
     * 
     */
    public static void generateLogs(List<String> messages,Boolean isExceptions){
        service().generateLogs(messages,isExceptions);
    }

    /**
     * @description Generate a single Log record
     * 
     */
    public static void generateLog(String message, Boolean isException){
        service().generateLog(message,isException);
    }

    /**
     * @Description Generate a log record for an Invocable Method (Flow, Processbuilder, Workflow)
     * @param messages List of strings that should generate one log record each 
     * 
     */
    public static void generateInvocableLog(String message,Boolean isException){
        service().generateInvocableLog(message,isException);
    }

    /**
     * @description Generate several batch exception log records
     * @param exceptionEvents A list of batch Exception event that should generate error logs
    */
    public static void genereateLogs(List<BatchApexErrorEvent> exceptionEvents){
        service().generateLogs(exceptionEvents);
    }

    /**
     * Generate a single batch exception log
     * @param exceptionEvent An Exception Event that should generate an error log
    */
    public static void generateLog(BatchApexErrorEvent exceptionEvent){
        service().generateLog(exceptionEvent);
    }
}