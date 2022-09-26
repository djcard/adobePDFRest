# adobePDFRest
A CFML implementation of the Adobe PDF generation Rest API

##Installation

``box install adobePdfGenerationAPI``

##Configuration

ColdBox Variables
credentialPath - The path to the JSON file received from Adobe. Defaults to the PDF_API_CREDENTIAL_PATH env variable.
expireJWTHours - The number of hours to expire the JWT used to obtain the API Key. Defaults to the PDF_API_EXPIRE_JWT_HOURS env variable. Works best with values over 6. 

.env variables
PDF_API_CREDENTIAL_PATH - Relative path to the pdfservices-api-credentials.json received from Adobe at registration including the file name.
PDF_API_EXPIRE_JWT_HOURS - the number of hours in which to expire the JWT used to get the API Token


