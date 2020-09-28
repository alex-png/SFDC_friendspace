public class displayInfoController {
    
    @AuraEnabled
    public static Map<String, Object> getInfo(String zipcode){
        Map<String, Object> results;
        String apiKey = '_cn5pJtWl__loc1su2QjNv9PoaPvZ6LRzxj0afUa5Ya4HQLYkFhOIx-VHQcARJnVtRvmoJ3TkNNNvTvRqSHm61pptoLgym8u8cL7i4BRIZaJ5JFZXu47q_krD_Y1X3Yx';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + apiKey);
        request.setEndpoint('https://api.yelp.com/v3/businesses/search?location='+zipcode+'&radius=1600');
        request.setMethod('GET');
        system.debug('making request...');
        HttpResponse response = http.send(request);
        system.debug(response.getStatusCode());
        system.debug(response);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug(results);
        }
        
        
        return results;
    }
    
    @AuraEnabled
    public static Boolean getCustomPermissionBool(){
        Boolean hasFriendSpacePermission = FeatureManagement.checkPermission('friendSpacePermission');
        return hasFriendSpacePermission;
    }
    
}