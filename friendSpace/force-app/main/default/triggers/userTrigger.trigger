trigger userTrigger on User (before insert) {
    if(trigger.isBefore){	
        system.debug('hello');
		system.debug(trigger.new);
    }
}