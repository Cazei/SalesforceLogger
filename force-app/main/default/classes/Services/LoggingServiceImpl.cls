public with sharing class LoggingServiceImpl implements ILoggingService {
    public final String FLOW_EXCEPTION_TYPE = 'FlowException';

    LogUtils utils;

    public LoggingServiceImpl() {
        this.utils = LogUtils.getInstance();
    }

    public void generateLog(Exception record) {
        Log newLog = new Log();

        newLog.createLog(record, utils.getStandardLogRecordTypeId());
        insertLogQueueable(newLog);
    }

    public void generateLog(String message, Boolean isException) {
        Log newLog = new Log();
        newLog.createLog(
            message,
            utils.getStandardLogRecordTypeId(),
            isException
        );

        if (newLog.quiddityContext == utils.INVOCABLE_QUIDDITY) {
            newLog.getRecords()[0].Exception_Type__c = FLOW_EXCEPTION_TYPE;
        }

        insertLogQueueable(newLog);
    }

    public void generateLogs(List<String> messages, Boolean isException) {
        Log newLogs = new Log();
        for (String message : messages) {
            newLogs.createLog(
                message,
                utils.getStandardLogRecordTypeId(),
                isException
            );
        }
        insertLogQueueable(newLogs);
    }

    public void generateLogs(List<BatchApexErrorEvent> batchErrorEvents) {
        Log newLogs = new Log();

        for (BatchApexErrorEvent bex : batchErrorEvents) {
            newLogs.createLog(bex, utils.getBatchLogRecordTypeId());
        }

        insertLogQueueable(newLogs);
    }

    public void generateLogs(List<Exception> exceptionRecords) {
        Log newLog = new Log();

        for (Exception ex : exceptionRecords) {
            newLog.createLog(ex, utils.getStandardLogRecordTypeId());
        }
        insertLogQueueable(newLog);
    }

    private void insertLogQueueable(Log logRecord) {
        LoggingQueueable loggingQueueable = new LoggingQueueable(
            logRecord.getRecords()
        );

        ID jobID = System.enqueueJob(loggingQueueable);
    }
}
