trigger contactTrigger on Contact (before insert) {
    if(trigger.isBefore){
        system.debug(trigger.new);
    }
}