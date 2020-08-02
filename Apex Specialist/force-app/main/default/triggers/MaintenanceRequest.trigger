trigger MaintenanceRequest on Case (before update, after update) {
    List<Case> closedCases = new List<Case>();

    for(Case caseTemp : Trigger.new) {
        if(caseTemp.status == 'Closed' 
        && (caseTemp.type == 'Routine Maintenance' || caseTemp.type == 'Repair')) {
            closedCases.add(caseTemp);
        }
    }

    if(closedCases.size() > 0) {
        MaintenanceRequestHelper.updateWorkOrders(closedCases);
    }
}