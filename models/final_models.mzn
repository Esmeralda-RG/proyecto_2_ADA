include "utils/profit_function.mzn";
include "model_variables.mzn";
include "utils/contiguous_coordinates.mzn";

array[1..num_of_established] of int: initial_profit = [
    get_profit_coordinate(x_coordinates[i], y_coordinates[i], n, population_segment, business_environment) | i in 1..num_of_established
];

array[0..n-1, 0..n-1] of int: initial_location = 
    array2d(0..n-1, 0..n-1, [if exists(k in 1..num_of_established)(x_coordinates[k] == i /\ y_coordinates[k] == j) then 1 else 0 endif | i, j in 0..n-1]);

array[0..n-1, 0..n-1] of int: matrix_locations = mark_contiguous(initial_location);

array[0..n-1, 0..n-1] of var bool: valid_coords;

array[0..n-1, 0..n-1] of var int: candidate_profit = 
    array2d(0..n-1, 0..n-1, [
        if valid_coords[i,j] then get_restrictions(i, j, n, population_segment, matrix_locations) + get_restrictions(i, j, n, business_environment, matrix_locations) else 0 endif
        | i, j in 0..n-1
    ]);

constraint
    forall(i in 0..n-1, j in 0..n-1) (
        (get_restrictions(i, j, n, population_segment, matrix_locations) >= 25
        /\ get_restrictions(i, j, n, business_environment, matrix_locations) >= 20) -> valid_coords[i, j] == true
    );

output [
    "1. Ganancia total: " ++ show(sum(initial_profit)) ++ "\n" ++
    "2. Ganancias potenciales de las coordenadas válidas:\n" ++
    concat([ if fix(candidate_profit[i,j]) > 0 then show(i) ++ " " ++ show(j) ++ " " ++ show(candidate_profit[i,j]) ++ "\n" else "" endif | i in 0..n-1, j in 0..n-1]) ++
    "3. Coordenadas de localizaciones anteriores:\n" ++
    concat([ show(x_coordinates[i]) ++ " " ++ show(y_coordinates[i]) ++ "\n" | i in 1..num_of_established]) ++ 
    "4. Localizaciones predeterminadas:\n" ++
    concat([ show(matrix_locations[i,j]) ++ if j == n-1 then "\n" else " " endif | i in 0..n-1, j in 0..n-1]) ++
    "5. coordenadas que cumplen la restricción:\n"] ++
    [if fix(valid_coords[i, j]) then show(i) ++ " " ++ show(j) ++ "\n" else "" endif | i in 0..n-1, j in 0..n-1] ++
    ["\n"];



