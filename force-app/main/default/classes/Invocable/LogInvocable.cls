public with sharing class LogInvocable {
    public class Variables {
        @InvocableVariable(
            label='Message'
            description='Message that should be passed to the log'
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
    public static void LogException(List<Variables> message) {
        LoggingService.generateLog(
            message.get(0).text,
            message.get(0).isException
        );
    }
}
