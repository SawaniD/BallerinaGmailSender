import ballerina/log;
import ballerina/test;

@test:Config
function testGmailSender() {
    log:printDebug("Gmail Integration -> Sending notification to customers");
    EmailData emailData = new EmailData();
    emailData.cutomerName = "Sawani Dissanayake";
    emailData.customerEmail = "esawani@gmail.com";
    emailData.subject = "Thank You for Reservation";
    boolean result = sendNotification(emailData);
    test:assertTrue(result, msg = "Gmail- Integration -> Sending notification to customers successfull!");
}
