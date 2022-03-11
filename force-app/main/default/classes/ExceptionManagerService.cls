
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




public with sharing class ExceptionManagerService {
    public ExceptionManagerService() {

    }

    public static void generateExceptionRecord(String stackTrace,String exceptionSource, String ExceptionType){
        ExceptionManagerServiceImpl.generateExceptionRecord(stackTrace,exceptionSource,ExceptionType);
    }




}
