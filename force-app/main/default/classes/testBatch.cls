public with sharing class testBatch implements Database.Batchable<sObject>, Database.RaisesPlatformEvents {

    public string scope;

    public Database.QueryLocator start(Database.BatchableContext bc){
            scope = 'SELECT Id FROM Account';

            return Database.getQueryLocator(scope);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope){
        
            for(Account a : scope){
                a.Name = '';
            }
    
            update scope;
     
    
            for(Account a : scope){
                a.Name = '';
            }

            update scope;
    }

    
    public void finish(Database.BatchableContext bc){
    }

}
