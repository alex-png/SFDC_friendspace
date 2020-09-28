trigger createOppositeFriendship on friendship__c (after insert) {
    if(trigger.isAfter && trigger.isInsert && triggerHandler.isFirstTime){
       triggerHandler.isFirstTime = false;
       triggerHandler.createOppositeFriendship(trigger.new);
    }
  
}