import ballerina/config;
import ballerina/log;
import wso2/gmail;

# A valid access token with gmail access.
string accessToken = config:getAsString("GMAIL_ACCESS_TOKEN");

# The client ID for your application.
string clientId = config:getAsString("GMAIL_CLIENT_ID");

# The client secret for your application.
string clientSecret = config:getAsString("GMAIL_CLIENT_SECRET");

# A valid refreshToken with gmail access.
string refreshToken = config:getAsString("GMAIL_REFRESH_TOKEN");

# Sender email address.
string senderEmail = config:getAsString("GMAIL_SENDER");

# The user's email address.
string userId = config:getAsString("GMAIL_USER_ID");

# GMail client endpoint declaration with oAuth2 client configurations.
endpoint gmail:Client gmailClient {
    clientConfig: {
        auth: {
            accessToken: accessToken,
            refreshToken: refreshToken,
            clientId: clientId,
            clientSecret: clientSecret
        }
    }
};

# Main function to run the integration system.
# + args - Runtime parameters
public function main(string... args) {
    log:printDebug("Gmail Integration -> Sending notification to customers");
    boolean result = sendNotification();
    if (result) {
        log:printDebug("Gmail Integration -> Sending notification to customers successfully completed!");
    } else {
        log:printDebug("Gmail Integration -> Sending notification to customers failed!");
    }
}

# Send notification to the customers.
# + return - State of whether the process of sending notification is success or not
function sendNotification() returns boolean {
    string CutomerName = "Sawani Dissanayake";
    string customerEmail = "esawani@gmail.com";
    string subject = "Thank You for Reservation";
    return sendMail(customerEmail, subject, getCustomEmailTemplate(CutomerName));
}


# Get the customized email template.
# + customerName - Name of the customer.
# + return - String customized email message.
function getCustomEmailTemplate(string customerName) returns (string) {
    string emailTemplate = "<h2> Hi " + customerName + " </h2>";
    emailTemplate = emailTemplate + "<h3> Thank you for your reservation "  + " ! </h3>";
    emailTemplate = emailTemplate + "<p> If you have any questions regarding the reservation" +
        ", please contact us and we will get in touch with you right away ! </p> ";
    return emailTemplate;
}

# Send email with the given message body to the specified recipient for dowloading the specified product.
# + customerEmail - Recipient's email address.
# + subject - Subject of the email.
# + messageBody - Email message body to send.
# + return - The status of sending email success or not
function sendMail(string customerEmail, string subject, string messageBody) returns boolean {
    //Create html message
    gmail:MessageRequest messageRequest;
    messageRequest.recipient = customerEmail;
    messageRequest.sender = senderEmail;
    messageRequest.subject = subject;
    messageRequest.messageBody = messageBody;
    messageRequest.contentType = gmail:TEXT_HTML;

    //Send mail
    var sendMessageResponse = gmailClient->sendMessage(userId, untaint messageRequest);
    string messageId;
    string threadId;
    match sendMessageResponse {
        (string, string) sendStatus => {
            (messageId, threadId) = sendStatus;
            log:printInfo("Sent email to " + customerEmail + " with message Id: " + messageId + " and thread Id:"
                    + threadId);
            return true;
        }
        gmail:GmailError e => {
            log:printInfo(e.message);
            return false;
        }
    }
}
