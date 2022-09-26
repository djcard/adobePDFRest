/**
 * My BDD Test
 */
component extends="coldbox.system.testing.BaseTestCase" {

    /*********************************** LIFE CYCLE Methods ***********************************/

    // executes before all suites+specs in the run() method
    function beforeAll() {
        super.beforeAll();
    }

    // executes after all suites+specs in the run() method
    function afterAll() {
        super.afterAll();
    }

    /*********************************** BDD SUITES ***********************************/

    function run() {
        describe(
            title = 'The Read Credentials should',
            labels = 'automated',
            body = function() {
                beforeEach(function() {
                    mockCredential = mockData($type="words:1",$num=1)[1];
                    mockJSON = serializeJSON({stuff:"there"});
                    preJSON2={service_account_credentials:{"private_key_file":mockData($type="words:1",$num=1)[1]}};
                    mockJSON2 = serializeJSON(preJSON2);
                    mockReturn2=mockData($type="words:1",$num=1)[1];
                    testobj = createMock(object = getInstance('BasePdfAPI@adobePDFRest'));
                    testObj.setcredentialPath(mockCredential);
                    testObj.$(method="readFile",returns= mockJson);
                });
                it('Run readFile 2x', function() {
                   testobj.readCredentials();
                   expect(testObj.$count("readFile")).tobe(1);
                });
                it('If credentials read are JSON, set them as CredData', function() {
                   testobj.readCredentials();
                   expect(testObj.getcredData()).tohavekey("stuff");
                });
                it('If credentials read are not JSON, set CredData as an empty struct', function() {
                    testObj.$(method="readFile",returns="This is not JSON; {}}}");
                    testobj.readCredentials();
                    expect(testObj.getcredData().keyArray().len()).tobe(0);
                });
                it('If the returned JSON does not have  the key service_account_credentials.private_key_file, set the privateKey property to a blank string', function() {
                    testobj.readCredentials();
                    expect(testObj.getPrivateKey().len()).tobe(0);
                });
                it('If credentials read are not JSON, set CredData as an empty struct', function() {
                    testObj.$(method="readFile",returns="This is not JSON; {}}}");
                    testobj.readCredentials();
                        expect(testObj.getcredData().keyArray().len()).tobe(0);
                });
                it('If credentials returned are JSON and have the key service_account_credentials.private_key_file, pass that to readFile and set the prive key to the result', function() {
                    testObj.$(method="readFile").$results(mockJSON2,mockReturn2);
                    testobj.readCredentials();
                    expect(testObj.getprivateKey()).tobe(mockReturn2);
                    expect(testObj.$count("readFile")).tobe((2));
                });
                it('the first call to readFile should pass the credentialPath property', function() {
                    testObj.$(method="readFile").$results(mockJSON2,mockReturn2);
                    testobj.readCredentials();
                    expect(testObj._MOCKCALLLOGGERS.readFile[1][1]).tobe(mockCredential);
                    expect(testObj._MOCKCALLLOGGERS.readFile[2][1]).tobe(preJSON2.service_account_credentials.private_key_file);
                });
            }
        );
    }

}
