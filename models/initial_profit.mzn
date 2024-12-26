/*
Pedro Bernal Londoño - 2259548
Jota Emilio Lopez Ramirez - 2259394
Esmeralda Rivas Guzmán - 2259580
*/
include "utils/profit_function.mzn";
include "model_variables.mzn";

array[1..num_of_established] of int: initial_profit = [
    get_profit_coordinate(x_coordinates[i], y_coordinates[i], n, population_segment, business_environment) | i in 1..num_of_established
];

output [
    show(sum(initial_profit)) ++ "\n" 
];

