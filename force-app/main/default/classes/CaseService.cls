public with sharing class CaseService {
    //ved comments
    public static void closeCases(Set<Id> caseIds, String reason) {
        List<Case> casesToUpdate = [SELECT Status, Reason FROM Case WHERE Id in :caseIds];
        
        for (Case c : casesToUpdate) {
            c.Status = 'Closed';
            c.Reason = reason;
        }
        
        update casesToUpdate ;
    }
}