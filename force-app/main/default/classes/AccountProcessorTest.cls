@IsTest
private class AccountProcessorTest {

  @IsTest
  private static void testAccountProcessor() {
    Test.setMock(HttpCalloutMock.class, new AccountCalloutMock());
    Test.startTest();
    
    List<Id> lstAccount = new List<Id>();
    Account objAccount = new Account();
    objAccount.Name = 'abc';
    
    insert objAccount;
    
    Contact objContact = new Contact();
    objContact.AccountId = objAccount.Id;
    objContact.LastName = 'xyz';
    
    insert objContact;
    
    lstAccount.add(objAccount.Id);
    
    AccountProcessor.countContacts(lstAccount);
    Test.stopTest();
  }

}