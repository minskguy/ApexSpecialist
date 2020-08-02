public with sharing class MaintenanceRequestHelper {
    public static void updateWorkOrders(List<case> closedCases) {
        List<Case> newCases = new List<Case>();

        for(Case closedCase : closedCases) {
            Case caseTemp = new Case(
                type='Routine Maintenance',
                Vehicle__c = closedCase.Vehicle__c,
                Equipment__c = closedCase.Equipment__c,
                Date_Reported__c = Date.today(),
                status = 'New',
                Date_Due__c = Date.today()
            );
            
            newCases.add(caseTemp);
        }
        insert newCases;
    }
}