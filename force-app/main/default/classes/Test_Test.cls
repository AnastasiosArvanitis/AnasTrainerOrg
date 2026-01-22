@isTest
private class Test_Test {
    
    @isTest
    static void testAdd() {
        // Test addition method
        Integer result = Test.add(5, 3);
        System.assertEquals(8, result, 'Addition should return 8');
        
        // Test with negative numbers
        Integer result2 = Test.add(-5, 3);
        System.assertEquals(-2, result2, 'Addition with negative number should return -2');
        
        // Test with zero
        Integer result3 = Test.add(0, 10);
        System.assertEquals(10, result3, 'Addition with zero should return 10');
    }
    
    @isTest
    static void testMultiply() {
        // Test multiplication method
        Integer result = Test.multiply(4, 5);
        System.assertEquals(20, result, 'Multiplication should return 20');
        
        // Test with negative numbers
        Integer result2 = Test.multiply(-3, 4);
        System.assertEquals(-12, result2, 'Multiplication with negative number should return -12');
        
        // Test with zero
        Integer result3 = Test.multiply(5, 0);
        System.assertEquals(0, result3, 'Multiplication with zero should return 0');
    }
    
    @isTest
    static void testIsEmpty() {
        // Test with null string
        Boolean result1 = Test.isEmpty(null);
        System.assertEquals(true, result1, 'Null string should return true');
        
        // Test with empty string
        Boolean result2 = Test.isEmpty('');
        System.assertEquals(true, result2, 'Empty string should return true');
        
        // Test with whitespace
        Boolean result3 = Test.isEmpty('   ');
        System.assertEquals(true, result3, 'Whitespace string should return true');
        
        // Test with valid string
        Boolean result4 = Test.isEmpty('Hello');
        System.assertEquals(false, result4, 'Valid string should return false');
    }
    
    @isTest
    static void testGreet() {
        // Test with valid name
        String result1 = Test.greet('John');
        System.assertEquals('Hello, John!', result1, 'Should return greeting with name');
        
        // Test with null name
        String result2 = Test.greet(null);
        System.assertEquals('Hello, Guest!', result2, 'Should return guest greeting for null');
        
        // Test with empty name
        String result3 = Test.greet('');
        System.assertEquals('Hello, Guest!', result3, 'Should return guest greeting for empty string');
        
        // Test with whitespace name
        String result4 = Test.greet('   ');
        System.assertEquals('Hello, Guest!', result4, 'Should return guest greeting for whitespace');
    }
}
