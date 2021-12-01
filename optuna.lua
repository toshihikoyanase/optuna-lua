json = require "json"

local optuna = { _version = "0.0.1" }


local function run(cmd_table)
    local cmd_str = table.concat(cmd_table, " ")
    io.stderr:write(cmd_str .. "\n")
    local handle = io.popen(cmd_str)
    return handle:read("*a")
end


function optuna.create_study(storage_url, study_name, direction)
    local cmd = {"optuna create-study"}
    table.insert(cmd, "--storage " .. storage_url)
    table.insert(cmd, "--study-name " .. study_name)
    table.insert(cmd, "--direction " .. direction)
    return run(cmd)
end


function optuna.trials(storage_url, study_name)
    local cmd = {"optuna trials"}
    table.insert(cmd, "--storage " .. storage_url)
    table.insert(cmd, "--study-name " .. study_name)
    table.insert(cmd, "-f json")

    local result = run(cmd)
    return json.decode(result)
end


function optuna.studies(storage_url)
    local cmd = {"optuna studies"}
    table.insert(cmd, "--storage " .. storage_url)
    table.insert(cmd, "-f json")

    local result = run(cmd)
    return json.decode(result)
end


function optuna.ask(storage_url, study_name, search_space)
    local cmd = {"optuna ask"}
    table.insert(cmd, "--storage " .. storage_url)
    table.insert(cmd, "--study-name " .. study_name)
    table.insert(cmd, "-f json")
    table.insert(cmd, "--search-space '" .. json.encode(search_space) .. "'")

    local result = run(cmd)
    return json.decode(result)
end


function optuna.tell(storage_url, study_name, trial_number, value)
    local cmd = {"optuna tell"}
    table.insert(cmd, "--storage " .. storage_url)
    table.insert(cmd, "--study-name " .. study_name)
    table.insert(cmd, "--trial-number " .. trial_number)
    table.insert(cmd, "--values " .. value)

    return run(cmd)
end


function optuna.best_trial(storage_url, study_name)
    local cmd = {"optuna best-trial"}
    table.insert(cmd, "--storage " .. storage_url)
    table.insert(cmd, "--study-name " .. study_name)
    table.insert(cmd, "-f json")

    local result = run(cmd)
    return json.decode(result)
end


return optuna
