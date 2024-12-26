/**
 * Authors:
 * - Pedro Bernal Londoño - 2259548
 * - Jota Emilio Lopez Ramirez - 2259394
 * - Esmeralda Rivas Guzmán - 2259580
 */


/**
 * Calculates the profit for a given coordinate (x, y) in a grid.
 *
 * @param x The x-coordinate in the grid.
 * @param y The y-coordinate in the grid.
 * @param n The size of the grid (n x n).
 * @param population_segment A 2D array representing the population segment values.
 * @param business_environment A 2D array representing the business environment values.
 * @return The total profit for the given coordinate, considering its neighbors and itself.
 */
function int: get_profit_coordinate(int: x, int: y, int: n, array[0..n-1, 0..n-1] of int: population_segment, array[0..n-1, 0..n-1] of int: business_environment);

/**
 * Calculates the restrictions for a given coordinate (x, y) in a grid based on a base matrix.
 *
 * @param x The x-coordinate in the grid.
 * @param y The y-coordinate in the grid.
 * @param n The size of the grid (n x n).
 * @param profit_matrix A 2D array representing the profit values.
 * @param base_matrix A 2D array representing the base matrix values.
 * @return The total restrictions for the given coordinate, considering its neighbors and itself if the base matrix value at (x, y) is 0, otherwise returns 0.
 */
function int: get_restrictions(int: x, int: y, int: n, array[0..n-1, 0..n-1] of int: profit_matrix, array[0..n-1, 0..n-1] of int: base_matrix);
function int: get_profit_coordinate(int: x, int: y, int: n, array[0..n-1, 0..n-1] of int: population_segment, array[0..n-1, 0..n-1] of int: business_environment) =
    let {
        int: up = if x > 0 then population_segment[x-1, y] + business_environment[x-1, y] else 0 endif,
        int: down = if x < n-1 then population_segment[x+1, y] + business_environment[x+1, y] else 0 endif,
        int: left = if y > 0 then population_segment[x, y-1] + business_environment[x, y-1] else 0 endif,
        int: right = if y < n-1 then population_segment[x, y+1] + business_environment[x, y+1] else 0 endif,
        int: top_left = if x > 0 /\ y > 0 then population_segment[x-1, y-1] + business_environment[x-1, y-1] else 0 endif,
        int: bottom_left = if x < n-1 /\ y > 0 then population_segment[x+1, y-1] + business_environment[x+1, y-1] else 0 endif,
        int: top_right = if x > 0 /\ y < n-1 then population_segment[x-1, y+1] + business_environment[x-1, y+1] else 0 endif,
        int: bottom_right = if x < n-1 /\ y < n-1 then population_segment[x+1, y+1] + business_environment[x+1, y+1] else 0 endif,
        int: center = population_segment[x, y] + business_environment[x, y]
    } in
    up + down + left + right + top_left + bottom_left + top_right + bottom_right + center;

function int: get_restrictions(int: x, int: y, int: n, array[0..n-1, 0..n-1] of int: profit_matrix, array[0..n-1, 0..n-1] of int: base_matrix) =
    if base_matrix[x, y] == 0 then
        let {
        int: up = if x > 0 /\ base_matrix[x-1, y] == 0 then profit_matrix[x-1, y] else 0 endif,
        int: down = if x < n-1 /\ base_matrix[x+1, y] == 0 then profit_matrix[x+1, y] else 0 endif,
        int: left = if y > 0 /\ base_matrix[x, y-1] == 0 then profit_matrix[x, y-1] else 0 endif,
        int: right = if y < n-1 /\ base_matrix[x, y+1] == 0 then profit_matrix[x, y+1] else 0 endif,
        int: top_left = if x > 0 /\ y > 0 /\ base_matrix[x-1, y-1] == 0 then profit_matrix[x-1, y-1] else 0 endif,
        int: bottom_left = if x < n-1 /\ y > 0 /\ base_matrix[x+1, y-1] == 0 then profit_matrix[x+1, y-1] else 0 endif,
        int: top_right = if x > 0 /\ y < n-1 /\ base_matrix[x-1, y+1] == 0 then profit_matrix[x-1, y+1] else 0 endif,
        int: bottom_right = if x < n-1 /\ y < n-1 /\ base_matrix[x+1, y+1] == 0 then profit_matrix[x+1, y+1] else 0 endif,
        int: center = profit_matrix[x, y]
    } in
    up + down + left + right + top_left + bottom_left + top_right + bottom_right + center
    else
        0
    endif;
