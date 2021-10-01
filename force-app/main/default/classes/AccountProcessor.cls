public class AccountProcessor{
    
    @future(callout=true)
    public static void countContacts(List<Id> AccountIds){
        
        List<AggregateResult> lstContactCount = [Select AccountId, Count(Id) ct
                                                 from Contact
                                                 Where AccountId in: AccountIds
                                                 group by AccountId];
        
        list<Account> lstAccountToUpdate = new list<Account>();
        
        for(AggregateResult obj:lstContactCount)
        {
            Account objAccount = new Account();
            
            objAccount.Id = string.valueOf(obj.get('AccountId'));
            objAccount.Number_of_Contacts__c =Integer.valueOf(obj.get('ct'));
            
            lstAccountToUpdate.add(objAccount);
        }
        
        if(lstAccountToUpdate.size() >0)
            update lstAccountToUpdate;
    }
}