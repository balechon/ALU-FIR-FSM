
# ALU-FIR-FSM

>Este ejemplo muestra el desarollo de sistemas combinacionales y secuenciales, mediante un diseño modular jerarquizado utilizando lenguaje VHDL y compilado en "Xilinx-Vivado 2019.1" el diseño fue pensado para una tarjeta Basys 3 Artix-7 FPGA.

**Colaboradores**
- Nicolas Cobo
- Jamin Orbea
- Brayan Lechón

## Descripción
El sistema se compone de tres modalidades princiaples 
modulo ALU
modulo FIR
modulo FSM 
ademas se cuenta con otros modulos complementarios que que sirven para la sincronizacion del reloj, un modulo conversor a hexadecimal a 7-segmentos para los displays y un selector para elegir el modulo que se quiera ejecutar.
##Diagrama de bloques
![image](https://user-images.githubusercontent.com/75377942/102537841-7f8b7b00-4079-11eb-8ec9-14d476116319.png)

## Modulos Principales
Los modulos principales son FIR, ALU y FSM que muestran sus resultados dependiendo de las variables de entrada 

### ALU
El modulo ALU esta diseñado para que realize cuatro operaciones entre dos variables de entrada. Las operaciones que realiza son suma aritmetica, resta aritmetica, multiplicaion y un desplazamiento circular. De acuerdo al diagrama de bloques anterior tenemos como entradas:

| variable |descripcion   |
| ------------ | ------------ |
|  a |   vector logico 4 bits|
|   b|   vector logico 4 bits|
|   op|  vector logico 2 bits  |

y como salida en el modulo

| variable |descripcion   |
| ------------ | ------------ |
|  resp |   vector logico 4 bits|

### FIR
Se ha implemenado este módulo basado en el libro de *V. A. Pedroni Circuit Desing with VHDL*
![fir](https://user-images.githubusercontent.com/75377942/103013410-17bab180-450b-11eb-8fdf-1b564f7fc392.JPG)

Como variadas de entrada al modulo se tiene: 

| variable |descripcion   |
| ------------ | ------------ |
|  clk |   Reloj interno FPGA|
|   rst |   RESET |
|   a|  vector SIGNED 4 bits  |

y como salida en el modulo

| variable |descripcion   |
| ------------ | ------------ |
|  resp |   vector SIGNED 8 bits|

### FSM
Se ha implementado en este bloque una maquina de estado finita (FSM) basado en uno de los ejercicios del libro de *B. Mealy and F. Tappero Free range VHDL.* 
![image](https://user-images.githubusercontent.com/75377942/103015213-01fabb80-450e-11eb-8d0d-8e30e2a2331e.png)

Como variadas de entrada al modulo se tiene: 

| variable |descripcion   |
| ------------ | ------------ |
|  clk_pul |   Fuente de clk con pulsador|
|  sel_clk |  selector de la fuente de clk|
|   clk_1Hz |  Fuente clk de 1Hz |
|   X1,X2|  entradas externas |

y como salida en el modulo

| variable |descripcion   |
| ------------ | ------------ |
|  salida |   salida concatenacion de Y y X|

##Modulos Complementarios
Estos modulos fueron diseñados para que los modulos principales se puedan ejecutar sin problemas. 

### CLOCK
Se ha desarollado un modulo que genera un divisor de fecuencia para producir una señal de 1Hz. Como variables de entrada se tiene:

| variable |descripcion   |
| ------------ | ------------ |
|  clk_t |  Reloj Interno|


y como salida en el modulo

| variable |descripcion   |
| ------------ | ------------ |
|  clk_salida |  Reloj de 1Hz|
### Hex-7segementos
Se ha desarollado un conversor de codigo hexadecimal a codigo 7-segmentos, este modulo sirve para mostrar los resultados del modulo ALU de una manera mas facil para el usuario. Como variables de entrada se tiene:

| variable |descripcion   |
| ------------ | ------------ |
|  data |  vector logico de 4 bits |

y como salida en el modulo

| variable |descripcion   |
| ------------ | ------------ |
| disp |  vector logico de 8 bits |
|  an |  vector logico de 4 bits |

### Mode Selector
Este modulo fue diseñado para poder elegir entre los tres modulosprincipales del sistema ALU, FIR FSM. Las variables de entrada a este modulo son:

| variable |descripcion   |
| ------------ | ------------ |
|  alu |  vector logico de 4 bits |
|  fir |  vector logico de 8 bits |
|  fsm |  vector logico de 4 bits |
|  sel |  vector logico de 4 bits |

y como salida en el modulo

| variable |descripcion   |
| ------------ | ------------ |
| resp_sel |  vector logico de 8 bits |
|  an |  vector logico de 4 bits |


## Pines I/O  del TOP
Al ser un diseño jerarjico todos estos modulos han sido puestos pajo el TOP principal del proyecto que tendra las variables que definen las entradas y las variables para interactuar con el mod selector. Las variables de entrada a este modulo son:

| variable |descripcion   |
| ------------ | ------------ |
|  a_t |  vector logico de 4 bits |
|  b_t |  vector logico de 4 bits |
|  op_t |  vector logico de 2 bits |
|  rst_t |  vector logico  |
|  clk_puls_t |  vector logico  |
|  sel_t |  vector logico de 2 bits |
|  an_t |  vector logico de 4 bits |
|  clk_t |  vector logico |

y como salida en el modulo

| nombre |descripción   |
| ------------ | ------------ |
| disp_t |  vector logico de 7 bits |
|  resp_sel_t |  vector logico de 8 bits |
|  an |  vector logico de 4 bits |

para la union de los modulos dentro del top se requiere instanciar señales auxiliares.

| nombre |descripción   |
| ------------ | ------------ |
| aux |  vector logico de 8 bits |
|  auxclk |  vector logico  |
|  aux_a |  vector logico de 4 bits |
|  aux_as |  signed 4 bits |
|  aux_rst |  vector logico |
|  salida_fsm |  vector logico de 4 bits |
|  alu2_mode_selector |  vector logico de 4 bits |
|  fsm2_mode_selector |  vector logico de 4 bits |
|  fir2_mode_selector |  Sigend de 8 bits |
