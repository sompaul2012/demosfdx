({
	doInit : function(component, event, helper) {
        console.log('In controller');
        var prodId= component.get("v.ProductId");
        var latency = component.get("v.Latency");
		helper.executeContinuation(component,prodId,latency);
	}
})