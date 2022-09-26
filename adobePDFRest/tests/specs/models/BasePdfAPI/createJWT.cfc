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
                });
                it('return an ActivityReport Object', function() {
                    testme = testobj.createJWT();
                    writeDump(testme);
                });
            }
        );
    }

}
