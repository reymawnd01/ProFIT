@isTest
public with sharing class ErrorLogGeneratorTest {
    @IsTest
    static void testError(){

        Test.startTest();
        DateTime logDate = datetime.newInstance(2021, 6, 21, 19, 30, 0);
        String logDetails = 'Error Test';
        String name = 'Test Error Name';
        ErrorLogGenerator.createErrorLog(name, logDetails, logDate);

        Test.stopTest();
        Error_Log__c eLog = [Select Id, Log_Date_Time__c, Log_Details__c, Process_Name__c from Error_Log__c];
    }
}
