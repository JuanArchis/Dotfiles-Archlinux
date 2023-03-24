

# 									Python machine learning

# 					Capítulo 1: Definiciones y conceptos preliminares

**Aprendizaje supervisado:**  TIpo de aprendizaje en el cuál los datos de entrenamiento ya están etiquetados y, por ende, las salidas del modelo se conocen. Se conoce como aprendizaje supervizado en gran medida porque los datos indican la esencia del modelo (básciamente le dicen qué hacer).  *Verbigracia, las tareas de calsificación y/o regresión (predicción)* .

**Aprendizaje reforzado:** Consiste en dejar que el modelo aprenda de su entorno, ofreciendo una retroalimentación en función de una medida de "recompensa", así, con base en esta, dicho modelo aprenderá a minimizar las recompensas negativas.  *A saber, el ejemplo más tribial, los algoritmos de ajedreź; otro ejemplo pertinente es el campo de la robótica, más específicamente, enseñarle al robot aprender a mover las manos. Pues, en lugar de enseñarle paso por paso, se deja que este aprenda de su entorno (tipo prueba y error).*  

**Aprendizaje no supervisado:** Parte de datos de entrenamiento que no establecen una categorías a priori. Se busca establecer estructuras ocultas en los datos con base en una variable de salida o función de recompensa. *Por ejemplo, los agrupamientos o clustering; las categorías que dicho modelo establece no están fundadas por las categorías de los datos de entrenamiento, generalmente están fundadas en una medida de distancia.  El aprendizaje permite, por ejemplo, a vendedores, descubrir grupos de clientes basados en otras medidas.*

- Una sub categoría del aprendizaje no supervizado es la reducción de dimensionalidad. Esta permite, enfunción de una pocas variables ficticias, explicar todas las variables sin perder la mayori nformación que las variables en conjunto ofrecen (también es útil para la visualización de datos). No es necesario realizarlo antes del análisis clúster, empero, dichos algoritmos de agrupación basan su funcionamiento en distancias y, se ha demostrado que en dimensiones altas, las distancias cortas y largas tienden a ser uniformes. *"La premisa de la búsqueda del vecino más cercano es que los puntos "más cercanos" son más relevantes que los puntos "más lejanos", pero si todos los puntos están esencialmente uniformemente distantes entre sí, la distinción no tiene sentido."*

- *Nuestras intuiciones, que provienen de un mundo tridimensional, a menudo no se aplican en los de alta dimensión. En dimensiones altas, la mayor parte de la masa de una distribución gaussiana multivariada no está cerca de la media, sino en una "capa" cada vez más distante a su alrededor; y la mayor parte del volumen de una naranja de grandes dimensiones está en la piel, no en la pulpa. **Léase:** https://homes.cs.washington.edu/%7Epedrod/papers/cacm12.pdf

**Étapas del modelado:** Anteriormente se habló de los distintos tipos de aprendizaje, sin embargo, cada aprendizaje debe seguir una estructura de modelado en forma general; dicha estructura está compuesta por los siguientes pasos:

- Pre-procesamiento: Consiste en dar forma a los datos con base en el modelo a usar. Por ejemplo, algunos modelos requieren datos estandarizado o que estén en un mismo rango; o a su vez, los datos presentan variables irrelevantes o que están correlacionadas con otras y por ende su aporte se puede ver en función de otra variable (también si se quiere eliminar el ruido que generan algunos variables), en tal caso se usarían las técnicas de reducción de dimensiones antes del modelado. La etapa de pre-procesamiento es fundamental, ya que esta depura y/o prepara el alimento del modelo.

- Entrenamiento y selección: En esta etapa se entrena el modelo y, se busca comparar  varios modelos (ya que raramente un problema sólo tiene una respuesta) con base en la valdiación cruzada (busca separar datos de entrenamiento y datos de validación).

- Evaluación y predicción: La validación cruzada es un método fundamental con el cual, no sólo se valida el modelo sino que también se valida la predicción para nuevos datos. Si el modelo se entrena con todos los datos y se valida con estos mismos, este puede recoger el ruido o la variabildiad de los datos (el modelo no aprende, memoriza).

# 			Capítulo 2: Algoritmos simples de aprendizaje automático para la clasificación 

## 							Perceptrón de Rosenblatt

Los inicios más remotos del aprendizaje automático se reflejan en la representación de una neurona humana a una simplificación matemática, Considérese a la neurona como combinación lineal de los valores de entrada y  pesos. Si su tarea es la clasificación binaria, los pesos son los parámetros que se optimizarán de tal forma de encontrar una clasificación pertinente. Definase la combinación linal como:
$$
Z=w_1x_1+w_2x_2+w_3x_3+...
$$

 Dicho perceptrón viene antepuesto por una función $\phi(z)$ , llamada función de decisión (Indica la clasificación que tendrá la salida de la función $Z$ con base en el umbral $\theta$). Por, ejemplo:

$$
\phi(Z)=\begin{Bmatrix}
1 ; z\geq \theta \\ -1; otro
\end{Bmatrix}
$$
Así, si la entrada de red de una muestra concreta es mayor al umbral, el perceptrón predecirá 1. Para efectos prácticos y de simplificación, el hiperparámetro $\theta$ se considerará como un parámetro más de la función $Z$ (pasando este a restar). La nueva función de decisión $\phi(z)$ será: 

