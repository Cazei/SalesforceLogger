public with sharing class LogEvent {
    private static final String EXCEPTION_STRING_FORMAT = 'Exception: [{0}] {1} \n Stack Trace: {2}';


    public LogSeverity severityLevel { get; set; }

    public Quiddity quiddity { get {
        if(quiddity == null){
            quiddity = Request.getCurrent().getQuiddity();
        }
        return quiddity;
        } 
        set; 
    }

    public String stackTrace { get; set; }
    public String message { get; set; }

    public LogEvent(Exception ex) {
        this.message = String.format(EXCEPTION_STRING_FORMAT, new List<String>{ex.getTypeName() ,ex.getMessage(),ex.getStackTraceString()});
        this.quiddity = this.quiddity;
        this.severityLevel = LogSeverity.ERROR;
    }

    public LogEvent__e generateEvent(){
        return new LogEvent__e (
            Severity__c = this.severityLevel?.name(),
            Quiddity__c = this.quiddity?.name(),
            Message__c = this.stackTrace
        );
    }

    private enum LogSeverity {
        DEBUG,
        WARN,
        INFO,
        ERROR
    }
}
