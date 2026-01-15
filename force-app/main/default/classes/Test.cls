/* 
Testing PMD violations for Copilot PR review
*/
public with sharing class Test {
    
    public void processData(String input) {
        String unusedVariable = 'This triggers UnusedLocalVariable';
        
        Integer count = 5;
        if (count > 0)
            System.debug('No braces - triggers IfStmtsMustUseBraces');
        
        try {
            Integer result = Integer.valueOf(input);
        } catch (Exception e) {
            // Empty catch block - Priority 1 violation
        }
        
        Integer index = 0;
        while (index < 3)
            index++;
        
        System.debug('No log level - triggers DebugsShouldUseLoggingLevel');
    }
    
    private void helperMethod() {
        String data = 'This method is never called - triggers UnusedMethod';
    }
}