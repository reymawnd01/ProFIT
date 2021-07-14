@isTest
private class EventSpeakerRejectDuplicateTest {
 
        Static Id createTestRecordID(){
            Event__c evt = new Event__c();
            evt.Name__c = 'Test Event';
            evt.Live__c = true;
            evt.Start__c = System.now().addMonths(4);
            evt.End__c = System.now().addDays(5).addMonths(4);
            insert evt;
            return evt.Id;
        }
        Static Id createSpeakerRecordID(){
          Speaker__c spkr = new Speaker__c();
          spkr.Name = 'Jean';
          spkr.Email__c = 'jean@gmail.com';
          spkr.Phone__c = '09178677374';
          spkr.Company__c = 'Knights of Favonius';
          insert spkr;
          return spkr.Id;
      }
    
            @IsTest
          Static void checkEventEspeaker(){
            Test.startTest();
    
            
            Event_Speaker__c eS = new Event_Speaker__c();
            //Field Names
            //Create a new data to object
            eS.Name = 'ES-00007';
            eS.Event__c = createTestRecordID();
            eS.Speaker__c = createSpeakerRecordID();
            
            insert eS;
            Test.stopTest();
    
            Event_Speaker__c retrievedES = [Select Name from Event_Speaker__c where Name =: eS.Name];
              
          }
}
