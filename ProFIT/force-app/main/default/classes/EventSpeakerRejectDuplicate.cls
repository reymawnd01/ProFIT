public class EventSpeakerRejectDuplicate {
       public static void validateDuplicateName(List<Event_Speaker__c> newEvtSpeaker) {
        try{
            //Get the speaker id of Event and Speaker
            Set<Id> speakerIdSet = new Set<Id>();
            Set<Id> eventIdSet = new Set<Id>();
    
            for(Event_Speaker__c es : newEvtSpeaker){
                speakerIdSet.add(es.Speaker__c);
                eventIdSet.add(es.Event__c);
            }
            //SOQL on Event to get StartDate and Put into Map
            Map<Id, DateTime> requestedEvents = new Map<Id,DateTime>();
    
            List<Event__c> relatedEventList = [Select Id, Start__c From Event__c Where Id IN : eventIdSet];

            for(Event__c evt : relatedEventList ){
                requestedEvents.put(evt.Id, evt.Start__c);
            }

            
            //SOQL on Event-Speaker to get the related Speaker along with the Event Start Date
            List<Event_Speaker__c> relatedEventSpeakerList = [Select Id, Event__c, Speaker__c, Event__r.Start__c From Event_Speaker__c Where Speaker__c IN : speakerIdSet];
    
            for(Event_Speaker__c es : newEvtSpeaker){
    
                DateTime bookingTime = requestedEvents.get(es.Event__c);
    
                for(Event_Speaker__c es1 : relatedEventSpeakerList){
                    if(es1.Speaker__c == es.Speaker__c && es1.Event__r.Start__c == bookingTime){
                        es.Speaker__c.addError('Duplicate Booking');
                    }
                }
            }
        
            } catch (Exception e){
                System.debug('Get Exception' +e.getMessage());
            }
        } 

      

} 









 