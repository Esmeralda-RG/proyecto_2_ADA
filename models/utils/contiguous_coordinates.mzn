/**
 * Marks contiguous coordinates in a 2D array.
 *
 * This function takes a 2D array of integers `loc` and returns a new 2D array
 * of the same dimensions where each element is marked as 1 if it is contiguous
 * to any element with value 1 in the original array, including diagonally.
 *
 * @param loc A 2D array of integers representing the locations.
 * @return A 2D array of integers where contiguous coordinates are marked as 1.
 *
 * The function checks the following conditions for each element (i, j) in the array:
 * - If `loc[i, j] == 1`
 * - If the element above `loc[i-1, j] == 1` (if `i > 0`)
 * - If the element below `loc[i+1, j] == 1` (if `i < n-1`)
 * - If the element to the left `loc[i, j-1] == 1` (if `j > 0`)
 * - If the element to the right `loc[i, j+1] == 1` (if `j < n-1`)
 * - If the element diagonally top-left `loc[i-1, j-1] == 1` (if `i > 0` and `j > 0`)
 * - If the element diagonally top-right `loc[i-1, j+1] == 1` (if `i > 0` and `j < n-1`)
 * - If the element diagonally bottom-left `loc[i+1, j-1] == 1` (if `i < n-1` and `j > 0`)
 * - If the element diagonally bottom-right `loc[i+1, j+1] == 1` (if `i < n-1` and `j < n-1`)
 *
 * If any of these conditions are met, the corresponding element in the returned array is set to 1.
 */
function array[int, int] of int: mark_contiguous(array[int, int] of int: loc) =
    array2d(0..n-1, 0..n-1, [
        if loc[i,j] == 1 \/ 
           (i > 0 /\ loc[i-1,j] == 1) \/ 
           (i < n-1 /\ loc[i+1,j] == 1) \/ 
           (j > 0 /\ loc[i,j-1] == 1) \/ 
           (j < n-1 /\ loc[i,j+1] == 1) \/ 
           (i > 0 /\ j > 0 /\ loc[i-1,j-1] == 1) \/ 
           (i > 0 /\ j < n-1 /\ loc[i-1,j+1] == 1) \/ 
           (i < n-1 /\ j > 0 /\ loc[i+1,j-1] == 1) \/ 
           (i < n-1 /\ j < n-1 /\ loc[i+1,j+1] == 1)
        then 1 else 0 endif 
        | i, j in 0..n-1
    ]);
