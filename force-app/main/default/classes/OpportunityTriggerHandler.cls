public with sharing class OpportunityTriggerHandler {
   
    public static void amountValidation(List<Opportunity> opportunities)
    {
        for(Opportunity opp:opportunities)
        {
            if(opp.Amount < 5000)
            {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }
    public static void deleteCloseWonOpportunity(List<Opportunity> opportunities)
    {
       Set<Id> accountIds = new Set<Id>();
       for(Opportunity opp:opportunities)
       {
            if(opp.StageName == 'Closed Won')
            {
             accountIds.add(opp.AccountId);
            }
       }
       Map<Id,Account> accounts = new Map<Id,Account>([SELECT Id, Industry
                                                       FROM Account
                                                       WHERE Id IN :accountIds]);
        for(Opportunity opp:opportunities)
        {
            if(opp.StageName == 'Closed Won' && accounts.containsKey(opp.AccountId))
            {
               If(accounts.get(opp.AccountId).Industry == 'Banking')
               {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
               }
            }
        }                    
    }
    public static void setPrimaryContact(List<Opportunity> opportunities)
    {
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp:opportunities)
        {
             accountIds.add(opp.AccountId);
        } 
        Map<Id, Contact> contacts = new Map<Id, Contact>();
        for (Contact con : [SELECT Id, AccountId 
                            FROM Contact 
                            WHERE Title = 'CEO' AND AccountId IN :accountIds]) {
            contacts.put(con.AccountId, con);
        }
        
        for(Opportunity opp:opportunities)
        {  
            if(contacts.containsKey(opp.AccountId))
            {
                opp.Primary_Contact__c = contacts.get(opp.AccountId).Id;
            }
        }        
    }
    
}