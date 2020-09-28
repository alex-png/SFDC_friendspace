without sharing public class eventWizardController {
    
    @AuraEnabled
    public static String createMeet(String address, String locationName, String name, String dateAndTime, String imgSrc){        
        Map<String,String> session = Auth.SessionManagement.getCurrentSession();//api call for getting the user's session/ person who is currently logged in
        String userID = session.get('UsersId');//get the userid of the person currently logged in
        
        try{
            Meet__c newMeet = new Meet__c();
            newMeet.location_address__c = address;
            newMeet.Location_Name__c = locationName;
            newMeet.Name = name;
            newMeet.Date_Time__c = (DateTime)JSON.deserialize('"' + dateAndTime + '"', DateTime.class);
            newMeet.OwnerId = userID;            
            newMeet.img_src__c = imgSrc;
            insert newMeet;
            return '' + newMeet.id; 
        }catch(Exception e){
            system.debug(e);
            return 'ERROR';
        }
        
    } // end of createMeet List<Map<String, String>>  
    
    @AuraEnabled
    public static List<Map<String, String>> getFriends(){ 
        id userId = UserInfo.getUserId();
        List<friendship__c> listOfFriendships =[SELECT user__c FROM friendship__c WHERE ownerID = :userID]; //list of friend lookups
        List<Map<String, String>> listOfUsers = new List<Map<String, String>>(); //initialize a list of maps (for friend info)
        system.debug('listOfFriendShips: ' + listOfFriendships);
        for(friendship__c friend:listOfFriendships){
            User u = [SELECT id, firstName, lastName FROM User WHERE id = :friend.User__c]; // get all users that have the friend lookup id
            
            Map<String, String> friendInfo = new Map<String, String>(); // initialize map of strings for user info
            
            String name = + u.FirstName + ' ' + u.LastName; // create string of name
            friendInfo.put('value', u.Id);
            friendInfo.put('label', name); 
            // friendInfo is now a map/object/ that looks like this: {id: u.id, name: name}
            listOfUsers.add(friendInfo);
        }
        system.debug(listofUsers);
        return listOfUsers; 
    }    
    
    @AuraEnabled
	public static List<Invitation__c> createInvite(String meetID, String meetName, List<String> friends){
        id userId = UserInfo.getUserId();
        List<Invitation__c> invites = new List<Invitation__c>();
        for(String friend : friends){
            id friendID = Id.valueOf(friend);
            Invitation__c invite = new Invitation__c();
            invite.Meet__c = meetID;
            invite.Name = meetName;
            invite.User__c = friend;
            invites.add(invite);
         }
        
        try{
            insert invites;
        }catch(Exception e){
            system.debug(e);
        }
    return invites;
    }
    
    
} // end of controller