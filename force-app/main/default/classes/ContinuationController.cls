public with sharing class ContinuationController {
    // Unique label corresponding to the continuation
    public static String requestLabel;
    // Result of callout
    public String result {get;set;}
    // Callout endpoint as a named credential URL 
    // or, as shown here, as the long-running service URL
    private static final String LONG_RUNNING_SERVICE_URL = 
        'http://services.groupkt.com/country/get/iso2code/IN';
    //https://long-running.herokuapp.com/products/1?latency=60;
   
   // Action method
    public static Object startRequest() {
      // Create continuation with a timeout
      Continuation con = new Continuation(60);
      // Set callback method
      con.continuationMethod='processResponse';
      
      // Create callout request
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setEndpoint('http://services.groupkt.com/country/get/iso2code/IN');
      
      // Add callout request to continuation
      requestLabel = con.addHttpRequest(req);
      
      // Return the continuation
      return con;  
    }
    
    // Callback method 
    public Object processResponse() {   
      // Get the response by using the unique label
      System.debug('request label@@'+requestLabel);
      HttpResponse response = Continuation.getResponse(requestLabel);
      // Set the result variable that is displayed on the Visualforce page
      this.result = response.getBody();
      system.debug('response@@'+response.getBody());
      // Return null to re-render the original Visualforce page
      return response.getBody();
    }
}