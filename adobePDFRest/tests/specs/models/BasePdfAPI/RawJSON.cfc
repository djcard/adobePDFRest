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
            title = 'The rawJSON Function should',
            labels = 'automated',
            body = function() {
                beforeEach(function() {
                    fakeAUD = mockData($type="words:1",$num=1)[1];
                    fakeIss=mockData($type="words:1",$num=1)[1];
                    fakeSub=mockData($type="words:1",$num=1)[1];

                    fakeTimeDIff = randrange(1,1000);
                    testobj = createMock(object = getInstance('BasePdfAPI@adobePDFRest'));

                    testObj.$(method="createTimeStamp",returns=fakeTimeDIff);

                    testme = testObj.rawJSON(fakeIss, fakeSub, fakeAUD);
                });
                it('return a struct', function() {
                    expect(testme).tobeTypeOf("struct");
                });
                it('should have the key aud which is https://ims-na1.adobelogin.com/c/ plus the submitted aud argument', function() {
                    expect(testme).tohavekey("aud");
                    expect(testme.aud).tobe("https://ims-na1.adobelogin.com/c/#fakeAud#");
                });
                it('should have the key exp which is expiration time from createTimeStamp', function() {
                    expect(testme).tohavekey("exp");
                    expect(testme.exp).tobeTypeOf("numeric");
                    expect(testObj.$count("createTimeStamp")).tobe(1);
                    expect(testme.exp).tobe(fakeTimeDIff);
                });
                it('should have the key iss which is the submitted argument', function() {
                    expect(testme).tohavekey("iss");
                    expect(testme.iss).tobe(fakeIss);
                });
                it('should have the key sub which is the submitted argument', function() {
                    expect(testme).tohavekey("sub");
                    expect(testme.sub).tobe(fakeSub);
                });
                it('should have the key https://ims-na1.adobelogin.com/s/ent_documentcloud_sdk	 which is true', function() {
                        expect(testme).tohavekey("https://ims-na1.adobelogin.com/s/ent_documentcloud_sdk");
                        expect(testme["https://ims-na1.adobelogin.com/s/ent_documentcloud_sdk"]).tobeTrue();
                });
            }
        );
    }

}
