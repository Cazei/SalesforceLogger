public with sharing class LogInvocable {


 
    public class Message {
        @InvocableVariable(
            label='Error message'
            description='Input Flow error Message'
            required=true
        )
        public String text;

        @InvocableVariable(
            label='Is Exception'
            description='Should be tagged as an exception'
            required=true
        )
        public Boolean isException;
    }

    @InvocableMethod(
        label='Generate a Log'
        description='Generate a Log__c record.'
    )
    public static void LogException( List<Message> message ) {
        LoggingService.generateInvocableLog(message.get(0).text, message.get(0).isException);
    }

    

}
