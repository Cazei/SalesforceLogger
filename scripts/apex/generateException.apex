
try{
    Schema.SObjectType.Log__c.getRecordTypeInfosByName().get('asdf').getRecordTypeId();
}catch(Exception e){
    LoggingService.generateExceptionLog(e);
}
