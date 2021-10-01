@isTest
global class AccountCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        // Create a fake response test ved prakash
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status":"success"}');
        res.setStatusCode(200);
        return res; 
    }
}