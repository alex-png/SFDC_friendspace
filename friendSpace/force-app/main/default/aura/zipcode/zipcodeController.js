({
    handleChange : function(component, event, helper) {
		console.log('changed!');
        let inputValue = component.get("v.inputValue");
        console.log(inputValue);
    }
})