@IsTest
public with sharing class LoggingServiceTest {
    private static String LOGSEVERITY_INFO = 'INFO';
    private static String LOGSEVERITY_ERROR = 'ERROR';

    private static String WRONG_SEVERITY_INFO = 'Severity Should be INFO, Was ';
    private static String WRONG_SEVERITY_ERROR = 'Severity Should be ERROR, Was ';

    private static String LOG_DATA_SHOULD_HAVE_BEEN_ADDED = 'Log Data should have been added. No data was added.';
    private static String STACK_TRACE_SHOULD_HAVE_BEEN_ADDED = 'Stack Trace should have been added. It was not.';

    private static String THERE_SHOULD_BE_ONE_RECORD = 'There should be 1 log record. Current: {0}';
    private static String THERE_SHOULD_BE_TWO_RECORDS = 'There should be 2 log records. Current: {0}';

    @IsTest
    public static void throwStandardExceptionShouldGenerateLog() {
        Test.startTest();
        Exception ex = new DmlException();
        LoggingService.generateLog(ex);
        Test.stopTest();

        List<Log__c> logsResult = [
            SELECT Id, Log_Data__c, Stack_Trace__c, Severity__c
            FROM Log__c
        ];

        System.assert(
            logsResult.size() == 1,
            String.format(
                THERE_SHOULD_BE_ONE_RECORD,
                new List<Object>{ logsResult.size() }
            )
        );
        System.assert(
            logsResult.get(0).Log_Data__c != null,
            LOG_DATA_SHOULD_HAVE_BEEN_ADDED
        );
        System.assert(
            logsResult.get(0).Stack_Trace__c != null,
            STACK_TRACE_SHOULD_HAVE_BEEN_ADDED
        );
        System.assert(
            logsResult.get(0).Severity__c == LOGSEVERITY_ERROR,
            WRONG_SEVERITY_INFO + logsResult.get(0).Severity__c
        );
    }

    @IsTest
    public static void throwStandardExceptionShouldGenerateLogs() {
        List<Exception> exceptions = new List<Exception>();

        Test.startTest();
        exceptions.add(new DmlException());
        exceptions.add(new DmlException());
        LoggingService.generateLogs(exceptions);
        Test.stopTest();

        List<Log__c> logsResult = [
            SELECT Id, Log_Data__c, Severity__c, Stack_Trace__c
            FROM Log__c
        ];

        System.assert(
            logsResult.size() == 2,
            String.format(
                THERE_SHOULD_BE_TWO_RECORDS,
                new List<Object>{ logsResult.size() }
            )
        );
        System.assert(
            logsResult.get(0).Log_Data__c != null,
            LOG_DATA_SHOULD_HAVE_BEEN_ADDED
        );
        System.assert(
            logsResult.get(0).Stack_Trace__c != null,
            STACK_TRACE_SHOULD_HAVE_BEEN_ADDED
        );
        System.assert(
            logsResult.get(0).Severity__c == LOGSEVERITY_ERROR,
            WRONG_SEVERITY_INFO + logsResult.get(0).Severity__c
        );
    }

    @IsTest
    public static void genereateInfoLog() {
        Test.startTest();
        LoggingService.generateLog('Exception Message', false);
        Test.stopTest();

        List<Log__c> logsResult = [
            SELECT Id, Log_Data__c, Severity__c
            FROM Log__c
        ];
        System.debug(logsResult);

        System.assert(
            logsResult.size() == 1,
            String.format(
                THERE_SHOULD_BE_ONE_RECORD,
                new List<Object>{ logsResult.size() }
            )
        );
        System.assert(
            logsResult.get(0).Log_Data__c != null,
            LOG_DATA_SHOULD_HAVE_BEEN_ADDED
        );
        System.assert(
            logsResult.get(0).Severity__c == LOGSEVERITY_INFO,
            WRONG_SEVERITY_INFO + logsResult.get(0).Severity__c
        );
    }

    @IsTest
    public static void genereateInfoLogs() {
        List<String> logMessages = new List<String>();
        logMessages.add('Message1');
        logMessages.add('Message2');

        Test.startTest();
        LoggingService.generateLogs(logMessages, false);
        Test.stopTest();

        List<Log__c> logsResult = [
            SELECT Id, Log_Data__c, Severity__c
            FROM Log__c
        ];

        System.assert(
            logsResult.size() == 2,
            String.format(
                THERE_SHOULD_BE_TWO_RECORDS,
                new List<Object>{ logsResult.size() }
            )
        );
        System.assert(
            logsResult.get(0).Log_Data__c != null,
            LOG_DATA_SHOULD_HAVE_BEEN_ADDED
        );
        System.assert(
            logsResult.get(0).Severity__c == LOGSEVERITY_INFO,
            WRONG_SEVERITY_INFO + logsResult.get(0).Severity__c
        );
    }

    @IsTest
    public static void genereateCustomExceptionLog() {
        Test.startTest();
        LoggingService.generateLog('Exception Message', true);
        Test.stopTest();

        List<Log__c> logsResult = [
            SELECT Id, Log_Data__c, Severity__c
            FROM Log__c
        ];

        System.assert(
            logsResult.size() == 1,
            String.format(
                THERE_SHOULD_BE_ONE_RECORD,
                new List<Object>{ logsResult.size() }
            )
        );
        System.assert(
            logsResult.get(0).Log_Data__c != null,
            LOG_DATA_SHOULD_HAVE_BEEN_ADDED
        );
        System.assert(
            logsResult.get(0).Severity__c == LOGSEVERITY_ERROR,
            WRONG_SEVERITY_ERROR + logsResult.get(0).Severity__c
        );
    }

    @IsTest
    public static void genereateCustomExceptionLogs() {
        List<String> logMessages = new List<String>();
        logMessages.add('Message1');
        logMessages.add('Message2');

        Test.startTest();
        LoggingService.generateLogs(logMessages, true);
        Test.stopTest();

        List<Log__c> logsResult = [
            SELECT Id, Log_Data__c, Severity__c
            FROM Log__c
        ];

        System.assert(
            logsResult.size() == 2,
            String.format(
                THERE_SHOULD_BE_TWO_RECORDS,
                new List<Object>{ logsResult.size() }
            )
        );
        System.assert(
            logsResult.get(0).Log_Data__c != null,
            LOG_DATA_SHOULD_HAVE_BEEN_ADDED
        );
        System.assert(
            logsResult.get(0).Severity__c == LOGSEVERITY_ERROR,
            WRONG_SEVERITY_ERROR + logsResult.get(0).Severity__c
        );
    }

    @IsTest
    public static void generateBatchExceptionLog() {
        try {
            Test.startTest();

            Database.executeBatch(new LoggingServiceTestBatch());
            Test.stopTest();
            Test.getEventBus().deliver();

            List<Log__c> logs = [
                SELECT Id, RecordType.Name, Context__c
                FROM Log__c
            ];
        } catch (System.MathException e) {
            Test.getEventBus().deliver();

            System.debug([SELECT Id, RecordType.Name, Context__c FROM Log__c]);

            System.assertEquals(
                1,
                [SELECT Id, RecordType.Name, Context__c FROM Log__c].size(),
                THERE_SHOULD_BE_ONE_RECORD
            );
        }
    }

    @IsTest
    public static void invocableException() {
        LogInvocable.Variables vars = new LogInvocable.Variables();
        vars.isException = true;
        vars.text = 'Exception String';
        Test.startTest();
        LogInvocable.LogException(new List<LogInvocable.Variables>{ vars });
        Test.stopTest();

        List<Log__c> results = [SELECT id, log_data__c FROM Log__c];

        System.assertEquals(1, results.size(), THERE_SHOULD_BE_ONE_RECORD);
        System.assert(
            results.get(0).Log_Data__c != null,
            LOG_DATA_SHOULD_HAVE_BEEN_ADDED
        );
    }
}
