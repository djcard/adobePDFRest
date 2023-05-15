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
            body = function() {
                beforeEach(function() {
                    testobj = createMock(object = getInstance('BasePdfAPI@adobePDFRest'));
                    writeDump(testobj);
                });
                it('should run readCredential 1x', function() {
                    // testme = testobj.init();
                    // expect(testObj.$count("readCredentials")).tobe(1);
                });
            }
        );
    }

}
