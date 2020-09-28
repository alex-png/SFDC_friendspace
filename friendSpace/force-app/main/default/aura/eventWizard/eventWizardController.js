({
    handleClick : function(component, event, helper) {
        if(event.getSource().get("v.name") == "meetNameEnter"){
            if(component.get("v.newMeet.Name") == ""){
                
            }else{                
                
                component.set("v.meetHasName", "true")
                
            }
        }
    },
    /*----------------------------------------NEW FUNCTION BELOW-------------------------------------------------------------------------*/
    restaurantInfoPassed: function(component, event, helper){
        //Get all the necessary information to pass to params of both createMeet and createInvite.
        //get child component information below
        let address = event.getParam("address") 
        let locationName = event.getParam("locationName")
        let imgSrc = event.getParam("img_src")
        //get child componenet information above
        
        let name = component.get("v.newMeet.Name")
        let dateTime = component.get("v.newMeet.Date_Time__c")        
        //because address and location name are coming from a child component, we must set them to an attribute in the parent component.
        component.set("v.newMeet.location_address__c", address)
        component.set("v.newMeet.Location_Name__c", locationName)
        
        //get the apex methods, set the params and fire it.
        let createMeet = component.get("c.createMeet")        
        createMeet.setParams({
            address: address,
            locationName: locationName,
            name: name,
            dateAndTime: dateTime,
            imgSrc: imgSrc,
        })
        
        createMeet.setCallback(this, (res)=>{
            if(res == "ERROR"){
            //DEBUG LATER: DOES res RETURN ERROR OR SHOULD WE CHECK FOR res.getReturnValue TO RETURN ERROR?
        }else{
                               console.log(res.getReturnValue());
        component.set("v.Success", "Success!")
    }
});
$A.enqueueAction(createMeet);
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
            component.set("v.Success", "");
            
        }, 1000);},
    /*----------------------------------------NEW FUNCTION BELOW-------------------------------------------------------------------------*/
    doInit: function(component, event, helper){
        let getFriends = component.get("c.getFriends");
        getFriends.setCallback(this, function(res){                    
            let result = res.getReturnValue();
            console.log('ALL FRIENDS:', result)
            component.set("v.listOfFriends", result);
        });
        $A.enqueueAction(getFriends);
    },
        /*----------------------------------------NEW FUNCTION BELOW-------------------------------------------------------------------------*/
        handleChange: function (component, event, helper) {
            // This will contain an array of the "value" attribute of the selected options
            let selectedOptionValue = event.getParam("value");
            
            component.set("v.invitedFriends", selectedOptionValue)
        }

})