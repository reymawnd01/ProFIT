public with sharing class ErrorLogGenerator {
    public static void createErrorLog (String name, String logDetails, Datetime logDateTime) {
        Error_Log__c ErrorLog = new Error_Log__c();
        ErrorLog.Name = name;
        ErrorLog.Log_Details__c = logDetails;
        ErrorLog.Log_Date_Time__c = logDateTime;
        insert ErrorLog;
    }
}