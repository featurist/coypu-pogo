scenario = require '../src/scenario'

describe 'scenario'

    it 'executes steps in a world shared between steps'

        log = []

        using a browser! =
            this.browser = {

                visit! (relative or absolute url) =
                    log.push "VISITED #(relative or absolute url)"

                click! (text) =
                    log.push "CLICKED #(text)"

            }

        visit home page! =
            this.browser.visit! '/'

        navigate to account! =
            this.browser.click! 'Account'

        scenario! 'visiting my account' [
            using a browser
            visit home page
            navigate to account
        ]
        scenario.execute all!

        log.should.eql [
            "VISITED /"
            "CLICKED Account"
        ]
