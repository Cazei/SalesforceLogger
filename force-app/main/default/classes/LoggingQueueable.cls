public class LoggingQueueable implements Queueable {
  List<Log__c> logs = new List<Log__c>();

  public LoggingQueueable(List<Log__c> records) {
    this.logs = records;
  }

  public void execute(QueueableContext context) {
    insert logs;
  }
}
