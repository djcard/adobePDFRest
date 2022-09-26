component accessors="true" extends="adobePdfGenerationAPI.models.BasePdfAPI"{

	//property name="veritiPDF" inject="accountOverviewReport@veritiPdf";
	//property name="resourcePath" inject="coldbox:setting:pdfResourcePath@veritipdf";
	//property name="outputPath" inject="coldbox:setting:pdfOutputPath@veritipdf";


	function run(required struct mergeData, required string sourceTemplatePath, required string outputFileName){
		var retMe={
			credentialsFound:false,
			mergeDataCreated:false,
				jwtTokenMade:false,
			apiTokenReceived:false,
			submitSuccessful:false,
			pollSuccessful:false,
			writtenFileName:""
		};

		try {
			readCredentials();
			credentialsFound=true;

			var mergedJsonData = assembleJson(arguments.mergeData, outputFileName);
			retme.mergeDataCreated=true;

			setJWTToken(createJWT());
			retme.jwtTokenMade=true;

			obtainApiToken();
			retme.apiTokenReceived=true;

			var pollAccountId = sendMergeData(mergedJsonData, arguments.sourceTemplatePath);
			setRequestId(pollAccountId);
			retme.submitSuccessful=true;

			sleep(15000);
			var pollData = pollForDocument();
			pollSuccessful=true;
			retme.append(pollData,true);

			return retme;
		} catch(any err){
			scribe.log(message="callFailed",extrainfo=err);
		}
	}

	function assembleJson(required struct internalData, required string outputFileName){
		var sendJSON={
			"cpf:engine": {
				"repo:assetId": "urn:aaid:cpf:Service-52d5db6097ed436ebb96f13a4c7bf8fb"
			},
			"cpf:inputs": {
				"documentIn": {
					"dc:format": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
					"cpf:location": "InputFile0"
				},
				"params": {
					"cpf:inline": {
						"outputFormat": "pdf",
						"jsonDataForMerge":{}
					}
				}
			},
			"cpf:outputs": {
				"documentOut": {
					"dc:format": "application/pdf",
					"cpf:location": "#outputFileName#"
				}
			}
		};
		sendJSON["cpf:inputs"]["params"]["cpf:inline"]["jsonDataForMerge"]=internalData;
		//fileWrite(expandpath("/resources/sampleJSON.json"),serializeJSON(sendJSON));
		return sendJSON;
	}



	function sendMergeData(required struct mergeData, required string templateFileName){
		var filePath=expandpath("#resourcepath#/#arguments.templateFileName#");
		cfhttp(method="POST",charset="utf-8",url="https://cpf-ue1.adobe.io/ops/:create?respondWith=%7B%22reltype%22%3A%20%22http%3A%2F%2Fns.adobe.com%2Frel%2Fprimary%22%7D",result="submissionResult"){
			cfhttpParam(type="header", name="Authorization",value="Bearer #getApiToken()#");
			cfhttpParam(type="header", name="x-api-key",value="#getCredData().client_credentials.client_id#");
			cfhttpParam(type="header", name="Prefer",value="respond-async,wait=0");
			cfhttpParam(type="formField", name="contentAnalyzerRequests", value="#serializeJSON(arguments.mergeData)#");
			cfhttpParam(type="file", name="InputFile0", file="#filePath#");
		}

		var projectToken=submissionResult.responseheader["x-request-id"];
		return projectToken;
	}

	function pollForDocument(){
		var retme={status_code:"",status_text:"", fileWritten:false, fileName:""};

		cfhttp(method="GET",url="https://cpf-ue1.adobe.io/ops/id/#getRequestId()#",result="docResponse"){
			cfhttpParam(type="header", name="Authorization",value="Bearer #getApiToken()#");
			cfhttpParam(type="header", name="x-api-key",value="#getcreddata().client_credentials.client_id#");
		};

		retme.status_code=docResponse.status_code;
		retme.status_text=docResponse.status_text;
		var fileName=docResponse.fileContent[2].headers["Content-Disposition"].listLast("=").replace('"',"","all");
		retme.fileName=filename;
		retme.relativeFileName="#getOutputPath()#/#retme.filename#";
		retme.filePath=expandpath("/#getOutputPath()#/#retme.filename#");
		try {
			filewrite(retme.filePath, docResponse.fileContent[2].content);
			retme.fileWritten=true;
		} catch(any err){
			scribe.log(message="file for request #getRequestId()# not written",extraInfo=err);
		}

		return retme;
	}



}
