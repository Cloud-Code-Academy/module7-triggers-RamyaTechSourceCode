public with sharing class AccountTriggerHandler {
       
    public static void setTypeProspect(List<Account> accounts)
    {
        For(Account a:accounts)
        {
           if(a.Type == null)
           {
                a.Type = 'Prospect';
           }
        }
    }
    public static void addressCopy(List<Account> accounts)
    {
        For(Account a:accounts)
        {
            if(a.ShippingAddress == null)
            {
                a.BillingStreet  = a.ShippingStreet;
                a.BillingCity = a.ShippingCity;
                a.BillingState = a.ShippingState;
                a.BillingPostalCode = a.ShippingPostalCode;
                a.BillingCountry = a.ShippingCountry;
            }
        }
    }
    public static void setRating(List<Account> accounts)
    {
        for(Account a:accounts)
        {
           if(a.Phone != null && a.Website !=null && a.Fax !=null)
           {
                a.Rating = 'Hot';
           }
        }
    }
    public static void defaultContact(List<Account> accounts)
    {
        List<Contact> contacts = new List<Contact>();
        for(Account acc : accounts)
        {
           Contact con = new Contact();
           con.AccountId = acc.Id;
           con.LastName = 'DefaultContact';
           con.Email = 'default@email.com';
           con.MailingPostalCode =  acc.ShippingPostalCode;
           contacts.add(con);
        }
        insert contacts;
    }
   
}