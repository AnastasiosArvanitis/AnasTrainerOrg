/* 
Testing commits
*/
public with sharing class Test {
    public Test() {

    }
    
    public void testMethod() {
        String unusedVar = 'This will trigger UnusedLocalVariable';
        
        Integer x = 5;
        if (x > 0)
            System.debug('No braces - triggers IfStmtsMustUseBraces');
    }
    // test comment
}