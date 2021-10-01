public class ContactAuraController {
    @AuraEnabled
    public static ContactDataTableWrapper getContactData(Integer pageNumber, Integer pageSize) {
         
        //Offset for SOQL
        Integer offset = (pageNumber - 1) * pageSize;
         
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Contact];
        Integer recordEnd = pageSize * pageNumber;
 
        //Instance of Contact DataTable Wrapper Class
        ContactDataTableWrapper objDT =  new ContactDataTableWrapper();  
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.contactList = [SELECT Id, Name, Phone, Email FROM Contact ORDER BY Name LIMIT :pageSize OFFSET :offset];
        return objDT;
    }
     
    //Wrapper Class For Contact DataTable  
    public class ContactDataTableWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Contact> contactList {get;set;}
    }
}