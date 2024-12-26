/*
 * This MiniZinc model is designed to optimize the placement of business locations based on various constraints and profit calculations.
 * 
 * Includes:
 * - "utils/profit_function.mzn": Contains the function to calculate profit based on coordinates.
 * - "model_variables.mzn": Contains the model variables.
 * - "utils/contiguous_coordinates.mzn": Contains the function to mark contiguous coordinates.
 * 
 * Variables:
 * - final_profit: An array storing the profit for each established location.
 * - initial_location: A 2D array representing the initial locations of the businesses.
 * - matrix_locations: A 2D array marking contiguous locations.
 * - valid_coords: A 2D array of boolean variables indicating valid coordinates based on restrictions.
 * - candidate_profit: A 2D array of integer variables representing the candidate profit for each coordinate.
 * - max_profit: An integer variable representing the maximum profit among candidate profits.
 * - max_i, max_j: Integer variables representing the coordinates of the maximum profit location.
 * 
 * Constraints:
 * - Ensures that there exists a coordinate (i, j) where the candidate profit equals the maximum profit and assigns these coordinates to max_i and max_j.
 * - Ensures that valid coordinates meet the minimum restrictions for population segment and business environment.
 * 
 * Objective:
 * - The model aims to satisfy the constraints and find the optimal placement of business locations.
 * 
 * Output:
 * - The total profit including the new location.
 * - The coordinates of the established locations.
 * - The coordinates of the new optimal location.
 */
include "utils/profit_function.mzn";
include "model_variables.mzn";
include "utils/contiguous_coordinates.mzn";

array[1..num_of_established] of int: final_profit = [
    get_profit_coordinate(x_coordinates[i], y_coordinates[i], n, population_segment, business_environment) | i in 1..num_of_established
];

array[0..n-1, 0..n-1] of int: initial_location = 
    array2d(0..n-1, 0..n-1, [if exists(k in 1..num_of_established)(x_coordinates[k] == i /\ y_coordinates[k] == j) then 1 else 0 endif | i, j in 0..n-1]);

array[0..n-1, 0..n-1] of int: matrix_locations = mark_contiguous(initial_location);

array[0..n-1, 0..n-1] of var bool: valid_coords;

constraint
    forall(i in 0..n-1, j in 0..n-1) (
        if (get_restrictions(i, j, n, population_segment, matrix_locations) >= 25
        /\ get_restrictions(i, j, n, business_environment, matrix_locations) >= 20) then 
            valid_coords[i, j] = true 
        else 
            valid_coords[i, j] = false 
        endif
    );

array[0..n-1, 0..n-1] of var int: candidate_profit = 
    array2d(0..n-1, 0..n-1, [
        if valid_coords[i,j] then get_restrictions(i, j, n, population_segment, matrix_locations) + get_restrictions(i, j, n, business_environment, matrix_locations) else 0 endif
        | i, j in 0..n-1
    ]);

var int: max_profit = max([candidate_profit[i, j] | i, j in 0..n-1]);

constraint max_profit > 0;

var int: max_i;
var int: max_j;

constraint
    exists(i, j in 0..n-1) (
        candidate_profit[i, j] == max_profit /\
        max_i == i /\
        max_j == j
    );


solve satisfy;

output [
    show(sum(final_profit) + get_profit_coordinate(fix(max_i), fix(max_j), n, population_segment, business_environment)) ++ "\n" ++
    concat([ show(x_coordinates[i]) ++ " " ++ show(y_coordinates[i]) ++ "\n" | i in 1..num_of_established]) ++
    show(fix(max_i)) ++ " " ++ show(fix(max_j)) ++ "\n" 
];

