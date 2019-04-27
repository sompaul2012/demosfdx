global with sharing class ApexContinuationClass {
    
    @AuraEnabled(continuation=true cacheable=true)
    global static Object getProduct(Integer productId, Integer latency){
        
        // Make an HTTPRequest as we normally would
        // Remember to configure a Remote Site Setting for the service!
        String url = 'https://long-running.herokuapp.com/products/' + productId + '?latency=' + latency;
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(url);
        
        // Create a Continuation for the HTTPRequest        
        Continuation con = new Continuation(60);
        con.state = con.addHttpRequest(req);
        con.continuationMethod = 'callback';        
        
        // Return it to the system for processing
        System.debug('returned from server'+con);
        return con;
    }
    @AuraEnabled(cacheable=true)
    global static Object callback(Object state) {
        HttpResponse response = Continuation.getResponse((String)state);
        
        Integer statusCode = response.getStatusCode();
        if (statusCode >= 2000) {
            return 'Continuation error: ' + statusCode;
        }
        System.debug('response @@'+response.getBody()+'Status code'+statusCode);
        return response.getBody();
    }
}