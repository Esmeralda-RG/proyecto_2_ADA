function int: get_coordinates(int: x, int: y, int: n, array[0..n-1, 0..n-1] of int: earnings) =
    let {
        int: up = if x > 0 then earnings[x-1, y] else 0 endif,
        int: down = if x < n-1 then earnings[x+1, y] else 0 endif,
        int: left = if y > 0 then earnings[x, y-1] else 0 endif,
        int: right = if y < n-1 then earnings[x, y+1] else 0 endif,
        int: top_left = if x > 0 /\ y > 0 then earnings[x-1, y-1] else 0 endif,
        int: bottom_left = if x < n-1 /\ y > 0 then earnings[x+1, y-1] else 0 endif,
        int: top_right = if x > 0 /\ y < n-1 then earnings[x-1, y+1] else 0 endif,
        int: bottom_right = if x < n-1 /\ y < n-1 then earnings[x+1, y+1] else 0 endif,
        int: center = earnings[x, y]
    } in
    up + down + left + right + top_left + bottom_left + top_right + bottom_right + center
