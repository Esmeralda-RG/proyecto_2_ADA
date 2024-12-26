include "utils/profit_function.mzn";
include "model_variables.mzn";

array[1..num_of_established] of int: initial_profit = [
    get_profit_coordinate(x_coordinates[i], y_coordinates[i], n, population_segment, business_environment) | i in 1..num_of_established
];

output [
    show(sum(initial_profit)) ++ "\n" 
];

