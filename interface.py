"""
Pedro Bernal Londoño - 2259548
Jota Emilio Lopez Ramirez - 2259394
Esmeralda Rivas Guzmán - 2259580
"""
import ttkbootstrap as ttk
from ttkbootstrap.constants import *
from tkinter import filedialog, messagebox
import tkinter as tk
import io
from minizinc import Model, Solver, Instance
from utils.input_handler import read_input

def seleccionar_archivo():
    archivo = filedialog.askopenfilename(
        title="Seleccionar archivo de entrada",
        filetypes=[("Archivos de texto", "*.txt"), ("Todos los archivos", "*.*")]
    )
    if archivo:
        entrada_var.set(archivo)

def ejecutar_solver():
    solver_nombre = solver_var.get()
    archivo_entrada = entrada_var.get()

    if not archivo_entrada:
        messagebox.showwarning("Advertencia", "Seleccione un archivo de entrada.")
        return

    if solver_nombre == "":
        messagebox.showwarning("Advertencia", "Seleccione un solver.")
        return

    lbl_estado["text"] = f"Ejecutando el solver '{solver_nombre}'..."
    ventana.update()

    try:
        data = read_input(archivo_entrada)

        num_of_established = data["num_of_established"]
        x_coordinates = data["x_coordinates"]
        y_coordinates = data["y_coordinates"]
        n = data["n"]
        population_segment = data["population_segment"]
        business_environment = data["business_environment"]
        num_programs = data["num_programs"]

        initial_model = Model("models/initial_profit.mzn")  
        solver = Solver.lookup(solver_nombre.lower())
        if solver is None:
            messagebox.showerror("Error", f"No se encontró el solver: {solver_nombre}")
            return
        initial_instance = Instance(solver, initial_model)

        initial_instance["num_of_established"] = num_of_established
        initial_instance["x_coordinates"] = x_coordinates
        initial_instance["y_coordinates"] = y_coordinates
        initial_instance["n"] = n
        initial_instance["population_segment"] = population_segment
        initial_instance["business_environment"] = business_environment
        initial_instance["num_programs"] = num_programs

        initial_result = initial_instance.solve()

        final_model = Model("models/final_models.mzn")
        for ejecucion in range(num_programs):
            final_instance = Instance(solver, final_model)

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
        
        if initial_result.status is not None and final_result.status is not None:
            resultado_textbox.delete(1.0, tk.END)
            resultado_textbox.insert(tk.END, str(initial_result.solution))
            resultado_textbox.insert(tk.END, str(final_result.solution))
        else:
            messagebox.showinfo("Sin solución", "No se encontró una solución para los datos proporcionados.")
    except Exception as e:
        messagebox.showerror("Error", f"Ocurrió un error al ejecutar el modelo: {e}")
    finally:
        lbl_estado["text"] = "Proceso terminado."
        ventana.update()

def guardar_resultado():
    archivo_salida = filedialog.asksaveasfilename(
        title="Guardar resultado",
        defaultextension=".txt",
        filetypes=[("Archivos de texto", "*.txt"), ("Todos los archivos", "*.*")]
    )
    if archivo_salida:
        try:
            with open(archivo_salida, "w") as f:
                f.write(resultado_textbox.get(1.0, tk.END).strip())
            messagebox.showinfo("Guardado exitoso", "El resultado se guardó en: " + archivo_salida)
        except Exception as e:
            messagebox.showerror("Error", f"Ocurrió un error al guardar el archivo: {e}")

ventana = ttk.Window(themename="journal")
ventana.title("Interfaz MiniZinc")
ventana.geometry("1000x800")

entrada_var = ttk.StringVar()
solver_var = ttk.StringVar()
resultado_text = ttk.StringVar()

lbl_entrada = ttk.Label(ventana, text="Archivo de entrada:", bootstyle="secondary")
lbl_entrada.pack(pady=5)

entrada_entry = ttk.Entry(ventana, textvariable=entrada_var, width=50)
entrada_entry.pack(pady=5)

btn_seleccionar = ttk.Button(ventana, text="Seleccionar", command=seleccionar_archivo, bootstyle="primary")
btn_seleccionar.pack(pady=5)

lbl_solver = ttk.Label(ventana, text="Seleccionar solver:", bootstyle="secondary")
lbl_solver.pack(pady=5)

solver_combobox = ttk.Combobox(ventana, textvariable=solver_var, values=["Chuffed", "CP-SAT", "Gecode"], bootstyle="info")
solver_combobox.pack(pady=5)

btn_ejecutar = ttk.Button(ventana, text="Ejecutar", command=ejecutar_solver, bootstyle="primary")
btn_ejecutar.pack(pady=10)

lbl_estado = ttk.Label(ventana, text="", bootstyle="info")
lbl_estado.pack(pady=5)

lbl_resultado = ttk.Label(ventana, text="Resultado:", bootstyle="secondary")
lbl_resultado.pack(pady=5)

frame_resultado = ttk.Frame(ventana)
frame_resultado.pack(pady=5, fill="both", expand=True)

resultado_textbox = tk.Text(frame_resultado, wrap="word", height=20, bg="#FFF0F0", relief="solid")
resultado_textbox.pack(side="left", fill="both", expand=True)

scrollbar = ttk.Scrollbar(frame_resultado, command=resultado_textbox.yview)
scrollbar.pack(side="right", fill="y")

resultado_textbox.config(yscrollcommand=scrollbar.set)

btn_guardar = ttk.Button(ventana, text="Guardar resultado", command=guardar_resultado, bootstyle="primary")
btn_guardar.pack(pady=10)

ventana.mainloop()