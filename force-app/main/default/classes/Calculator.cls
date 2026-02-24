/**
 * @description Provides simple arithmetic operations: addition, multiplication, and subtraction.
 * @author Anastasios Arvanitis
 * @date February 2026
 */
public with sharing class Calculator {
    /**
     * @description Simple method to add two numbers
     * @param a First number
     * @param b Second number
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
}