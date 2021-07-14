public with sharing class EventUpcomingEvents {

    @AuraEnabled
    public static List<Event_Attendee__c> eventRecord(String attendeeId){
        List<Event_Attendee__c> eventLists = [Select 
        Id, 
        Name, 
        Event__c,
        Event__r.Location__c,
        Event__r.Location__r.Name,
        Event__r.Name__c,
        Event__r.Organizer__c, 
        Event__r.Organizer__r.Name, 
        Event__r.Start__c 
        FROM Event_Attendee__c 
        WHERE Attendee__c =: attendeeId AND Event__r.Start__c >= today AND Event__r.Live__c = true
        ];

        return eventLists;

    }
    @AuraEnabled
    public static List<Event_Attendee__c> eventPastRecord(String attendeeId){
        List<Event_Attendee__c> eventLists = [Select 
        Id, 
        Name, 
        Event__c,
        Event__r.Location__c,
        Event__r.Location__r.Name,
        Event__r.Name__c,
        Event__r.Organizer__c, 
        Event__r.Organizer__r.Name, 
        Event__r.Start__c 
        FROM Event_Attendee__c 
        WHERE Attendee__c =: attendeeId AND Event__r.Start__c < today AND Event__r.Live__c = true
        ];

        return eventLists;

    }
}