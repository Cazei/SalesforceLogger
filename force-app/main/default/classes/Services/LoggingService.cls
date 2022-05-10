public with sharing class LoggingService {
  public class LoggingServiceException extends Exception {
  }
  public class LoggingServiceTypeException extends Exception {
  }

  private static ILoggingService service() {
    return (ILoggingService) LoggingServiceImpl.class.newInstance();
  }

  /**
   *
   * Generate a single exception log record
   * @param exception The exception that should be logged
   *
   */

  public static void generateLog(Exception exceptionRecord) {
    service().generateLog(exceptionRecord);
  }

  /**
   *
   * Generate several Exception log records
   * @param exception The exceptions that should be logged
   *
   */

  public static void generateLogs(List<Exception> exceptionRecords) {
    service().generateLogs(exceptionRecords);
  }

  /**
   *
   * Generate several log records
   * @param messages A list of string that each should generate a separeate log
   * @param isExceptions Indicate if these are log messages or Error messages
   *
   */

  public static void generateLogs(List<String> messages, Boolean isExceptions) {
    service().generateLogs(messages, isExceptions);
  }

  /**
   *
   * @description Generate a single Log record
   * @param message Message that should be added to the log
   * @param isException should the log be tagged as an exception or not
   */

  public static void generateLog(String message, Boolean isException) {
    service().generateLog(message, isException);
  }

  /**
   * @description Generate several batch exception log records
   * @param exceptionEvents A list of batch Exception event that should generate error logs
   */

  public static void generateLogs(List<BatchApexErrorEvent> exceptionEvents) {
    service().generateLogs(exceptionEvents);
  }
}
