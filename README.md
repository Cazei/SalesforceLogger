BatchLogs are  created either via implementing the Database.RaisesPlatformEvents interface and not catching exceptions,
or using loggingService methods to manualtty create logs on exceptions / logpoints.

TODO 
 * Add Batch query to exception object?
 * Exception handling
 * Make sure its Bulkyfied
 * Emails/Notification handling (?)
 * Clean up
 * Performance
 * Surely alot of other stuff.
 * Just makeing it useful could be a start
 * TESTS!!