$$
\phi(Z)=\begin{Bmatrix}
1 ; z\geq 0 \\ -1; otro
\end{Bmatrix}
$$
Donde 

$$
Z=w_0x_0+w_1x_1+w_2x_2+w_3x_3+...=W^TX
$$
Y también

- $w_0=-\theta$ será el intercepto (sesgo o bias) con el eje y cuando $x=0$

- $x_0=1$

Al reescribir de esta forma la función $Z$, es posible la estimación del umbral como uno más de los pesos de la neurona.  La función $\phi(Z)$, o comunmente denomianda como escalón, sigue la siguiente gráfica:

## 													Aprendizaje del perceptrón

Ahora bien, el trabajo de aprendizaje es básicamente la forma en que aprende el  algoritmo con base en los datos, es decir, la forma de estimación del vector de parámetros o pesos $W$, pues estos indican en mayor medida el grado de activación de la neurona.  Los pasos del perceptrón inicial de Rosenblatt son:

1. Iniciar la neurona con pesos iguales o cercanos a 0.

2. Para cada dato de entrenamiento $X_i$, calcular la predicción correspondiente $\hat{Y}$. Con base en la predicción anterior, calcular de nuevo los pesos.

Así, la actualización de los pesos del vector $W$ se pueden escribir como:

$$
w_j=w_j+\Delta w_j
$$


Donde $w_j$ es el valor inicial dado de este y, $\Delta w_j$ indica el cambio con el que se actualizará el parámetro $w_j$. El cambio en el peso está dado por:

$$
\Delta w_j=\eta (y_i-\hat{y_i})x_{ij}
$$

- $\eta: \in(0,1] $ : Es una constante , denominada como ratio o tasa de aprendizaje. Hiperparámetro que para las redes multicapas, controlen la velocidad o el paso con el que aprende el algoritmo (si la tasa es muy baja da paso muy cortos y este no puede ser óptimo en tiempoy, si por otro lado es muy alta, da pasos muy alrgos y puede perderse en la estimación).

- $y_{i(n*1)}:$ Es la etiqueta, en función de 0 o 1 (es decir, la etiqueta real ya clasificada con base en la función de activación $\phi(Z)$) . Note que se ejecuta por cada fila de la variable de respuesta.

- $x_{ij (n*p)}$: Es la observación de la variable $j$ en la fila $i$.

  #### 																									Importante

Note que el algoritmo se ejecuta por observaciones, es decir, la actualización de los parámetros $\Delta w_j$ recorre cada observación  $i$ asociada al parámetro a estimar (**cada parámetro tendrá $i$ estimaciones que se multiplicarán por cada observación $x_{ij}$ asociada**). Esta metodología  de aprendizaje se conoce como ley de Hebb. Básicamente, la estimación varía de acuerdo a cada observación, por esto $w_j=w_j+\Delta w_j$ (**la actualización indica el aprendizaje por cada observación $x_{ij}$**); el parámetro aprende de cada observación de su variable asignada. ***Así, el valor de los parámetros estimados será la última actualización (salida) que contendrá el aprendizaje de todas las demás observaciones. Note que si la predicción es correcta, $\Delta w_j=0$ y no afecta la estimación anterior.***

De igual forma, la estimación del bias  será: $\Delta w_0=\eta (y_i-\hat{y_i})$. Igualmente se ejecuta por diferencia de la variable de respuesta. Se selecciona la última actualización que contiene los demás aprendizajes. 

El aprendizaje de forma matricial es:
$$
\mathbf{\Delta w_j}=\eta (\mathbf{y_i}-\mathbf{\hat{y_i}})\mathbf{x_{j}}
$$

#### 																					Utilidad de la función de Hebb

La utilidad de la función de actualización de los parámetro $\Delta w_j$ radica en la posibilidad de variar cada peso hasta conseguir arrastar las predicciones incorrectas a las predicciones correctas, dado que, si la neurona o perceptrón predice correctamente la etiqueta de clase, los pesos no cambian.
$$
\Delta w_j=\eta(1-1)x_{ij}=0
$$

$$
\Delta w_j=\eta(-1-(-1))x_{ij}=0
$$

Si por otro lado, la predicción es errónea, los pesos se verán empujados hacia la dirección en la que debe ir la clase (esto hace que, la próxima vez que se encuentre con esa misma muestra, la actualización del parámetro sea mayor en función de su predicción y así superar el umbral, ya sea de forma negativa o positiva). Por ejemplo, si $x_{ij}=0.5,\eta =1, \hat{y_i}=-1,y_i=1$
$$
\Delta w_j=(1-(-1))0.5=1
$$
En este caso, la actualización es 1, es decir, la próxima vez que la neurona se encuentre con la misma muestra, es más probable que estuviera por encima del umbral de la función escalón unitario. Si por ejemplo, $x_{ij}=2, \Delta w_j=4$; Lo que hace más probable clasficiarlo correctamente la próxima vez. Note que cada cambio tendrá un error, $\epsilon_i$, en las iteraciones del algoritmo sólo se consible el último error procediente de la última actualización.



**Es importante remarcar que la convergencia anterior sólo se da para clasificaciones LINEALES (Si no son lineales, los pesos no dejarían de actualizarse). Para clasificaciones más complejas se utilizan las redes neuronales multicapas**

