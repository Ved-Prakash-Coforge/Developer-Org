trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    List<Task> lstTask = new List<Task>();
    
    for(Opportunity objOpp : Trigger.New)
    {
        if(objOpp.StageName == 'Closed Won')
        {
            Task objTask = new Task();
            objTask.Subject = 'Follow Up Test Task';
            objTask.WhatId = objOpp.Id;
            
            lstTask.add(objTask);
        }
    }
    
    if(lstTask.Size() > 0)
    {
        insert lstTask;
    }
}