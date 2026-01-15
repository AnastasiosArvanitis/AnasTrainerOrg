/* 
Testing PMD violations for Copilot PR review - FIXED VERSION
*/

/**
 * @description Test class for demonstrating PMD violation fixes
 * @author Copilot Team
 * @date 2026-01-15
 */
public with sharing class Test {
    
    /**
     * @description Processes input data with proper error handling
     * @param input The string input to process
     */
    public void processData(String input) {
        Integer count = 5;
        if (count > 0) {
            System.debug(LoggingLevel.DEBUG, 'Count is positive: ' + count);
        }
        
        try {
            Integer result = Integer.valueOf(input);
            System.debug(LoggingLevel.INFO, 'Parsed result: ' + result);
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error parsing input: ' + e.getMessage());
        }
        
        Integer index = 0;
        while (index < 3) {
            index++;
        }
        
        System.debug(LoggingLevel.DEBUG, 'Processing completed successfully');
    }
}