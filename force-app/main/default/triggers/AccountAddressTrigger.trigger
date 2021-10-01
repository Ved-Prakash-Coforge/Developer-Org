trigger AccountAddressTrigger on Account (before insert, before update) {
    
    for(Account objAccount : Trigger.New)
    {
        if(objAccount.Match_Billing_Address__c)
        {
            objAccount.ShippingPostalCode = objAccount.BillingPostalCode;
        }
    }
}