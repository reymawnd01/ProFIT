@isTest
public with sharing class EventUpcomingEventsTest {
    static Id createTestNewEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Start__c = datetime.newInstance(2021, 7, 21, 19, 30, 0);
        evt.Live__c = true;
        evt.Max_Seats__c = 100;
        insert evt;
        return evt.Id;
    }
    static Id createTestOldEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Start__c = datetime.newInstance(2021, 3, 21, 19, 30, 0);
        evt.Live__c = true;
        evt.Max_Seats__c = 100;

        insert evt;
        return evt.Id;
    }
    static Id createTestAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        att.Email__c = 'test@gmail.com';
        att.Phone__c = '123123323';
        insert att;
        return att.Id;
    }
    @isTest
    static void testUpcomingEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event__c = createTestNewEvent();
        eA.Attendee__c = createTestAttendee();
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = EventUpcomingEvents.eventRecord(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
    }
    @isTest
    static void testPastEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event__c = createTestOldEvent();
        eA.Attendee__c = createTestAttendee();
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = EventUpcomingEvents.eventPastRecord(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
    }
}


    