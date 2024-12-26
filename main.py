from minizinc import Instance, Model, Solver
from utils.input_handler import read_input
import io

data = read_input("input.txt")

num_of_established = data["num_of_established"]
x_coordinates = data["x_coordinates"]
y_coordinates = data["y_coordinates"]
n = data["n"]
population_segment = data["population_segment"]
business_environment = data["business_environment"]
num_programs = data["num_programs"]

initial_model = Model("models/initial_profit.mzn")  
final_model = Model("models/final_models.mzn")

initial_solver = Solver.lookup("gecode")
final_solver = Solver.lookup("gecode")

initial_instance = Instance(initial_solver, initial_model)

initial_instance["num_of_established"] = num_of_established
initial_instance["x_coordinates"] = x_coordinates
initial_instance["y_coordinates"] = y_coordinates
initial_instance["n"] = n
initial_instance["population_segment"] = population_segment
initial_instance["business_environment"] = business_environment
initial_instance["num_programs"] = num_programs

initial_result = initial_instance.solve()

print(initial_result, end='')

for ejecucion in range(num_programs):
    final_instance = Instance(final_solver, final_model)

    final_instance["num_of_established"] = num_of_established
    final_instance["x_coordinates"] = x_coordinates
    final_instance["y_coordinates"] = y_coordinates
    final_instance["n"] = n
    final_instance["population_segment"] = population_segment
    final_instance["business_environment"] = business_environment
    final_instance["num_programs"] = num_programs

    final_result = final_instance.solve()

    temp_output = io.StringIO()
    temp_output.write(str(final_result))

    temp_output.seek(0)
    temp_lines = temp_output.readlines()

    last_line = temp_lines.pop(-1)
    values = last_line.split()
    if len(values) == 2:
        value1, value2 = values

    temp_output.close()

    x_coordinates.extend([int(value1)])
    y_coordinates.extend([int(value2)])
    num_of_established += 1

print(final_result, end='')





