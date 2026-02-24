@isTest
private class Utility_Test {

    @isTest
    static void testIsEmpty() {
        // null and empty
        System.assertEquals(true, Utility.isEmpty(null), 'null should be considered empty');
        System.assertEquals(true, Utility.isEmpty(''), 'empty string should be considered empty');
        // whitespace
        System.assertEquals(true, Utility.isEmpty('   '), 'whitespace should be considered empty');
        // non-empty
        System.assertEquals(false, Utility.isEmpty('Hello'), 'non-empty string should not be considered empty');
    }

    @isTest
    static void testGreet() {
        // valid name
        System.assertEquals('Hello, John!', Utility.greet('John'), 'Should greet by name');
        // null / empty / whitespace
        System.assertEquals('Hello, Guest!', Utility.greet(null), 'null should greet Guest');
        System.assertEquals('Hello, Guest!', Utility.greet(''), 'empty should greet Guest');
        System.assertEquals('Hello, Guest!', Utility.greet('   '), 'whitespace should greet Guest');
    }
}
