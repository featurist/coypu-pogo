errors = {

    Element Not Found (selector, strategy) =
        @new Error "Found no element by #(strategy) #(selector)"

}

module.exports = errors