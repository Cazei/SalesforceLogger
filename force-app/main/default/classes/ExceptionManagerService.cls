public with sharing class ExceptionManagerService {
    public ExceptionManagerService() {

    }

    public static void generateExceptionRecord(String stackTrace,String exceptionSource, String ExceptionType){
        ExceptionManagerServiceImpl.generateExceptionRecord(stackTrace,exceptionSource,ExceptionType);
    }




}
