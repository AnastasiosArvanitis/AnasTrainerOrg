/**
 * @description Unit test class for Calculator arithmetic methods.
 */
@isTest
public with sharing class Calculator_Test {
    @isTest
    static void CalculatorAdd() {
        // basic positive numbers
        System.assertEquals(8, Calculator.add(5, 3), '5 + 3 should equal 8');
        // negative and zero
        System.assertEquals(-2, Calculator.add(-5, 3), '-5 + 3 should equal -2');
        System.assertEquals(10, Calculator.add(0, 10), '0 + 10 should equal 10');
    }

    /* 
    
    BIG COMMENT HERE

    */

    @isTest
    static void CalculatorMultiply() {
        // basic multiplication
        System.assertEquals(20, Calculator.multiply(4, 5), '4 * 5 should equal 20');
        // negative and zero
        System.assertEquals(-12, Calculator.multiply(-3, 4), '-3 * 4 should equal -12');
        System.assertEquals(0, Calculator.multiply(5, 0), '5 * 0 should equal 0');
    }

    @isTest
    static void CalculatorSubtract() {
        // basic subtraction
        System.assertEquals(2, Calculator.subtract(5, 3), '5 - 3 should equal 2');
        // negative and zero
        System.assertEquals(-8, Calculator.subtract(-5, 3), '-5 - 3 should equal -8');
        System.assertEquals(10, Calculator.subtract(10, 0), '10 - 0 should equal 10');
    }
}