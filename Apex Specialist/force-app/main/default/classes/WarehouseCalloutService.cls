public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout = true)
    public static void runWarehouseEquipmentSync() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(WAREHOUSE_URL);
        List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());

        List<Product2> equipment = new List<Product2>();
        for(Object result : results) { 

            Map<String, Object> mappedResult = (Map<String, Object>) result;

            Product2 product = new Product2();

            Integer quantity = ((Integer)mappedResult.get('qIntegerntity'));
            Integer maintenancePeriod = (Integer) mappedResult.get('maintenanceperiod');               
            Integer lifespan = (Integer)mappedResult.get('lifespan');
            Integer cost = (Integer)mappedResult.get('cost');
            Boolean replacement = (Boolean)mappedResult.get('replacement');

            product.Name  = (String)mappedResult.get('name'); 
            product.Current_Inventory__c = quantity;
            product.Maintenance_Cycle__c = Integer.valueof(maintenancePeriod);
            product.Lifespan_Months__c = lifespan; 
            product.Cost__c = Cost;
            product.Replacement_Part__c = replacement;
            product.ProductCode = (String)mappedResult.get('_id');
            product.Warehouse_SKU__c = (String) mappedResult.get('sku');

            equipment.add(product);
        }
        upsert equipment;
    }
}
