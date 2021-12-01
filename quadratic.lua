optuna = require "optuna"

-- Define your search space as a table.
-- The distribution classes can be found in
-- https://optuna.readthedocs.io/en/stable/reference/distributions.html.
local search_space = {
    x={
        name="UniformDistribution",
        attributes={
            low=0,
            high=10
        }
    },
    y={
        name="IntUniformDistribution",
        attributes={
            low=0,
            high=10,
        }
    }
}

-- Define your objective function.
function objective(trial)
    local x = trial["params"]["x"]
    local y = trial["params"]["y"]
    return (x - 5) ^ 2 + (y - 2) ^ 2
end


local storage_url = "sqlite:///foo.db"
local study_name = "quadratic"
local direction = "minimize"
local n_trials = 20

-- Create a study to manage your optimization.
optuna.create_study(storage_url, study_name, direction)

-- Optimization loop is defined with the ask-and-tell interface.
-- See also https://optuna.readthedocs.io/en/stable/tutorial/20_recipes/009_ask_and_tell.html.
for i = 1, n_trials do
    local trial = optuna.ask(storage_url, study_name, search_space)
    local value = objective(trial)
    optuna.tell(storage_url, study_name, trial["number"], value)
end

-- Show the optimization results.
best_trial = optuna.best_trial(storage_url, study_name)
print("Best trial: " .. best_trial["number"])
print("Best value: " .. best_trial["value"])
print("Best params: ")
print("  x: " .. best_trial["params"]["x"])
print("  x: " .. best_trial["params"]["y"])
