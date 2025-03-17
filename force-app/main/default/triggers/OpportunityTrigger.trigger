trigger OpportunityTrigger on Opportunity (before update,before delete) {

     if(Trigger.isUpdate && Trigger.isBefore)
     {
       OpportunityTriggerHandler.amountValidation(Trigger.new);
       OpportunityTriggerHandler.setPrimaryContact(Trigger.new);
     }
     if(Trigger.isBefore && Trigger.isDelete)
     {
        OpportunityTriggerHandler.deleteCloseWonOpportunity(Trigger.old);
     }
}