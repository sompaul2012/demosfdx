({
	callApex: function(component, controllerMethod, actionParameters, successCallback,reference) {
        var action = component.get(controllerMethod);
        if(actionParameters){
        	action.setParams(actionParameters);
        }
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                successCallback(component, response.getReturnValue(),reference)
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            component.set("v.errormessage",errors[0].message);
                        }
                    } else {
                        component.set("v.errormessage","Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
    }
})