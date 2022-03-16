
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
     * Generate a single exception log record
     */
    public static void generateExceptionLog( Exception record){
        service().generateExceptionLog(record);
    } 

    /**
     * generate several Exception log records
     */
    public static void generateExceptionLogs(List<Exception> exceptions){
        service().generateExceptionLogs(exceptions);
    } 

    /**
     * Generate several log records
     */
    public static void generateLogs(List<String> messages){
        service().generateLogs(messages);
    }

    /**
     * @description Generate a single Log record
     * 
     */
    public static void generateLog(String message){
        service().generateLog(message);
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
    public static void generateBatchExceptionLogs(List<BatchApexErrorEvent> exceptionEvents){
        service().generateBatchExceptionLogs(exceptionEvents);
    }

    /**
     * Generate a single batch exception log
     * @param exceptionEvent An Exception Event that should generate an error log
    */
    public static void generateBatchExceptionLog(BatchApexErrorEvent exceptionEvent){
        service().generateBatchExceptionLog(exceptionEvent);
    }

    /**
     * Generate a several batch logs
     * @param messages List of strings that should generate one log record each
    */
    public static void generateBatchLogs(List<String> messages){
        service().generateBatchLogs(messages);
    }

    /**
     * Generate a single batch log
     *      
     * @param message String that should generate a log record
    */
    public static void generateBatchLog(String message){
        service().generateBatchLog(message);
    }
}