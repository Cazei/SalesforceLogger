
/**
 * TODO::
 * Set Enumerable for Error Types
 * Generate error records
 * Exception handling
 * Valdate CRUD
 * Make sure its Bulkyfied
 * Emails/Notification handling
 * 
 * 
 * 
 */

public with sharing class BatchMonitorService {

	private static  BatchMonitorServiceimpl service()
	{
		return (BatchMonitorServiceimpl) BatchMonitorServiceimpl.class.newInstance();
	}   

    public  static void startBatchMonitoring(Database.BatchableContext bc,String soqlScope){
        service().startBatchMonitoring(bc,soqlScope);
    }

    public static void logException(Database.BatchableContext bc, Exception ex){
        System.debug('Log Exception');
        service().logException(bc, ex);
    }

    public static void logException(Database.BatchableContext bc, DmlException ex){
        System.debug('Log Exception');
        service().logException(bc, ex);
    }

    public static void commitFinalLog(Database.BatchableContext bc){
        service().commitFinalLog(bc);
    }

}