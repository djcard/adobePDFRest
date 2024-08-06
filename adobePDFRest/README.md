# Adobe PDF Rest
A CFML implementation of the Adobe PDF generation Rest API

## Installation

`box install adobePDFRest`

## Configuration

ColdBox Variables
credentialPath - The path to the JSON file received from Adobe. Defaults to the PDF_API_CREDENTIAL_PATH env variable.
expireJWTHours - The number of hours to expire the JWT used to obtain the API Key. Defaults to the PDF_API_EXPIRE_JWT_HOURS env variable. Works best with values over 6. 

.env variables
PDF_API_CREDENTIAL_PATH - Relative path to the pdfservices-api-credentials.json received from Adobe at registration including the file name.
PDF_API_EXPIRE_JWT_HOURS - the number of hours in which to expire the JWT used to get the API Token
PDF_API_CREDENTIAL_METHOD - The credential style for your API project "Oauth|JWT". To preserve backwards compatability, JWT is the default and only the Oauth value changes behavior.
PDF_API_SCOPES - The scopes requested for the access token. Defaults to openid,AdobeID,DCAPI which are needed for the PDF API.

For More Information: https://developer.adobe.com/document-services/apis/doc-generation/

Using the Adobe Credentials With JWT- ** IMPORTANT **
If using the JWT method, there are three steps which needs to happen to use the credentials downloaded from the Adobe site
1. Convert the private.key file using OpenSSL. After installing OpenSSL, open a command line tool and use this command: OpenSSL pkcs8 -topk8 -nocrypt -in private.key -out nameOfTheNewKey
2. Open the folder downloaded from teh Adobe site and open the pdfservices-api-credentials.json file. Change the "private_key_file" key to point to the newly created key created in step 1. 
3. Point the PDF_API_CREDENTIAL_PATH env variable to the pdfservices-api-credentials.json. 

## History

0.0.12 - Removed Scribe due to some compatability issues reported.
0.0.11 - fixed defaut to JWT setting
0.0.10 - Added support for the Oauth Server to Server method.
0.0.9 - Improvements based on further review. Better formatting
0.0.8 - Better Handling of failed Polling. Added the pollPauseTime property to control how long to pause between polling attempts.
0.0.7 - moved project from submodule to main level
0.0.6 - Bumped the version of cfscribe being used
0.0.5 - fixed using expandpath() around all pathnames to ensure compatability
0.0.3 - added documentation about the license conversion
0.0.2 - removed outdated dependencies
