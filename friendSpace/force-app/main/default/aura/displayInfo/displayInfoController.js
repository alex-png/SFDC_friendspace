({
    handleClick : function(component, event, helper) {
        let zipcode = component.get("v.inputValue");
        let getInfo = component.get("c.getInfo");
        getInfo.setParams({zipcode: zipcode});
        getInfo.setCallback(this, (res)=>{
            let result = res.getReturnValue();
            let businesses = result.businesses;
            component.set("v.listOfPlaces", businesses);
            component.set("v.placeFetched", "true");	
        });
        $A.enqueueAction(getInfo);
    },
    
    handleChange : function(component, event, helper) {
        let inputValue = component.get("v.inputValue");
    },     
    
    fireRestaurantEvent : function(component, event, helper){
        //fire the custom event;
        //get the restaurants information.        
        let customEvent = component.getEvent("restaurantEvent");
        let num = parseInt(event.getSource().get("v.name"));
        let info = component.get("v.listOfPlaces["+num+"].location.address1")
        let locationName = component.get("v.listOfPlaces["+num+"].name")
        let img = component.get("v.listOfPlaces["+num+"].image_url")
        customEvent.setParams({
            "address" : info,
            "locationName": locationName,
            "img_src" : img
        })
        customEvent.fire()
    }
    
})