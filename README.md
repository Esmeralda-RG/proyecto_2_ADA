# Proyecto 2 - ADA

## Estudiantes
- Pedro Bernal Londoño - 2259548
- Jota Lopez Ramirez - 2259394
- Esmeralda Rivas Guzmán - 2259580

## Descripción General
Este proyecto forma parte de la asignatura de Análisis y Diseño de Algoritmos II (ADA). Su objetivo principal es implementar y resolver problemas utilizando el lenguaje y entorno de MiniZinc, un potente lenguaje para modelado de problemas de programación de restricciones.

El problema planteado consiste en determinar la mejor ubicación para nuevos programas de ingeniería de sistemas en un plano cartesiano n x n. Esto se realiza considerando restricciones como la distancia entre programas existentes, el segmento poblacional, y el entorno empresarial. El proyecto busca optimizar esta ubicación mediante un modelo matemático desarrollado en MiniZinc.

Adicionalmente, se utiliza Python para facilitar la integración y manipulación de datos, aprovechando la biblioteca `minizinc-python`, esta biblioteca permite interactuar de manera eficiente con MiniZinc desde un entorno Python, combinando las capacidades de modelado de restricciones con la flexibilidad de Python.

## Instalación

### Paso 1: Instalación de dependencias
Una vez clonado el repositorio, se deben instalar las dependencias necesarias para ejecutar el proyecto, para ello, ejecute el siguiente comando en una terminal:
```bash
pip install -r requirements.txt
```
### Paso 2: Configuración de entorno virtual en Linux (opcional pero recomendado)
Si se utiliza un sistema operativo Linux, se recomienda crear un entorno virtual para aislar las dependencias del proyecto, puede configurar el entorno virtual con los siguientes comandos:
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```
Esto asegura que las dependencias del proyecto no interfieran con las de otros proyectos o aplicaciones.

### Paso 3: Configuración de MiniZinc
El sistema debe contar con MiniZinc instalado. Si ya se tiene el IDE de MiniZinc, no es necesario realizar configuraciones adicionales. Sin embargo, si solo se dispone del CLI (Command Line Interface), se debe verificar que los siguientes solvers estén instalados:

- **Chuffed**
- **CP-SAT**
- **Gecode**

Para comprobar los solvers disponibles, utilice el siguiente comando:
```bash
minizinc --solver
```

### Importante sobre los Solvers
- **Chuffed**: Es el solver más recomendado para este proyecto debido a su eficiencia en problemas de mayor complejidad, como aquellos que involucran matrices grandes. Este solver está diseñado para optimizar el rendimiento en problemas complejos y suele ofrecer resultados rápidos y consistentes.
- **CP-SAT**: También es adecuado para este proyecto, especialmente en problemas que requieren una alta capacidad de optimización.
- **Gecode**: Aunque es funcional, no es la mejor opción para problemas de gran escala debido a que su rendimiento puede disminuir considerablemente cuando se trabaja con matrices grandes.

### Nota
Es fundamental asegurarse de que los solvers estén correctamente configurados antes de ejecutar cualquier modelo.

## Estructura del Proyecto
El proyecto se organiza de la siguiente manera:
```
.
├── interface.py
├── models
│   ├── final_models.mzn
│   ├── initial_profit.mzn
│   ├── model_variables.mzn
│   └── utils
│       ├── contiguous_coordinates.mzn
│       └── profit_function.mzn
├── README.md
├── requirements.txt
├── test_files
│   ├── test1.txt
│   ├── test2.txt
│   └── test3.txt
└── utils
    └── input_handler.py
```

En la carpeta `test_files` se han incluido tres casos de prueba (`test1.txt`, `test2.txt` y `test3.txt`) para evaluar los modelos desarrollados, estos casos permiten verificar que las restricciones y el objetivo del problema se cumplen correctamente bajo diferentes escenarios.

## Contexto del Problema
El proyecto aborda un problema relacionado con la expansión de programas de ingeniería de sistemas. El profesor plantea las siguientes necesidades y restricciones:

1. **Distancia**: Los nuevos programas no deben estar contiguos a las ubicaciones actuales.
2. **Segmento poblacional**: El punto seleccionado, junto con sus contiguos, debe tener un segmento poblacional mayor o igual a 25.
3. **Entorno empresarial**: El entorno empresarial del punto seleccionado, sumando los contiguos, debe ser al menos 20.

### Datos Iniciales
El país se representa como un plano cartesiano de dimensiones n x n, donde:
- La esquina superior izquierda es la coordenada (0, 0).
- Las localizaciones actuales de los programas son:

| Sede         | Coordenada (x, y) |
|--------------|-------------------|
| Cali         | (6, 8)           |
| Tulua        | (8, 4)           |
| Caicedonia   | (10, 10)         |

Estas ubicaciones no son óptimas y se busca proponer nuevas posiciones considerando las restricciones mencionadas.

