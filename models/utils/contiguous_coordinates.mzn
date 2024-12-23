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