![image-20221212143011614](/home/juan-c/.config/Typora/typora-user-images/image-20221212143011614.png)

Resumiendo el apartado anterior, la estructura de una neurona o perceptrón es:

![image-20221212143036684](/home/juan-c/.config/Typora/typora-user-images/image-20221212143036684.png)

El anterior dragrama muestra cómo la neurona recibe las entradas $ X $de $m$ variables y las combina con los pesos $W$, para que la entrada sea la suma de lo anterior. A continuación la entrada pasa por la función umbral que genere una salida binaria. Durante el aprendizaje la salida predicha se utiliza para clacular el error y con base en este actualizar los pesos o estimar los parámetros de la neurona.

### 													Implementación del perceptrón neurona en python

#### 																								A priori al código

- Class

En python existen estructuras tipo clase (class). Esta básicamente comple la función de clasificar varios objetos (o funciones) en clases creadas, a saber:

```python
class Fracción: # Defino una clase llamada Fracción

    def imprime(self,num,den): # Se crea un objeto de clase o función llamada imprime, con argumentos num y den
        self.num=num  # se definen las variable de objeto num y dem iguales a los parámetros de entrada de la clase
        self.den=den  
        print(self.num,"/",self.den) # se aplica la función se imprimir

    def división(self): # DEfino otra función, al refereenciar el anterior selft, me permite usar los parámetros num y den
        # con los valores asignados al llamarla anteriormente
        print(self.num/self.den)

a=Fracción()  # Define la variable a como clase Fracción
a.imprime(1,2) # aplico el objeto o función imprime
a.división() # se aplica el objeto división con los parámetros anteriores
```

Como se evidencia en el ejemplo anterior, una clase permite crear una estructura con varios objetos (o funciones) y poder utilizar cada una de estas. 

- Return

El retornot de una función es importante porque esta permite que, dados los parámetros de una función establecida, esa linea sea igual al valor devuelto. Por ejemplo:

```python
def suma(a,b):
    a+b
suma(2,3)
------- > No imprime nada, dado que la función se ejecuta pero suma(2,3) 
no es igual a nada. Por el contrario, si se utiliza el return.



def suma(a,b):
 return a+b
suma(2,3)
------- > 5. Esto indica que suma(2,3) es intercambiado por el valor 5. 
- suma(2,3)=5 de forma literal
```

#### 																		Implementación del perceptrón de rosenblatt

```python
"------------ Importando librerias de python------------------"

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
"------------ Perceptrón de rosenblatt------------------"

class Perceptron(object): # Define la neurona como clase (de tal forma que dentro de esta tenga todlas las funciones y salidas necesarias)
    """Percetrón básico (clasificación lineal binaria).

    Hiperpaŕametros
    ------------
    eta: Es el hiperparámetro de tasa de aprendizaje [0.0 a 1.0]

    n_iter: Hiper parámetro que controla en número de iteraciones (En redes neuronales adaptativas se elimina este)

    random_state : Semilla (paragenerar los pesos iniciales, estos se generan con base en una D~N(0,0.01))

    Atributos
    -----------
    w_ : Pesos después del ajuste n_iter1

    errors_ : Errores en cada ajuste n_iter

    """
    def __init__(self, eta, n_iter, random_state): # Definir una función que contendrá los hiperparámetros anteriores
        self.eta = eta
        self.n_iter = n_iter
        self.random_state = random_state

    def fit(self, X, y):  #Define otra función que contrendrá los datos de entrenamiento (X) y los datos objetivos (Y)
        """Fit training data.

        Parameters
        ----------
        X : Matriz de datos de entrenamiento (MATRIZ X)
        y : Vector de variable de respuesta (Variable binaria)

        Returns
        -------
        self : object

        """
        rgen = np.random.RandomState(self.random_state) # Semilla
        self.w_ = rgen.normal(loc=0.0, scale=0.01, size=1 + X.shape[1]) # Generación de los pesos iniciales (Cercanos a 0) con base en la semilla
        # Note que el tamaño de la cantidad de  pesos está controlado por 1+X.shape[1], este indica que se tomaran tantos pesos como variables (columnas) y además, se toma w0 (bias)
        self.errors_ = [] # Se define el vector de errores

        """ Aquí empieza el algoritmo per se (la parte iterativa). Esta implementación NO hace uso de notación matricial, en su reemplazo, usa la el cliclo zip, para ejecutar cada paso individualmente (tipo listas) """

        for _ in range(self.n_iter): #Ejecuta el ciclo sin la necesidad de establecer la variable iterativa (i); este itera la cantidad dada por el hiperparámetro
            errors = 0 # DEfine el error en 0
            for xi, target in zip(X, y): # La función zip(X,y) permite ejercutar un cliclo en paralelo (este permite trabajar individualmente con cada posición de los vectores)
             # note que como entrada recibe la matriz X y el vector y, luego los denomina como xi y target. El proceso se repite por cada posición [i], eso lo hace el target zip.

                update = self.eta * (target - self.predict(xi)) # Se crea el cambio de los pesos con base en el criterio  de hebb (note que el cliclo trabaja por filas).             
                self.w_[1:] += update * xi # actualiza (+= actualiza una variable si no es lista, en caso de ser lista une los valores respetando posición) y multiplican con cada variable (finalizando la maximización) y actulizando del vector de pesos [w_1,..w_n] 
                self.w_[0] += update # Se actualiza el parámetro bias o sesgo (w_0). Note que el poerador += Suma un valor y la variable y asigna el resultado a esa variable. 
                errors += int(update != 0.0) # Se cuantifica el error en un boleano (si es diferente de 0, arroja 1 al error, caso contrario es 0). Note que se suman con el error anterior de la iteración, por esto el +=.
            self.errors_.append(errors) # actualiza el vector de error definido anteriormente añadiendole por la derecha el valor del error anteriormente calculador (creando así un vector de errores por cada peso)
        return self #Devuelve todas las intancias que llamó

    def net_input(self, X): # Se crea una nueva función que contendrá las nuevas entradas (Note que con seflt llama las entradas anteriores que usa, X)
        """Calculate net input"""
        return np.dot(X, self.w_[1:]) + self.w_[0] #Calcula el producto punto de X y el vector W (seleciona las últimas salidas del ciclo), después lo suma con el bias. Finalmente lo devuelve (net_input(self, X) será igual al resultado)

    def predict(self, X): # Se establece la función que predice la clase
        """Return class label after unit step"""
        return np.where(self.net_input(X) >= 0.0, 1, -1) # Primero crea la condición de, si la suma ponderada (función anterior) es mayor que 0, este es 1, caso contrario -1.

```

