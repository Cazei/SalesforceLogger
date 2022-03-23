
try{
    //Schema.SObjectType.Log__c.getRecordTypeInfosByName().get('asdf').getRecordTypeId();
    throw new NullPointerException();
}catch(Exception e){
    LoggingService.generateLog(e);
}
