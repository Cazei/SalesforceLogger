public with sharing class LogUtils {
    public static final String BATCH_LOG_RECORD_TYPE = 'Async Log';
    public static final String STANDARD_LOG_RECORD_TYPE = 'Standard Log';
    public static final String INVOCABLE_LOG_RECORD_TYPE = 'Invocable Log';

    public final String BATCH_APEX = 'BATCH_APEX';

    public final Quiddity INVOCABLE_QUIDDITY = Quiddity.INVOCABLE_ACTION;

    private static LogUtils utils { get; private set; }

    String batchLogRecordTypeId { get; private set; }
    String standardRecordTypeId { get; private set; }

    public LogUtils() {
    }

    public static LogUtils getInstance() {
        if (utils == null) {
            utils = new LogUtils();
        }
        return utils;
    }

    public Id getStandardLogRecordTypeId() {
        if (this.standardRecordTypeId == null) {
            this.standardRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName()
                .get(STANDARD_LOG_RECORD_TYPE)
                .getRecordTypeId();
        }
        return this.standardRecordTypeId;
    }

    public Id getBatchLogRecordTypeId() {
        if (this.batchLogRecordTypeId == null) {
            this.batchLogRecordTypeId = Schema.SObjectType.Log__c.getRecordTypeInfosByName()
                .get(BATCH_LOG_RECORD_TYPE)
                .getRecordTypeId();
        }
        return this.batchLogRecordTypeId;
    }
}