**Es pertinente remarcar que el perceptrón no se limita a la clasificación binaria, para más consulte la técnica One-Versus-All (Ova)**

### 																				Ejemplo: Data iris

Para simplificación gráfica y demás, se usaŕa una clasificación binaria como ejemplo. SEeconsidera iris con sólo dos categorías (Versicolor y Setosa). La representación gráfica seŕa:

```python
"------------ Construyendo los datos------------------"

Iris = pd.read_csv('https://archive.ics.uci.edu/ml/'
    'machine-learning-databases/iris/iris.data', header=None) # Iimportando data desde la web

"Note que se utilizará el criterio de validación cruzada para eliminar el sobreajuste de los datos (100 de entrenamiento y 50 de validación)"
# - Definir la variable categórica de respuesta

Y=Iris.iloc[0:100,4]# Se extraen las 100 primeras filas y la cuarta columna. datapandas.iloc donde ilos es la función para extraer columnas y filas en formato pandas
#- Clasificar la variable de respuesta

Y=np.where(Y=="Iris-setosa",1,-1)


# - Definir las covariables

X=Iris.iloc[0:100,[0,2]].values # Se extraen las 100 primeras filas y las columnas lóngitud de sépalo [,0] y lóngitud del pétalo [,2]. El argumento .value devuelve la salida en formato listas de python.
    # la librería de gráficas maplotib no grafica data tipo pandas


"------------ Representación gráfica------------------"

plt.scatter(X[:50,0], X[:50,1],color="blue",label="Versicolor",marker="o")#plt.show muestra las gráficas (esto por ser usuario de arch)
plt.scatter(X[50:100,0], X[50:100,1],color="red",label="Virginica",marker="x");plt.ylabel("Lóngitud del pétalo");plt.xlabel("Lóngitud del Sépalo")
plt.legend(loc="upper left");plt.show()
```

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-20-16-25-image.png)

Note que el problema se puede solucionar claramente por un separador lineal (persetrón básico de rosenblatt)

### 																	Implementando el percetrón a Iris

Ahora, implementando el perceptrón al problema de clasificación anterior tenemos:

```python
"------------ Perceptrón en Iris------------------"

Perceptron_apli=Perceptron(0.1,10,1) # Se definen los hiper parámetros y al objeto se le llama Percentrón_apli
Perceptron_apli.fit(X, Y) # Se seleciona la clase fit del percentrón_apli y se definene los valores de entrada

# Gŕafica de los errores
plt.plot(range(1,len(Perceptron_apli.errors_) + 1) ,Perceptron_apli.errors_,marker="o");plt.xlabel("Cantidad de iteraciones");plt.ylabel("Errores en cada iteración")
plt.show()
```

Graficando el número de iteraciones (10, indicadas en los hiperpaŕametros) vs el error debido a la estimación final cuantificado en cada iteración, se tiene:

![image-20221212151243119](/home/juan-c/.config/Typora/typora-user-images/image-20221212151243119.png)

Como se observa, la gráfica resulta pertinente para concluir la cantidad de iteraciones óptimas. En un problema real, iterar demás es ineficaz, e iterar de menos no es óptimo. En este caso, el algoritmo tiene predicciones optimas con 6 iteraciones. 

#### TENGA CUIDADO CON IMPLEMENTAR EL PERCEPTRÓN BÁSICO DE ROSENBLATT

**El perceptrón básico de rosenblatt clasifica a la perfección sólo si las dos clases pueden ser separadas perfectamente por un hiperplano lineal, en caso contrario, los pesos nunca dejarán de actualizarse.**



![image-20221212152646482](/home/juan-c/.config/Typora/typora-user-images/image-20221212152646482.png)

## Neuronas lineales adaptativas (Adaline)

