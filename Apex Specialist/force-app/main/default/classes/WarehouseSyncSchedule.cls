public with sharing class WarehouseSyncSchedule implements schedulable {
    global void execute(SchedulableContext sc) {
        WarehouseCalloutService.runWarehouseEquipmentSync();  
    }
}
  