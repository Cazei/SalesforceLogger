trigger LogTrigger on LogEvent__e (after insert) {

 new LogTriggerHandler().run();

}