({
	onCallApex : function(component, event, helper) {
        var params = event.getParams().arguments;
        var callerComponent = params.component;
        var controllerMethod = params.controllerMethod;
        var actionParameters = params.actionParameters;
        var successCallback = params.successCallback;
        var reference = params.reference;
        helper.callApex(callerComponent, controllerMethod, actionParameters, successCallback,reference);
	}
})