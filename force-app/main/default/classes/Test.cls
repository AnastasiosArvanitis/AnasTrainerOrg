/**
 * @description Test class containing simple utility methods for mathematical operations and string validation
 * @author Anastasios Arvanitis
 * @date January 2026
 */
public with sharing class Test {
    
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
    }
    
    /**
     * @description Simple method to check if a string is empty or null
     * @param str String to check
     * @return True if string is empty or null, false otherwise
     */
    public static Boolean isEmpty(String str) {
        return String.isBlank(str);
    }
}