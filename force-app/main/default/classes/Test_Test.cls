@isTest
private class Test_Test {
    
    @isTest
    static void testAdd() {
        // basic positive numbers
        System.assertEquals(8, Test.add(5, 3), '5 + 3 should equal 8');
        // negative and zero
        System.assertEquals(-2, Test.add(-5, 3), '-5 + 3 should equal -2');
        System.assertEquals(10, Test.add(0, 10), '0 + 10 should equal 10');
    }

    @isTest
    static void testMultiply() {
        // basic multiplication
        System.assertEquals(20, Test.multiply(4, 5), '4 * 5 should equal 20');
        // negative and zero
        System.assertEquals(-12, Test.multiply(-3, 4), '-3 * 4 should equal -12');
        System.assertEquals(0, Test.multiply(5, 0), '5 * 0 should equal 0');
    }

    @isTest
    static void testSubtract() {
        // basic subtraction
        System.assertEquals(2, Test.subtract(5, 3), '5 - 3 should equal 2');
        // negative and zero
        System.assertEquals(-8, Test.subtract(-5, 3), '-5 - 3 should equal -8');
        System.assertEquals(10, Test.subtract(10, 0), '10 - 0 should equal 10');
    }

    @isTest
    static void testIsEven() {
        System.assertEquals(true, Test.isEven(4), '4 should be even');
        System.assertEquals(false, Test.isEven(5), '5 should be odd');
        System.assertEquals(true, Test.isEven(0), '0 should be even');
        System.assertEquals(false, Test.isEven(null), 'null should not be even');
    }

    @isTest
    static void testIsEmpty() {
        // null and empty
        System.assertEquals(true, Test.isEmpty(null), 'null should be considered empty');
        System.assertEquals(true, Test.isEmpty(''), 'empty string should be considered empty');
        // whitespace
        System.assertEquals(true, Test.isEmpty('   '), 'whitespace should be considered empty');
        // non-empty
        System.assertEquals(false, Test.isEmpty('Hello'), 'non-empty string should not be considered empty');
    }

    @isTest
    static void testGreet() {
        // valid name
        System.assertEquals('Hello, John!', Test.greet('John'), 'Should greet by name');
        // null / empty / whitespace
        System.assertEquals('Hello, Guest!', Test.greet(null), 'null should greet Guest');
        System.assertEquals('Hello, Guest!', Test.greet(''), 'empty should greet Guest');
        System.assertEquals('Hello, Guest!', Test.greet('   '), 'whitespace should greet Guest');
    }
}
