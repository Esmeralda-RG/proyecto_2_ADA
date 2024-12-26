/*
 * This MiniZinc model calculates the initial profit for a number of established entities.
 * 
 * Includes:
 * - "utils/profit_function.mzn": A utility file that contains the function to calculate profit based on coordinates and other parameters.
 * - "model_variables.mzn": A file that includes the necessary model variables.
 * 
 * Variables:
 * - initial_profit: An array that stores the initial profit for each established entity. The profit is calculated using the 
 *   get_profit_coordinate function, which takes the x and y coordinates, the number of entities (n), the population segment, 
 *   and the business environment as parameters.
 * 
 * Output:
 * - The model outputs the sum of the initial profits for all established entities.
 *
 * Authors:
 * - Pedro Bernal Londoño - 2259548
 * - Jota Emilio Lopez Ramirez - 2259394
 * - Esmeralda Rivas Guzmán - 2259580
 */
include "utils/profit_function.mzn";
include "model_variables.mzn";

array[1..num_of_established] of int: initial_profit = [
    get_profit_coordinate(x_coordinates[i], y_coordinates[i], n, population_segment, business_environment) | i in 1..num_of_established
];

output [
    show(sum(initial_profit)) ++ "\n" 
];

