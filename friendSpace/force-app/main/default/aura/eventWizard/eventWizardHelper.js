({
    restart : function() {
        setTimeout(function(){
            component.set("v.newMeet", `{ 
                          'sobjectType':'Meet_c',
                          'OwnerId': 'null',
                          'Name': '',
                          'Date_Time__c': '',
                          'location_address__c': '',
                          'Location_Name__c': '',
                          'img_src' : ''
                          }`);
            component.set("v.meetHasName", false);
            
        }, 1000);
        
    }
})