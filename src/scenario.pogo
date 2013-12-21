scenario! (name, steps) =
    new scenario = { name = name, steps = steps }
    scenario.all.push (new scenario)
    new scenario

scenario.all = []

execute all! () =
    for each @(scenario) in (scenario.all)
        execute! (scenario)

execute! (scenario) =
    world = { scenario = scenario }
    for each @(step) in (scenario.steps)
        step.call! (world)

module.exports = scenario
module.exports.execute all = execute all
