public with sharing class BlogHomeController 
{
    private Integer offset {get;set;}
    public transient List<Account> blogWrappers {get; set;}
    public String comname {get; set;} 
    public String combody {get; set;}
    public String comblogid {get; set;}
    public String searchStr {get; set;}
    
    public BlogHomeController()
    {
        offset=0;
        setupBlogs();
    }
    
    private void setupBlogs()
    {
        setupBlogs(null);
    }
    
    private void setupBlogs(List<Account> posts)
    {
        if (null==blogWrappers)
        {
            blogWrappers=new List<Account>(); 
        
            String query='select id, Name ' +
                        '               from Account ';
           
        
            query+='                order by createddate desc limit 5 offset :offset ';
        
            List<Account> blogs=Database.query(query);

            for (Account blog : blogs)
            {
                blogWrappers.add(blog);
            }
        }
    }
    
    public void addComment()
    {
        /*Blog_Comment__c comment=new Blog_Comment__c();
        comment.Blog_Post__c=comblogid;
        comment.Name__c=comname;
        comment.Body__c=combody;
        comment.Posted__c=System.now();
        
        insert comment;
        
        setupBlogs();*/
    }
    
    public void doSearch()
    {
        /*List<List<Blog_Post__c>> allObjs=[find :searchStr returning Blog_Post__c(id) limit 5];
        setupBlogs(allObjs[0]);*/
    }
}