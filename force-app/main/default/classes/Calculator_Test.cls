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

    @isTest
    static void CalculatorDivide() {
        // basic division
        System.assertEquals(4, Calculator.divide(20, 5), '20 / 5 should equal 4');
        // decimal result
        System.assertEquals(2.5, Calculator.divide(5, 2), '5 / 2 should equal 2.5');
        // division by zero should throw
        try {
            Calculator.divide(10, 0);
            System.assert(false, 'Expected an exception for division by zero');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Division by zero is not allowed.', e.getMessage());
        }
    }

    @isTest
    static void CalculatorModulo() {
        // basic remainder
        System.assertEquals(1, Calculator.modulo(10, 3), '10 mod 3 should equal 1');
        // zero remainder
        System.assertEquals(0, Calculator.modulo(10, 5), '10 mod 5 should equal 0');
        // modulo by zero should throw
        try {
            Calculator.modulo(10, 0);
            System.assert(false, 'Expected an exception for division by zero');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Division by zero is not allowed.', e.getMessage());
        }
    }

    @isTest
    static void CalculatorPower() {
        // basic power
        System.assertEquals(8.0, Calculator.power(2, 3), '2^3 should equal 8');
        // power of zero
        System.assertEquals(1.0, Calculator.power(5, 0), '5^0 should equal 1');
        // negative exponent should throw
        try {
            Calculator.power(2, -1);
            System.assert(false, 'Expected an exception for negative exponent');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Exponent must be non-negative.', e.getMessage());
        }
    }
}