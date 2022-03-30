BatchLogs are created by implementing the interface Database.RaisesPlatformEvents in your batches, and then letting exceptions go unhandeled.
The unhandled exceptions will produce BatchApexErrorEvents that are picked up by the BatchErrorEventTriggerHandler.

To generate standard Exception logs use the methods 

LoggingService.generateLog(Excetption ex) or LoggingService.generateLog(List<Exception> exs).
  
  
To generate logs in flows or Process builders, there is an invocable action called "Generate a Log". 
