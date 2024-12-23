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
