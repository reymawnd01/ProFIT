trigger EventSpeakerDuplicateTrigger on Event_Speaker__c (before insert, before update) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        EventSpeakerRejectDuplicate.validateDuplicateName(trigger.new);
       }
}