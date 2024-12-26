"""
Pedro Bernal Londoño - 2259548
Jota Emilio Lopez Ramirez - 2259394
Esmeralda Rivas Guzmán - 2259580
"""
def read_input(file_path):
    with open(file_path, "r") as file:
        lines = file.readlines()

    num_of_established = int(lines[0].strip())
    x_coordinates = []
    y_coordinates = []
    
    for i in range(1, num_of_established + 1):
        x, y = map(int, lines[i].strip().split())
        x_coordinates.append(x)
        y_coordinates.append(y)

    n = int(lines[num_of_established + 1].strip())
    
    population_segment = []
    for line in lines[num_of_established + 2:num_of_established + 2 + n]:
        population_segment.append(list(map(int, line.strip().split())))

    business_environment = []
    for line in lines[num_of_established + 2 + n:num_of_established + 2 + 2 * n]:
        business_environment.append(list(map(int, line.strip().split())))

    num_programs = int(lines[num_of_established + 2 + 2 * n].strip())

    return {
        "num_of_established": num_of_established,
        "x_coordinates": x_coordinates,
        "y_coordinates": y_coordinates,
        "n": n,
        "population_segment": population_segment,
        "business_environment": business_environment,
        "num_programs": num_programs
    }
