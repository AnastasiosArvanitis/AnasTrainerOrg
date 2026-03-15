/**
 * @description Utility class containing simple utility methods for mathematical operations and string validation
 * @author Anastasios Arvanitis
 * @date January 2026
 */
public with sharing class Utility {
    
    /**
     * @description Simple method to check if a string is empty or null
     * @param str String to check
     * @return True if string is empty or null, false otherwise
     */
    public static Boolean isEmpty(String str) {
        return String.isBlank(str);
    }
    
    /**
     * @description Get greeting message for a given name
     * @param name Person's name
     * @return Greeting message
     */
    public static String greet(String name) {
        if (String.isBlank(name)) {
            return 'Hello, Guest!';
        }
        return 'Hello, ' + name + '!';
    }

    // --- PMD TEST VIOLATIONS ---

    // PRIORITY 1: EmptyCatchBlock
    public static void riskyOperation() {
        try {
            Integer x = 1 / 0;
        } catch (Exception e) {
            // empty catch block - intentional PMD violation (P1: EmptyCatchBlock)
        }
    }

    // PRIORITY 1: EmptyIfStmt
    public static void checkValue(Integer val) {
        if (val > 0) {
            // empty if body - intentional PMD violation (P1: EmptyIfStmt)
        }
    }

    // PRIORITY 1: ApexDoc - method missing @description
    public static String noDocMethod(String input) {
        return input;
    }

    // PRIORITY 2: DebugsShouldUseLoggingLevel + UnusedLocalVariable + IfStmtsMustUseBraces
    public static void debugExample(String msg) {
        String unusedVar = 'I am never used'; // P2: UnusedLocalVariable
        System.debug(msg);                    // P2: DebugsShouldUseLoggingLevel
        if (msg != null)                      // P2: IfStmtsMustUseBraces
            System.debug(msg);
    }
}