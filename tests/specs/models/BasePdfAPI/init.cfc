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
            title = 'The Run Function should',
            labels = 'automated',
            body = function() {
                beforeEach(function() {
                    testobj = createMock(object = getInstance('BasePdfAPI@adobePDFRest'));
                    testObj.$(method = 'readCredentials');
                    testObj.$(method = 'createJWT');
                    testObj.$(method = 'obtainApiToken');
                });
                it('should run readCredential 1x', function() {
                    testme = testobj.init();
                    expect(testObj.$count('readCredentials')).tobe(1);
                });
                it('should run createJWT 1x', function() {
                    testme = testobj.init();
                    expect(testObj.$count('createJWT')).tobe(1);
                });
                it('should run obtainAPIToken 1x', function() {
                    testme = testobj.init();
                    expect(testObj.$count('obtainAPIToken')).tobe(1);
                });
                it('return an basePdfApi Object', function() {
                    testme = testobj.init();
                    expect(testme).tobeinstanceOf('basePdfApi');
                });
            }
        );
    }

}
