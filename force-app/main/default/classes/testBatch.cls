public with sharing class testBatch implements Database.Batchable<sObject>, Database.RaisesPlatformEvents {

    public string scope;

    public Database.QueryLocator start(Database.BatchableContext bc){
            scope = 'SELECT Id FROM Account';

            BatchMonitorService.startBatchMonitoring(bc,scope);

            return Database.getQueryLocator(scope);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope){
        
        try{

 
            for(Account a : scope){
                a.Name = '';
            }
    
            update scope;
     
     
        
        for(Account a : scope){
            a.Name = '';
        }

        update scope;
    }catch(Exception e){
        System.debug(e.getMessage());
        BatchMonitorService.logException(bc, e);
    }
    }

    
    public void finish(Database.BatchableContext bc){
        BatchMonitorService.commitFinalLog(bc);
    }

}
