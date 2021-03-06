# BallerinaGmailSender

- Go through the following steps to obtain credetials and tokens for Gmail APIs.
    1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard 
    to create a new project.
    2. Enable both Gmail APIs for the project.
    3. Go to **Credentials -> OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
    4. On the **Credentials** tab, click **Create credentials** and select **OAuth client ID**. 
    5. Select an application type, enter a name for the application, and specify a redirect URI 
    (enter https://developers.google.com/oauthplayground if you want to use 
    [OAuth 2.0 playground](https://developers.google.com/oauthplayground) to receive the authorization code and obtain the 
    access token and refresh token). 
    6. Click **Create**. Your client ID and client secret appear. 
    7. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground), 
    select the required Gmail and Google Sheets API scopes, and then click **Authorize APIs**.
    8. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh 
    token and access token.         

  You must configure the `ballerina.conf` configuration file with the above obtained tokens, credentials and 
  other important parameters.
  
  
