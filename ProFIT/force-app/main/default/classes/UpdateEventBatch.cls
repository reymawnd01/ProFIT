public class UpdateEventBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String Query = 'Select Id, Name From Event__c Where Status__c != \'Complete\' AND End__c < LAST_N_MONTHS:4';
        return Database.getQueryLocator(Query);
    }
    
    public void execute(Database.BatchableContext batchContext, List<Event__c> listofEvent ){
      
        List<Event__c> updateEventRec = new List<Event__c>();
        for(Event__c evt: listofEvent){
            evt.Status__c = 'Deleted';
            updateEventRec.add(evt);
        }
        update updateEventRec;
    }
    
    public void finish(Database.BatchableContext batchContext){
        String userName = UserInfo.getUserName();
        User activeUser = [Select Name,Email From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        String userWholeName = activeUser.Name;

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setSubject('Batch Records new Status is Deleted');
        List<String> toAddress = new List<String>();
        toAddress.add(userEmail);
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName(userWholeNames);
        
        mail.setHtmlBody('The Following Records Status has been set to Deleted for the Event that ended 4 Months ago');
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {mail});
    }
}