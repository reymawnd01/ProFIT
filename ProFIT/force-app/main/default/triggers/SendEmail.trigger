trigger SendEmail on Event_Attendee__c (before insert) {
    EventAttendeeTriggerHandler.sendConfirmationEmail(Trigger.New);
}