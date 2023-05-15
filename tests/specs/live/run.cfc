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
                    testobj = createMock(object = getInstance('mergeDOCXtoPDF@adobePDFRest'));
                    testme = testobj.run(
                        allJSON(),
                        '/resources/veriti_Account_Overview_HD10.DOCX',
                        '/output/DidTHisWork.pdf'
                    );
                    writeDump(testobj);
                    writeDump(testme);
                });
                it('should run readCredential 1x', function() {
                    // testme = testobj.init();
                    // expect(testObj.$count("readCredentials")).tobe(1);
                });
            }
        );
    }

    function allJSON() {
        return {
            'tilts': [{'name': 'none'}],
            'exclusionsCountry': [{'name': 'none'}],
            'account': {
                'zip': '03853',
                'lastname': 'Bennett',
                'street': '4 Governor Wentworth Hwy',
                'homePhone': '',
                'taxid': '467-36-1782',
                'st': 'New Hampshire',
                'firstname': 'Robert',
                'city': 'Mirror Lake',
                'custodianAccountNumber': '30655686',
                'title': 'Robert B Bennett - 2014 Irrevocable Trust',
                'custodian': 'Schwab'
            },
            'exclusionsValues': [
                {'name': 'Human Rights Abuses'},
                {'name': 'Labor Rights Abuses'},
                {'name': 'Slave Labor & Trafficking'},
                {'name': 'Supplying Oppressive Regimes'},
                {'name': 'Abortion'},
                {'name': 'Stem Cell Research'},
                {'name': 'Alcohol'},
                {'name': 'Cannabis'},
                {'name': 'Gambling'},
                {'name': 'Pornography/Adult Entertainment'},
                {'name': 'Tobacco'},
                {'name': 'Violent Entertainment'},
                {'name': 'Religious Discrimination'}
            ],
            'whitelist': [{'name': 'none'}],
            'exclusionsSector': [{'name': 'none'}],
            'blacklist': [{'name': 'none'}],
            'configuration': {
                'portfolioType': 'Individual',
                'federalTaxRateShort': '40.8%',
                'taxState': 'New Hampshire',
                'regularDistributions': 'none',
                'benchmark': 'Morningstar Global',
                'funding': 'none',
                'stateTaxRateShort': '12%',
                'federalTaxRateLong': '23.8%',
                'stateTaxRateLong': '5%'
            },
            'generated': {'date': 'September 2022'}
        }
    }

}
