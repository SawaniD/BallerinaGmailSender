import ballerina/log;
import ballerina/test;

@test:Config
function testSendSmsToLeads() {
    log:printDebug("Gmail Integration -> Sending notification to customers");
    boolean result = sendNotification();
    test:assertTrue(result, msg = "Gmail- Integration -> Sending notification to customers successfull!");
}