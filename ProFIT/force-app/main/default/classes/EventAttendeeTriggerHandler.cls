public class EventAttendeeTriggerHandler {
    
    public static void sendConfirmationEmail(List<Event_Attendee__c> newRecordList ) {
        // Get The Id for Event/Attendee
        Set<Id> atndIdsSet = new Set<Id>();
        Set<Id> eventIdsSet = new Set<Id>();
        
        for(Event_Attendee__c ea : newRecordList){
            atndIdsSet.add(ea.Attendee__c);
            eventIdsSet.add(ea.Event__c);
        }
        Map<Id,Attendee__c> attendeeMap = new Map<Id,Attendee__c>( 
            [Select Id, Name, Email__c From Attendee__c WHERE  Id IN : atndIdsSet]
        );
        
        Map<Id, Event__c > eventMap = new Map<Id, Event__c > ( [Select Id, Name__c, Start__c,Organizer__r.Name,Event__c.Name,
                                                                Location__c , Location__r.Name, Location__r.City__c,
                                                                Location__r.State__c, Location__r.Country__c,
                                                                Location__r.Postal_Code__c, Location__r.Street__c
                                                                FROM Event__c  WHERE ID IN: eventIdsSet]
                                                             );
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for(Event_Attendee__c ea : newRecordList){
            
            Attendee__c att = attendeeMap.get(ea.Attendee__c);
            Event__c evt = eventMap.get(ea.Event__c);
              
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            mail.setSubject('Pass for the '+evt.Name__c);
            List<String> toAddress = new List<String>();
            toAddress.add(att.Email__c);
            mail.setToAddresses( toAddress );
            
            String location = 'https://www.google.com/maps/place/'+evt.Location__r.Street__c+' '+evt.Location__r.City__c+' '
                +evt.Location__r.State__c+' '+
                evt.Location__r.Country__c+' '+evt.Location__r.Postal_Code__c;
            String hrefForLocation = '<a href="'+location+'"'+'target="_blank">Here</a>';

            String emailBody = 'Dear '+ att.Name + ',<br/><br/>'+
                'Thank you for registering for '+evt.Name+' which will be Organized on '+
                evt.Start__c+' & will be held in '+evt.Location__r.Name
                +'.<br/>We are excited to have you,'+ 
                'see you in the event. <br/>'+
                'Find the Google Map Location for the Event '+hrefForLocation+'.<br/><br/><br/>'+
                'Thanks, <br/>'+evt.Organizer__r.Name;
            
            mail.setHtmlBody(emailBody);
            emailList.add(mail);
            
        }
        try{
            List<Messaging.SendEmailResult> results =  Messaging.sendEmail(emailList, false); 
            for(Messaging.SendEmailResult email : results){
                System.debug(email.isSuccess());
                if(!email.isSuccess()){
                    system.debug('error');
                }
            }  
        }catch(System.Exception ex){
            system.debug('error');
        }
        
    }
}