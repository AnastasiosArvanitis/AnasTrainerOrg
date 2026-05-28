/**
 * @description Provides simple arithmetic operations: addition, multiplication, and subtraction.
 * @author Anastasios Arvanitis
 * @date February 2026
 */
public with sharing class Calculator {
     * @return Sum of a and b
     */
    public static Integer add(Integer a, Integer b) {
        return a + b;
    }
    
    /**
     * @description Simple method to multiply two numbers
     * @param a First number
     * @param b Second number
     * @return Product of a and b
     */
    public static Integer multiply(Integer a, Integer b) {
        return a * b;
        // great job
    }

    /**
     * @description Simple method to subtract two numbers
     * @param a First number
     * @param b Second number
     * @return a minus b
     */
    public static Integer subtract(Integer a, Integer b) {
        return a - b;
    }

    /**
     * @description Simple method to divide two numbers
     * @param a Dividend
     * @param b Divisor (must not be zero)
     * @return a divided by b
     */
    public static Decimal divide(Integer a, Integer b) {
        if (b == 0) {
            throw new IllegalArgumentException('Division by zero is not allowed.');
        }
        return (Decimal) a / b;
    }

    /**
     * @description Simple method to get the remainder of two numbers
     * @param a Dividend
     * @param b Divisor (must not be zero)
     * @return Remainder of a divided by b
     */
    public static Integer modulo(Integer a, Integer b) {
        if (b == 0) {
            throw new IllegalArgumentException('Division by zero is not allowed.');
        }
        return Math.mod(a, b);
    }

    /**
     * @description Simple method to raise a number to a power
     * @param base The base number
     * @param exponent The exponent (must be non-negative)
     * @return base raised to the power of exponent
     */
    public static Decimal power(Integer base, Integer exponent) {
        if (exponent < 0) {
            throw new IllegalArgumentException('Exponent must be non-negative.');
        }
        return Math.pow(base, exponent);
    }
}