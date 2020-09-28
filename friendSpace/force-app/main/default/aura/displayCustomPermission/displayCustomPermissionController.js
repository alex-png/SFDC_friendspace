({
	doInit : function(component, event, helper) {
        console.log('yer')
		let getCustomPermissionBool = component.get("c.getCustomPermissionBool");
        getCustomPermissionBool.setCallback(this, (res)=>{
            let result = res.getReturnValue()
            console.log(result)
            component.set("v.hasFriendSpacePermission", result);
            console.log(component.get("v.hasFriendSpacePermission"))
        })
        $A.enqueueAction(getCustomPermissionBool);
    }
})