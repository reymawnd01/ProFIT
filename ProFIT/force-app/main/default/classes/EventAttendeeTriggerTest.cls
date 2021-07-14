@isTest
public class EventAttendeeTriggerTest {
	
    @testSetup
    public static void setupData(){
        
        Event__c event = new Event__c(
            Name__c = 'Moa Arena Contest',
            Event_Type__c = 'Virtual',
            Frequency__c  = 'Weekly',
            Max_Seats__c  = 199,
            Recurring__c = true,
            Live__c = true,
            Start__c = System.now(),
            End__c  = System.now().addDays(3)
        );
        insert event;
        Attendee__c atn = new Attendee__c(
            Name = 'Jin Sakai',
            Email__c = 'reymand.endaya@gmail.com',
            Phone__c = '09391844214'
        );
        insert atn;
        
        Event_Attendee__c evtAtt = new Event_Attendee__c(Event__c = event.Id, Attendee__c = atn.Id);
        insert evtAtt;
    }
    
    @isTest
    static void sendEmailTest(){
        Test.startTest();
        try{
            integer i = 10/0;
        }catch(System.Exception ex ){
            system.debug('error');
        }
        Test.stopTest();
    }
}