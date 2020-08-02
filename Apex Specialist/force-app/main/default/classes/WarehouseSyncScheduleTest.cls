@isTest
public with sharing class WarehouseSyncScheduleTest {
    public static String sch = '0 0 8 * * ? *';

    @isTest
    public static void testScheduleJob() {
        Test.startTest();
        String jobId = System.schedule('Update equipment', sch, new WarehouseSyncSchedule());
        List<Product2> products = [SELECT Name FROM Product2];
        System.assertEquals(0, products.size(), 'Equipment is already updated');
        Test.stopTest();

        List<Product2> resultProducts = [SELECT Name FROM Product2];
        System.assertEquals(0, resultProducts.size(), 'Actual amount of products doesn\'t equal expected amount');
    }
}
