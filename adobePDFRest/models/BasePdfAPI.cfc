component accessors="true" {
    property name="JWTToken";
    property name="apiToken";
    property name="credData";
    property name="privateKey";
    property name="credentials";
    property name="scribe" inject="scribe@cfscribe";
    property name="jwt" inject="jwt@jwtcfml";
    property name="hyper" inject="HyperBuilder@Hyper";
    property name="credentialPath" inject="coldBox:setting:credentialPath@adobePDFRest";
    property name="expireJWTHours" inject="coldbox:setting:expireJWTHours@adobePDFRest";

    function init(){

        return this;
    }

    function onDICOmplete(){
        readCredentials();
        if(isNull(getCredData()) || !getCredData().keyExists("service_account_credentials")){
            writeDump("THERE WAS NO CRED DATA");
            return this;
        }
        setJWTToken(createJWT());
        if(getJWTToken().len() == 0){
            writeDump("THER WAS NO JWT");
            return this;
        }
        obtainApiToken();
    }

    function readFile( path ){
        return fileExists(expandPath(arguments.path)) ?  fileRead(expandpath( arguments.path ) ) : "";
    }

    void function readCredentials(){
        var credentialFile= readFile( getCredentialPath() );
        var creds=credentialFile.len() && isJson(credentialFile) ? deserializeJSON(credentialFile) : {};
        setCredData(creds);
        setPrivateKey(creds.keyExists("service_account_credentials") && creds.service_account_credentials.keyExists("private_key_file")
                ? readFile(creds.service_account_credentials.private_key_file)
                : "");
    }

    /***
    * Creates the claims from the credData property and encodes the JWT
    *
    **/
    function createJWT(){
        var claims = rawJSON(
                getcredData().service_account_credentials.organization_id,
                getcredData().service_account_credentials.account_id,
                getcredData().client_credentials.client_id
                );

        var token=jwt.encode(claims,getPrivateKey(),"RS256");

        return token;
    }

    function obtainApiToken(){
        cfhttp(method="POST", charset="utf-8", url="https://ims-na1.adobelogin.com/ims/exchange/jwt", result="result") {
            cfhttpparam(name="client_id", type="form", value="#getCredData().client_credentials.client_id#");
            cfhttpparam(name="client_secret", type="form", value="#getCredData().client_credentials.client_secret#");
            cfhttpparam(name="jwt_token", type="form", value=getJWTToken());
        }

        var tokenStuff = deserializeJSON(result.fileContent);
        if(tokenStuff.keyExists("access_token")){
            setApiToken(tokenStuff.access_token);
        } else {

        }

    }

    /***
* A model for the JSON to submit to be encoded for the JWT
*@iss - The organizationid from Adobe
*@sub - The account ID from Adobe
*@aud - The clientID from Adobe
**/
    function rawJSON(iss,sub,aud){
        return {
        "exp":createTimeStamp(),
        "iss":trim(arguments.iss),
        "sub":trim(arguments.sub),
        "https://ims-na1.adobelogin.com/s/ent_documentcloud_sdk":true,
        "aud":"https://ims-na1.adobelogin.com/c/#arguments.aud#"
    };
    }

    /***
*   Creates a time difference between 29 hours from now
*
**/
    function createTimeStamp(){
        var inFive = dateAdd("h",getexpireJWTHours(),now());
        return dateDiff("s",createDateTime(1970,1,1,0,0,0), inFive);
    }
}
