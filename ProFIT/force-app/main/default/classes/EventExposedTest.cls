@istest
public with sharing class EventExposedTest {
    static Id createEventTestRecord(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Record REST Service';
        evt.Start__c = datetime.newInstance(2021, 6, 26, 11, 00, 0);
        evt.End__c = datetime.newInstance(2021, 6, 27, 12, 00, 0);
        evt.Event_Type__c ='Virtual';
        evt.Live__c = true;
        evt.Recurring__c = true;
        evt.Status__c = 'Created';
        evt.Frequency__c = 'Daily';
        insert evt;
        return evt.Id;
    }
    @IsTest
    static void doGetTest(){
        Test.startTest();
            Id EventId =  createEventTestRecord();
            RestRequest req = new RestRequest();
            req.requestURI = 'https://abctechnology2--prosandbox.my.salesforce.com/services/apexrest/api/Event__c/'+EventId;
            req.httpMethod = 'GET';
            RestContext.request = req;
            Event__c evt = EventExposed.doGetEvt();
            System.assertEquals(EventId, evt.Id);
        Test.stopTest();
    }
}

