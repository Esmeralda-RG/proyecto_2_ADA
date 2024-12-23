include "utils/profit_functions.mzn";
include "model_variables.mzn";

array[0..n-1, 0..n-1] of var 0..1: new_location;

array[1..num_of_established] of int: initial_profit = [
    get_profit(x_coordinates[i], y_coordinates[i], n, population_segment, business_environment) | i in 1..num_of_established
];

output [
    "1. Ganancia total: " ++ show(sum(initial_profit)) ++ "\n" ++
    "3. Coordenadas de localizaciones anteriores:\n" ++
    concat([ show(x_coordinates[i]) ++ " " ++ show(y_coordinates[i]) ++ "\n" | i in 1..num_of_established])
];
