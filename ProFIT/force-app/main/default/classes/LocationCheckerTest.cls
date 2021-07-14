@isTest
public with sharing class LocationCheckerTest {
    public static testMethod void testZip(){

        Location__c loc = new Location__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States'
        );
        insert loc;



        try{
            Test.setMock(HttpCalloutMock.class, new ZipCalloutMock());
            Test.startTest();

            LocationCheckerHandler.zipCodeCallOut(''+loc.Id+'');
            
            Test.stopTest();
        }catch(Exception ex){

        }
        Location__c retrievedZipVerified = [Select Zip_Verified__c from Location__c where Id =: loc.Id];
        System.assertEquals(true,retrievedZipVerified.Zip_Verified__c);

    }
    public static testMethod void testLoc(){
        Location__c loc = new Location__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States'
        );
        insert loc;

        try{
            Test.setMock(HttpCalloutMock.class, new LocationMockCallout());
            Test.startTest();

            LocationCheckerHandler.locationCall(''+loc.Id+'');
            
            Test.stopTest();
        }catch(Exception ex){

        }
        Location__c retrievedLocVerified = [Select Verified__c from Location__c where Id =: loc.Id];
        System.assertEquals(true,retrievedLocVerified.Verified__c);
    }

}