Publicada por Bernard Widrow y su alumno Ted Hoff a unos pocos años del perceptrón de Rosenblatt, esta presenta una mejora a la unidad neuronal; pues permite clasificar datos que no necesariamente pueden ser separadas por un hiperplano lineal. Recuerde que el perceptrón básico estimaba sus pesos con base en la función escalón unitario, Adaline actualiza sus pesos con base en una función de activación lineal. En pocas palabras, la función de activación en el perceptrón era:
$$
\phi(Z)=\begin{Bmatrix}1 ; z\geq 0 \\ -1; otro\end{Bmatrix}
$$
Ahora, en Adaline la función de activación viene a ser la misma entrada (note que $Z$ de por sí ya es una combinación o función lineal), es decir:
$$
\phi(Z)=W^tX
$$
La diferencia se puede ver de forma más intuitiva con la siguiente imagen:

![image-20221216204059391](/home/juan-c/.config/Typora/typora-user-images/image-20221216204059391.png)

En resumen, mientras que el perceptrón para aprender/actualizar los pesos utiliza las clases verdaderas y las predichas **ya clasificadas**, Adaline compara las clases verdaderas con las **salidas continuas (de la activación lineal) sin clasificar**.

### Aprendizaje de Adaline

Como se busca mayor precisión en la predicción, Adaline utiliza las salidas de la suma ponderada, de esta forma puede compararlas con la etiqueta de clase de forma más precisa. Todos los modelos estadísticos requieren cuantificar el error de sus predicciones, de esta forma se estiman los parámetros. Para los modelos de regresión lineal clásicos, dicha función de error (o costo) viene a ser el **Error cuadrático medio (La lógica de esta es similar a la varianza, pues la función da el promedio de las desviaciones entre la etiqueta y su predicción)**. La función de SSE (o Suma de cuadrados de los errores) es:
$$
E(w)=\sum_{i=1}^n(Y_i-\phi(Z_i))^2
$$
Una ventada de la función SSE que es convexa (Sólo un max y un min) y por lo tanto, diferenciable. Dado lo anterior es posible actualizar los pesos de tal forma que el SSE sea mínimo (Con el criterio de las derivadas o el descenso del gradiente). **Note que $\hat{Y_i}=\phi(Z_i)=W^tX$, y lo que se quiere es encontrar la combinación del vector de los pesos $W$ que  minimicen la función Error (SSE). **  El problema anterior se resuelve fácilmente con la derivada parcial de la función de costo $SSE$ respecto a $W$, es decir, encontrando el vector gradiente (dado que $W$ es un vector, se recurre a la derivada multivariable o su vector representativo, el gradiente); **empero, dado que para futuros modelos con función de activación no lineal y donde la función de Error puede ser no convexa se usa el algoritmo del descenso del gradiente, y este conviene introducirlo de una vez.**

### Descenso de gradiente

Algoritmo aplicable para funciones de costo convexas y no convexas (con varios mínimos relativos). La lógica es la siguiente: 

![image-20221216213709500](/home/juan-c/.config/Typora/typora-user-images/image-20221216213709500.png)

Busca alcanzar el mínimo de la función dando "pasos" en la función de ERROR con base en el gradiente, esto utilizando valores de $W$ aleatorios y pequeños para posteriormente, actualizarlos con la derivada. 

**Lo tradicional sería encontrar $\frac{\partial^2 E}{\partial (w_j)^2}=0$ y posteriormente despejar $w_j$**; empero, algunas funciones de error o costo son complejas en cuanto a derivación, ni se hable de segundas derivas, por tanto, el proceso tradicional de maximización es casi imposible. De aquí se hace uso del gradiente de una función mutivariable, pues este da la dirección de crecimiento de la función. Pero como se quiere la variación de $w_j$ que hace decrecer el Error, se multplicara por $-1$ para que cada vez decrezca la función. Así, por cara iteración se encontrara una combinación de parámetros que cada vez se aproximará más al mínimo global.

### Descenso del gradiente en Adaline

Entonces.
$$
\Delta w_j=-\eta \nabla E (w)
$$
Donde $\nabla E$ indica el vector gradiente, es decir, el vector de  las derivadas parciales de la función $E$ en cada peso a $w_j$:
$$
\nabla E (w_j)=\frac{\partial E}{\partial w_j}=-\sum_{i=1}^n(Y_i-\phi(Z_i))x_{ji}
$$
Note que en $(14)$ el vector gradiente se multiplica por la tasa de aprendizaje $\eta$ y $-1$; se multiplica por el negativo dado que, por definición, el vector gradiente tiene dirección creciente, pero como queremos encontrar el mínimo, debemos cambiar de sentido la dirección del vector $\nabla E(w)$. Con base en $(14)$ y $(15)$ se puede escribir la actualización de los pesos de la siguiente forma:
$$
\Delta w_j=-\eta \frac{\partial E}{\partial w_j}=\eta \sum_{i=1}^n(Y_i-\phi(Z_i))x_{ji}
$$
Donde, la regla de aprendizaje será análoga al perceptrón básico, es decir (matricialmente): 
$$
W:=W+\Delta W
$$
**Note que a diferencia de la regla de aprendizaje de Hebb, Adaline aprende en conjunto con todas las filas (observaciones) de la matriz $X$, no de manera gradual como el preceptrón (recuerde que este utilizaba fila por fila y se seleccionaba la última como estimación). COMO NOTA PERTINENTE,  $SSE$ ES MULTIPLICADO POR $\frac{1}{2}$ PARA FACILITAR LA DERIVACIÓN**

## Adaline en python

