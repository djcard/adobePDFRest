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
                    fakeJson = {'Should': 'Work'};
                    fakeJsonReturn = {"merged":"yes",data:fakeJson};
                    fakeAPI = mockData($type = 'words:1', $num = 1)[1];
                    fakeOutputPath = mockData($type = 'words:1', $num = 1)[1];
                    fakeFileName = mockData($type = 'words:1', $num = 1)[1];
                    fakeSourcePath = mockData($type = 'words:1', $num = 1)[1];
                    fakeDocumentId = mockData($type="words:1",$num=1)[1];

                    testobj = createMock(object = getInstance('mergeDOCXtoPDF@adobePDFRest'));
                    testobj.$(method = 'obtainApiToken');
                    testobj.$(method = 'assembleJson');
                    testObj.$(method = 'sendMergeData');
                    testObj.$(method = 'pollForDocument');
                });
                it('Should run assembleJson 1x ad pass in the submitted JSON and the output file', function() {
                    testobj.$(method = 'assembleJson',callBack=function(){
                        expect(arguments[1].keylist()).tobe(fakeJson.keylist());
                        expect(arguments[2].keylist()).tobe(fakeOutputPath);
                    });
                    testme = testobj.run(fakeJSON, fakeSourcePath, fakeFileName);
                    expect(testObj.$count('assembleJson')).tobe(1);
                });
                it("If no json is returned from assembleJSON, the return should have key error=true",function(){
                    testme = testobj.run(fakeJSON, fakeSourcePath, fakeFileName);
                    expect(testme).tohaveKey("error");
                    expect(testme.error).tobeTrue();
                    expect(testme.mergeDataCreated).tobeFalse();
                });
                it('If JSON is returned, Should run sendMergeData 1x and submit the mergedJson and the sourceTemplate', function() {
                    testobj.$(method = 'assembleJson',returns=fakeJsonReturn);
                    testObj.$(method = 'sendMergeData',callback=function(){

                    });
                    testme = testobj.run(fakeJSON, fakeSourcePath, fakeFileName);
                    expect(testObj.$count('sendMergeData')).tobe(1);
                });
                it('Should run pollForDocument 1x', function() {
                    testobj.$(method = 'assembleJson',returns=fakeJsonReturn);
                    testobj.$(method = 'sendMergeData',returns=fakeDocumentId);
                    testme = testobj.run(fakeJSON, fakeSourcePath, fakeFileName);
                    expect(testObj.$count('pollForDocument')).tobe(1);
                });
            }
        );
    }

}
