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

programs = Model("models/final_models.mzn")  

gecode = Solver.lookup("gecode")

instance = Instance(gecode, programs)


instance["num_of_established"] = num_of_established
instance["x_coordinates"] = x_coordinates
instance["y_coordinates"] = y_coordinates
instance["n"] = n
instance["population_segment"] = population_segment
instance["business_environment"] = business_environment
instance["num_programs"] = num_programs

result = instance.solve()

print("Resultado:", result)
