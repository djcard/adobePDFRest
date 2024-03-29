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
                    testobj = createMock(object = getInstance('BasePdfAPI@adobePDFRest'));
                    testme = testObj.createTimeStamp();
                });
                it('return a numeric', function() {
                    expect(testme).tobeTypeOf('numeric');
                });
            }
        );
    }

}
