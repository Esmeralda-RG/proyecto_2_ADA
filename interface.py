import ttkbootstrap as ttk
from ttkbootstrap.constants import *
from tkinter import filedialog, messagebox
import tkinter as tk
import minizinc
from minizinc import Model, Solver, Instance
from utils.input_handler import read_input

# Funciones de la interfaz
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

    print(f"Archivo de entrada: {entrada_var.get()}")
    print(f"Solver seleccionado: {solver_var.get()}")

    if not archivo_entrada:
        messagebox.showwarning("Advertencia", "Seleccione un archivo de entrada.")
        return

    if solver_nombre == "":
        messagebox.showwarning("Advertencia", "Seleccione un solver.")
        return

    try:
        datos = read_input(archivo_entrada)

        modelo = minizinc.Model("models/implementation.mzn")
        modelo.add_file("models/utils/earnings_function.mzn")

        solver = Solver.lookup(solver_nombre.lower())
        if solver is None:
            messagebox.showerror("Error", f"No se encontró el solver: {solver_nombre}")
            return
        instancia = Instance(solver, modelo)

        instancia["num_of_established"] = datos["num_of_established"]
        instancia["x_coordinates"] = datos["x_coordinates"]
        instancia["y_coordinates"] = datos["y_coordinates"]
        instancia["n"] = datos["n"]
        instancia["population_segment"] = datos["population_segment"]
        instancia["business_environment"] = datos["business_environment"]
        instancia["num_programs"] = datos["num_programs"]

        resultado = instancia.solve()

        if resultado.status is not None:
            resultado_text.set(str(resultado.solution))
            resultado_textbox.delete(1.0, tk.END)  # Limpiar el texto anterior
            resultado_textbox.insert(tk.END, str(resultado.solution))  # Mostrar el nuevo resultado
        else:
            messagebox.showinfo("Sin solución", "No se encontró una solución para los datos proporcionados.")
    except Exception as e:
        messagebox.showerror("Error", f"Ocurrió un error al ejecutar el modelo: {e}")

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

# Configuración de la ventana principal
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

solver_combobox = ttk.Combobox(ventana, textvariable=solver_var, values=["Gecode", "Chuffed", "CP-SAT"], bootstyle="info")
solver_combobox.pack(pady=5)

btn_ejecutar = ttk.Button(ventana, text="Ejecutar", command=ejecutar_solver, bootstyle="primary")
btn_ejecutar.pack(pady=10)

lbl_resultado = ttk.Label(ventana, text="Resultado:", bootstyle="secondary")
lbl_resultado.pack(pady=5)

# Frame para el texto con scroll
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