({
    executeContinuation: function(component,productId,latency){
        component.find("Service").callApex(component,"c.getProduct",
                                           {"productId":productId,"latency":latency},
                                           this.getProductSuccess,this);
    },
    getProductSuccess: function(component,returnValue,ref){
        var response = returnValue;
        var plainText = response.replace(/&quot;/g, '"').replace(/&#39;/g, "'");
        console.log(plainText);
        component.set("v.successcallback",true);
        component.set("v.Response",plainText);
        var responseJson = JSON.parse(plainText);
        console.log(responseJson.description);
        component.set("v.description",responseJson.description);
        component.set("v.imgage",responseJson.picture);
        component.set("v.category",responseJson.category);
        component.set("v.prodName",responseJson.name);
    },
})