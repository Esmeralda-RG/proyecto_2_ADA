from minizinc import Instance, Model, Solver
from utils.input_handler import read_input

data = read_input("input.txt")

num_of_established = data["num_of_established"]
x_coordinates = data["x_coordinates"]
y_coordinates = data["y_coordinates"]
n = data["n"]
population_segment = data["population_segment"]
business_environment = data["business_environment"]
num_programs = data["num_programs"]

print("num_of_established:", num_of_established)
print("x_coordinates:", x_coordinates)
print("y_coordinates:", y_coordinates)
print("n:", n)
print("population_segment:", population_segment)
print("business_environment:", business_environment)
print("num_programs:", num_programs)




