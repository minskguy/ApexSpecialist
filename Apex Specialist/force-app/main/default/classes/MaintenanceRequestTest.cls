@isTest
public with sharing class MaintenanceRequestTest {
    
    @TestSetup
    public static void setup(){
        List<Case> cases = new List<Case>();
        for(Integer i = 0; i < 25; i++) {
            Case caseTemp = new Case();
            caseTemp.Type = 'Repair';
            caseTemp.Status = 'New';
            caseTemp.Origin = 'Web';
            cases.add(caseTemp);
        }
        insert cases;
    }

    @isTest
    public static void testMaintenanceRequest() {
        List<Case> cases = [SELECT Type, Status, Vehicle__c, Equipment__c FROM Case];
        
        Test.startTest();
        for(Case c: cases)
            c.Status = 'Closed';
        List<Database.UpsertResult> listOfResults = Database.upsert(cases);
        Test.stopTest();

        for(Database.UpsertResult result: listOfResults) {
            System.assert(result.isSuccess());
            System.assert(result.getErrors().size() == 0);
        }

        List<Case> updatedCases = [SELECT Status FROM Case WHERE Status = 'Closed'];
        System.assertEquals(cases.size(), updatedCases.size());
    }
}