La forma del código de Adaline en python es bastante similar al perceptrón, pues lo único que cambia es el método de estimación o entrenamieto (la clase "fit" en el código). El código será:



```python
"------------ Importando librerias de python------------------"

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

"------------ ADALINE------------------"

class Adaline(object):
    """Neurona linal adaptativa.

    Parámetros
    ------------

    Hiperpaŕametros
    ------------
    eta: Es el hiperparámetro de tasa de aprendizaje [0.0 a 1.0]

    n_iter: Hiper parámetro que controla en número de iteraciones (En redes neuronales adaptativas se elimina este)

    random_state : Semilla (paragenerar los pesos iniciales, estos se generan con base en una D~N(0,0.01))


    Atributos
    -----------
    w_ : Pesos después del ajuste n_iter1

    errors_ : Errores en cada ajuste n_iter

    """
    def __init__(self, eta, n_iter, random_state): # Definir una función que contendrá los hiperparámetros anteriores
        self.eta = eta
        self.n_iter = n_iter
        self.random_state = random_state

    def fit(self, X, y): # Define la función de entrenamiento
        """Fit Parte de entrenamiento.

        Parámetros
        ----------
        X : Matriz de datos de entrenamiento (MATRIZ X)
        y : Vector de variable de respuesta (Variable binaria)

        Returns
        -------
        self : object

        """
        rgen = np.random.RandomState(self.random_state) # Semilla
        self.w_ = rgen.normal(loc=0.0, scale=0.01, size=1 + X.shape[1]) #Valores de parámetros iniciales
        self.cost_ = [] # Agrega la función error o costo
       
        for i in range(self.n_iter): # Comienza la parte iterativa del algoritmo
            net_input = self.net_input(X) # Recoje el vector X^t * W como entrada
            output = self.activation(net_input) # Recoje la salida de la función de activación (en este caso la función es lineal por lo cuál no hace nada)
            errors = (y - output) # Cálcula el error, restando la predicción real y la salida de suma ponderada (recuerde que la predicción de cada observación se guarda en un vector)
            """Note que la forma de aprendizaje ya está dada por la derivada encontrada, no se hace uso del algoritmo del gradiente"""
            self.w_[1:] += self.eta * X.T.dot(errors) # Actualiza los parámetros W, multiplicando el hiperparámetro eta por X^t * E (producto matriz y vector), note que E=y-z(phi) 
            self.w_[0] += self.eta * errors.sum() # Actualiza el BIAS
            cost = (errors**2).sum() / 2.0 # Cuantifica la función de Error o costo (SSE); erros^2.sum(cost): suma los errores al cuadrado
            self.cost_.append(cost) # asgina el error de cada iteración
        return self

    def net_input(self, X):
        """Calcula la suma ponderada, es decir, realiza el producto entre X y el vector de parámetros W para posteriormente sumalo con el vector de BIAS"""
        return np.dot(X, self.w_[1:]) + self.w_[0] #Note que el cálculo es de forma matricial, en este caso se usa np.dot poque python supone son de clase np.array. 
        #LA SALIDA ES UN VECTOR DE OBSERVACIONES (PREDICCIONES)

    def activation(self, X):
        """Funicón de activación (Como en este caso es linal, es irrelevante. En regresión logística tomaŕa inportancia esta función) """
        return X

    def predict(self, X):
        """Crea las predicciónes con base en la función escalón"""
        return np.where(self.activation(self.net_input(X)) >= 0.0, 1, -1) # Utiliza la salida vector de net_input para establecer las etiquetas de prediciones
```



### Importancia del hiperparámetro $\eta$ o tasa de aprendizaje

Como se dijo anteriormente, la tasa de aprendizaje es un hiperparámetro fundamental, dado que si este es muy bajo, la estimación de los parámetros será muy lenta, debido a que el número de iteraciones requerido será mayor; si por el contrario este es muy alto, dará estimaciones erroneas, se perderá en la estimación de los parámetros. Como ilustración tome use el siguiente ejemplo:



```python
"------------ Ejemplo de importancia tasa de aprendizaje------------------"

fig, ax = plt.subplots(nrows=1, ncols=2, figsize=(10, 4)) # Define un lienzo partido en dos columnas, análogo a lo que hace mforwn en R. Note que crea un plot llamado ax

# Primer gráfico en lienzo
ada1 = Adaline(n_iter=10, eta=0.01,random_state=1).fit(X, Y) # Define los hiperparámetros y asigna los vectores X,Y con Adaline.fit(X,Y)
#Tome ax[i] e i como la posición del gráfico
ax[0].plot(range(1, len(ada1.cost_)+1), np.log10(ada1.cost_), marker='o') # range(1, len(ada2.cost_) +1) Crea una secuencia desde 1 y se destiene en 11 (este caso).
ax[0].set_xlabel('Iteraciones')
ax[0].set_ylabel('log(SSE)')
ax[0].set_title('Adaline - Tasa de aprendizaje 0.01')

# Segundo gráfico en lienzo
ada2 = Adaline(n_iter=10, eta=0.0001,random_state=1).fit(X, Y)
ax[1].plot(range(1, len(ada2.cost_) +1), ada2.cost_, marker='o') 
ax[1].set_xlabel('Iteraciones')
ax[1].set_ylabel('SSE')
ax[1].set_title('Adaline - Tasa de aprendizaje 0.0001')

plt.show()
```

