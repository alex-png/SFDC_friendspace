public class HelloWorldController {

    @AuraEnabled
    public static List<Contact> getContacts() {
        system.debug('Method Called');
        List<Contact> bob = [SELECT Id, FirstName, LastName FROM Contact];
        return bob;
    }
}