include "utils/earnings_function.mzn";

int: num_of_established;
array[1..num_of_established] of int: x_coordinates;
array[1..num_of_established] of int: y_coordinates;

int: n;
array[0..n-1, 0..n-1] of int: population_segment;
array[0..n-1, 0..n-1] of int: business_environment;

int: num_programs;

array[0..n-1, 0..n-1] of var 0..1: new_location;

array[1..num_of_established] of int: population_result = [
    get_coordinates(x_coordinates[i], y_coordinates[i], n, population_segment) | i in 1..num_of_established
];

array[1..num_of_established] of int: bussiness_result = [
    get_coordinates(x_coordinates[i], y_coordinates[i], n, business_environment) | i in 1..num_of_established
];

output [
    "1. Ganancia total: " ++ show(sum(population_result) + sum(bussiness_result)) ++ "\n" ++
    "3. Coordenadas de localizaciones anteriores:\n" ++
    concat([ show(x_coordinates[i]) ++ " " ++ show(y_coordinates[i]) ++ "\n" | i in 1..num_of_established])
];