Se grafica la cantida de iteraciones vs SSE (Error)

<img src="/home/juan-c/.config/Typora/typora-user-images/image-20230107212838812.png" alt="image-20230107212838812" style="zoom: 80%;" />

**Como puede evidenciar, para la tasa de aprendizaje de 0.01 la relación entre la cantidad de iteraciones y el SSE es lineal positiva, entre más iteraciones mayor error (Como son pasos largos requiere menos iteraciones). Por otra parte, para una tasa de aprendizaje de 0.0001 la relación es lineal negativa, es decir, requiere mas  iteraciones para un menor error (como son pasos cortos, requirá más iteraciones).**

Lo dicho anteriormente se simplifica con la siguiente gráfica:

![image-20230107213403245](/home/juan-c/.config/Typora/typora-user-images/image-20230107213403245.png)



Con una tasa de aprendizaje óptima, los pasos se adaptan a la función de costo y es posible aproximarse al mínimo global (izquierda), por el contrario, con una tasa alta, se sobre piensa este.

## La utilidad de normalizar o escalar datos para con el algoritmo del descenso del gradiente.

Como su nombre indica, el algoritmo hace uso del descenso del gradiente, así encuentra cada vez más direciones que decrecerán. Por definición matemática, **el gradiente siempre es perpendicular a su curva (forma un ángulo de 90 grados)**. ¿Y eso qué implica?

Si suponemos un modelo con dos parámetros y la función de costo igual al SSE, nos daremos cuenta que la estructura de esta es elíptica. 

![image-20230109201941803](/home/juan-c/.config/Typora/typora-user-images/image-20230109201941803.png)

Dichas curvas implican que, cuando inicia el descenso del gradiente, siempre descienda de forma perpendicular a cada curva de nivel:

![image-20230109202032988](/home/juan-c/.config/Typora/typora-user-images/image-20230109202032988.png)

Como se puede evidenciar, una elipsis dificulta la optimización del algoritmo, cono sólo da "pasos" en direciones perpendiculares a cada curva, se demorará más en encontrar el mínimo global. Note que, si por el contrario la función es una esfera: 

![image-20230109202213361](/home/juan-c/.config/Typora/typora-user-images/image-20230109202213361.png)

La perpendicularidad intrínseca en el gradiente no es problema, por esto se normalizan los datos cuando se usa un modelo que entrena con el descenso de gradiente, puesto que la normalización arrastra las variables al centro y, deja su variabilidad en la unidad. 



![image-20230109202339306](/home/juan-c/.config/Typora/typora-user-images/image-20230109202339306.png)



## Ejemplo de normalización con python y Adaline

```python
"------------ Función pra graficar regiones de segmentación------------------"

from matplotlib.colors import ListedColormap


def plot_decision_regions(X, y, classifier, resolution=0.02):

    # setup marker generator and color map
    markers = ('s', 'x', 'o', '^', 'v')
    colors = ('red', 'blue', 'lightgreen', 'gray', 'cyan')
    cmap = ListedColormap(colors[:len(np.unique(y))])

    # plot the decision surface
    x1_min, x1_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    x2_min, x2_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx1, xx2 = np.meshgrid(np.arange(x1_min, x1_max, resolution),
                           np.arange(x2_min, x2_max, resolution))
    Z = classifier.predict(np.array([xx1.ravel(), xx2.ravel()]).T)
    Z = Z.reshape(xx1.shape)
    plt.contourf(xx1, xx2, Z, alpha=0.3, cmap=cmap)
    plt.xlim(xx1.min(), xx1.max())
    plt.ylim(xx2.min(), xx2.max())

    # plot class samples
    for idx, cl in enumerate(np.unique(y)):
        plt.scatter(x=X[y == cl, 0], 
                    y=X[y == cl, 1],
                    alpha=0.8, 
                    c=colors[idx],
                    marker=markers[idx], 
                    label=cl, 
                    edgecolor='black')

"------------ Ejemplo de importancia tasa de normalización------------------"

X_std=X #Simplemente nombro otra matriz que sea igual a X, para no confundir.

# Normalizo primera variable
X_std[:,0]=(X_std[:,0]-np.mean(X_std[:,0]))/np.std(X_std[:,0])

# Normalizo segunda variable
X_std[:,1]=(X_std[:,1]-np.mean(X_std[:,1]))/np.std(X_std[:,1])

#---- Nuevo modelo con datos estadarizados (en este caso se usa una tasa de aprendizaje igual a 0.01, note que esta en datos sin estandarizar era un problema)
ada3=Adaline(eta=0.01, n_iter=15, random_state=1).fit(X_std,Y)

#--- Gŕaficas

# Gŕafico SSE vs iteraciones
plt.plot(range(1,len(ada3.cost_)+1),ada3.cost_,marker="o")
plt.title("Iteraciones vs  SSE")
plt.xlabel("Iteracinoes")
plt.ylabel("SSE")

plt.show()

# Gŕafico de segmentación


plot_decision_regions(X_std, Y, classifier=ada3)
plt.title('Adaline - Descenso del gradiente')
plt.xlabel('Longitud del sépalo [estandarizada]')
plt.ylabel('Longitud del pétalo [estandarizada]')
plt.legend(loc='upper left')
plt.tight_layout()

plt.show()
```

