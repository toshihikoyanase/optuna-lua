## Optuna for the Lua language

[Optuna](https://optuna.org) is a popular hyperparameter optimization framework in Python. This package is its Lua binding.

Note that this is a prototypical implementation, and it only provide a quite limited functionality of Optuna in Python.

### Installation

This package requires [`optuna`](https://optuna.org) because it runs the `optuna` CLI internally.

```console
$ pip install optuna
```

It also requires the [`rxi/json.lua`](https://github.com/rxi/json.lua) package to parse CLI outputs. Please place `json.lua` to the project directory, for example, as follows:

```console
$ curl -LO https://raw.githubusercontent.com/rxi/json.lua/master/json.lua
```

### Usage

See [`quadratic.lua`](./quadratic.lua) that minimizes a simple quadratic function.
[Optuna's CLI reference](https://optuna.readthedocs.io/en/stable/reference/cli.html) will also help when defining your search spaces and objective functions.


### LICENSE

MIT License.
The dependent package (i.e., [`rxi/json.lua`](https://github.com/rxi/json.lua)) is also distributed under the MIT License.

### Link

This project is inspired by the [C++ binding for Optuna](https://github.com/not522/optuna-cpp) developed by [not522](https://github.com/not522).

