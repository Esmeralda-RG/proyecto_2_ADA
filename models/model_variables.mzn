/*
 * This MiniZinc model defines several variables for a project.
 *
 * Variables:
 * - int: num_of_established
 *   The number of established entities.
 *
 * - array[1..num_of_established] of int: x_coordinates
 *   An array representing the x-coordinates of the established entities.
 *
 * - array[1..num_of_established] of int: y_coordinates
 *   An array representing the y-coordinates of the established entities.
 *
 * - int: n
 *   The dimension of the population_segment and business_environment arrays.
 *
 * - array[0..n-1, 0..n-1] of int: population_segment
 *   A 2D array representing the population segment data.
 *
 * - array[0..n-1, 0..n-1] of int: business_environment
 *   A 2D array representing the business environment data.
 *
 * - int: num_programs
 *   The number of programs.
 */
int: num_of_established;
array[1..num_of_established] of int: x_coordinates;
array[1..num_of_established] of int: y_coordinates;

int: n;
array[0..n-1, 0..n-1] of int: population_segment;
array[0..n-1, 0..n-1] of int: business_environment;

int: num_programs;
