@IsTest
private class WarehouseCalloutServiceTest {
    
    @isTest
    public static void testPostCallout() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        
        Test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();

        List<Product2> listOfProducts = [SELECT Name FROM Product2];
        System.assertEquals(3, listOfProducts.size(), 'Actual amount of products doesn\'t equal expected amount');

    }
}