/**
 *
 * This batch class is added for testing the BatchApexErrorEvent TriggerHandler.
 */

public with sharing class LoggingServiceTestBatch implements Database.Batchable<sObject>, Database.RaisesPlatformEvents {
    public string scope;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        scope = 'SELECT Id FROM Organization';

        return Database.getQueryLocator(scope);
    }

    public void execute(
        Database.BatchableContext bc,
        List<Organization> scope
    ) {
        Integer i = 1 / 0;
    }

    public void finish(Database.BatchableContext bc) {
    }
}