![image-20230109210501836](/home/juan-c/.config/Typora/typora-user-images/image-20230109210501836.png)



![image-20230109210521978](/home/juan-c/.config/Typora/typora-user-images/image-20230109210521978.png)



Note que, con las variables estandarizadas, $\eta=0.01$ no representa ya un problema (recuerde que sin estandarizar, a medida que se aumentan las iteraciones mayor era el SSE); es más, ahora por cada iteración más, el SSE disminuye.  **IGNORAR TODOS LOS GRÁFICOS CON ECM (ERROR CUADŔATICO MEDIO), ERROR CONCEPTUAL, ES SSE (SUMA DE CUADRADOs DE LOS ERRORES)**

## Descenso del gradiente estocástico (SGD)

El algoritmo del descenso del gradiente previamente tratado, comúnmente se conoce como descenso del gradiente por lotes. Note que la actualización de los pesos está dada por:
$$
\Delta w_j=-\eta \frac{\partial E}{\partial w_j}=\eta \sum_{i=1}^n(Y_i-\phi(Z_i))x_{ji}
$$
Es decir, cada parámetro o peso se actualizará en función de toda la muestra de la variable $j$ en conjunto (puesto que es una suma).  Ahora extrapole lo anterior a el vector gradiente, pues este será de dimensión $m$ (cantidad de variables).  


$$
\nabla E (W)=\eta\left (\sum_{i=1}^n(Y_i-\phi(Z_i))x_{ji},\sum_{i=1}^n(Y_i-\phi(Z_i))x_{ji}...\right )
$$
O matricialmente
$$
\nabla E (W)=\eta [X^T\ (Y-\hat{Y})]
$$
Es decir, el entrenamiento utiliza todos los datos en conjunto; por ejemplo, el perceptrón no los usaba de manera conjunta, ejecutaba la actualización observación por observación y la actualización final era la estimación. El descenso de gradiente por lotes usa la suma de todos los errores de cada observación y con base en dicha suma estima los parámetros. La dificultad de lo anterior reside en el desgaste que significa esto para el computo si se tienen millones de datos, puesto que debería no sólo multiplicar matrices y vectores de grandes magnitudes sino que, tendría que hacerlo por cada iteración; y rara vez un problema es posible solucionarlo iterando el algoritmo 15 veces. Imagine iterar 10.000 veces una multiplicación de vectores y matrices de tamaño gigante. 

Ante el problema anteriormente nombrado, nace el descenso del gradiente estocástico. Así, la forma de actualizar los pesos será:
$$
w_j= w_j+\Delta w_j
$$
Donde
$$
\Delta w_j=\eta (Y_i-\phi(Z_i))x_{ji}
$$
**La nueva actualización no es exatamente el gradiente (el grediente exacto es la suma), es  una aproximación por punto de este (lo que permite actualizar rápidamente las estimaciones de los parámetros); el problema no es matemático, es algorítmico. En una iteración o época, en realidad se tendrían $n$ actualizaciones, algo mucho más rápido que la suma de milles de errores. ** 

Note que  cada actualización $w_j= w_j+\Delta w_j$ contiene una especie de memoria del error de la observación anterior (análogo a la ley de Hebb). El nombre "estocástico" viene debido a la necesidad que tiene este de presentar en orden aleatorio los datos de entrenamiento (como se ejecuta por cada observación, no queremos que un orden específico pueda sesgar el aprendizaje); además, es pertinente mezclar los conjuntos de entrenamiento en cada iteración con el fin de evitar ciclos. 

A menudo en las implementación del presente algoritmo el hiperparámetro $\eta$ es remplazado por un rango de aprendizaje adaptativo:
$$
\eta_0 = \frac{c_1}{\text{Número de iteraciones}+c_2}
$$
Donde $c_1$ y $c_2$ son constantes e hiperparámetros. Note que aumentan el número de hiperparámetro en este caso. **La incorporación del nuevo $\eta_0$ es debido a que, al aproximarse cada vez a una región mínima, es pertinente que el algoritmo requiera pasos cada vez más cortos** (note que $\eta_0$ es cada vez menor); de esta forma, cada vez que se acerca al mínimo es poco probable que este de un paso grande y se pierda en la función error. 



**Consideraciones**

- El descenso del gradiente estocástico sólo debe utilizarse si el tiempo de computo es limitado y/o se quiere procesar datos online (a tiempo real). Lo anterior debido a que, como no aprende con los datos en conjunto, los caminos que recorre el algoritmo son menos exactos (sin embargo logra aproximarse a un mínimo global).
- Existe un equilibrio entre ambos métodos llamado el descenso del gradiente por minilotes; este no ejecuta el aprendizaje con la matriz completa de datos o con una sola observación, por el contrario, selecciona un subconjunto de los datos (lotes, por ejemplo de tamaño 50) y va ejecutando el aprendizaje por cada lote (el aprendizaje recorre todos los datos pero separados por subconjuntos). 
- Otra ventaja resulta de la capacidad de descartar el dato una vez se ha entrenado con este; dado que la $w_j$ se estima sumando el aprendizaje en cada observación, una vez ha aprendido de esta, se adapta inmediatamente a los cambios, por lo cual es posible eliminarla (muy útil con aplicación de modelos online).
- Una desventaja es la cantidad de hiperparámetros a ajustar.

### Descenso del gradiente estocástico en python























