public class triggerHandler {
   
	public static Boolean isFirstTime = true;

    
    public static void createOppositeFriendship(List<Friendship__c> friendships){
        List<Friendship__c> oppositeFriendships = new List<friendship__c>();
        for(Friendship__c fs:friendships){
            Friendship__c oppositeFS = new Friendship__c();
            oppositeFS.OwnerId = fs.User__c;
            oppositeFS.User__c = fs.OwnerId;
            oppositeFS.Name = fs.Name;
            oppositeFriendships.add(oppositeFS);
        }
        insert oppositeFriendships;
    }

}