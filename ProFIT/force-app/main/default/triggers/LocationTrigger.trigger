trigger LocationTrigger on Location__c (after insert, after update) {
    
    if(Trigger.isAfter && Trigger.isInsert ){
        for( Location__c loc : Trigger.New ){
            LocationCheckerHandler.zipCodeCallOut(loc.Id);
        }
    }
}