public with sharing class ExceptionManagerServiceImpl {
    
    public ExceptionManagerServiceImpl() {

    }


    public static void generateExceptionRecord(String stackTrace,String exceptionSource, String ExceptionType){


        Exception__c newExceptionRecord = new Exception__c();

        newExceptionRecord.Stack_Trace__c = stackTrace;
        newExceptionRecord.Exception_Source__c = exceptionSource;
        newExceptionRecord.Exception_Type__c = ExceptionType;



    }
}
