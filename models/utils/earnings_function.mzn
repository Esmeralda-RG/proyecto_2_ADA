function int: get_coordinates(int: x, int: y, int: n, array[0..n-1, 0..n-1] of int: earnings) =
    let {
        int: left = if x > 0 then earnings[x-1, y] else 0 endif,
        int: right = if x < n-1 then earnings[x+1, y] else 0 endif,
        int: up = if y > 0 then earnings[x, y-1] else 0 endif,
        int: down = if y < n-1 then earnings[x, y+1] else 0 endif,
        int: top_left = if x > 0 /\ y > 0 then earnings[x-1, y-1] else 0 endif,
        int: top_right = if x < n-1 /\ y > 0 then earnings[x+1, y-1] else 0 endif,
        int: bottom_left = if x > 0 /\ y < n-1 then earnings[x-1, y+1] else 0 endif,
        int: bottom_right = if x < n-1 /\ y < n-1 then earnings[x+1, y+1] else 0 endif,
        int: center = earnings[x, y]
    } in
    left + right + up + down + top_left + top_right + bottom_left + bottom_right + center;
