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

function sendNotification(EmailData emailData) returns boolean {
    return sendMail(emailData.customerEmail, emailData.subject, getCustomEmailTemplate(emailData.cutomerName));
}

function getCustomEmailTemplate(string customerName) returns (string) {
    string emailTemplate = "<h2> Hi " + customerName + " </h2>";
    emailTemplate = emailTemplate + "<h3> Thank you for your reservation "  + " ! </h3>";
    emailTemplate = emailTemplate + "<p> If you have any questions regarding the reservation" +
        ", please contact us and we will get in touch with you right away ! </p> ";
    return emailTemplate;
}

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
