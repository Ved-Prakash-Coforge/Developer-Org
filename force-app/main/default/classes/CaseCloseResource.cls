@RestResource(urlMapping='/case/*/close')
global class CaseCloseResource 
{
    @httpPost
    global static void closeCase(String closeReason)
    {
        System.debug('SKA - HTTPPOST - ' + closeReason + ' - ' + RestContext.request.requestURI);
         // Parse context
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        Id caseId = uriParts[2];
        // Call the service
        CaseService.closeCases(new Set<ID> { caseId }, closeReason);  
        
    }
}