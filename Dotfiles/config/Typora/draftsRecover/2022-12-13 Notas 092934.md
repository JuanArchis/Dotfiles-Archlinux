# Notas varias

### Proposito

Respecto de los problemas por los supuestos sobre las perturbaciones y especificaciones del modelo, surgen tres grandes interrogantes: 1) ¿Qué gravedad reviste alejarse de un supuesto particular para que de verdad importe? Por ejemplo, si las ui no siguen una distribución exactamente normal, ¿qué nivel de alejamiento de este supuesto puede aceptarse sin que se destruya la propiedad MELI de los estimadores de MCO? 2) ¿Cómo averiguar si en verdad se violó un supuesto particular en un caso concreto? Por consiguiente, ¿cómo verificamos que las perturbaciones estén normalmente distribuidas en una aplicación dada? Ya estudiamos las pruebas de normalidad del  estadístico A2 de Anderson-Darling y de Jarque-Bera. 3) ¿Qué medidas correctivas podemos emprender si uno o más supuestos son falsos? Por ejemplo, si encontramos que el supuesto de homoscedasticidad en una aplicación es falso, ¿qué hacer?

Respecto de los problemas atribuibles a supuestos sobre los datos, también se presentan interrogantes similares. 1) ¿Qué tan grave es un problema particular? Por ejemplo, ¿es la multicolinealidad tan severa que dificulta mucho la estimación y la inferencia? 2) ¿Cómo se mide la severidad del problema de datos? Por ejemplo, ¿cómo decidimos si la inclusión o la exclusión de una observación u observaciones que pueden representar observaciones atípicas constituirán una diferencia sustancial en el análisis? 3) ¿Es posible remediar con facilidad algunos problemas de información? Por ejemplo, ¿se puede acceder a los datos originales para encontrar las fuentes de los errores de medición en los datos?

### ¿Por qué $E[\epsilon]=0$

Si se suṕone que la anterior esperanza es igual a una constante, sea $w$, note que:

$E(Y_i|X_1,X_2...X_i)=\beta_0+\beta_1X_1+...+\beta_nX_n+w$

Note que $\beta_0$ y $w$ son constantes, por lo cual se agrupan. $\alpha=(\beta_0+w)$.  La estimación del interpceto es sesgada (aunque en diversos casos la estimación del intercepto es irrelevante).

### Normalidad en conextos económicos

En economía, pocas veces se tienen muestras grandes, por lo cual, el TCL no es pertinente en el contexto (es necesario el supuesto de normalidad).

### Intento de crear una prueba con el proposito de solucionar normalidad, homocedasticidad e independencia serial.

A.K. Bera y C.M. Jarque, “Effi cient Tests for Normality, Homosce-dasticity and Serial Independence of Regression Residuals: Monte Carlo Evidence”

# Multicolinealidad

### Naturaleza

Recuerde que la colinealidad algebráica establece que, si, $n$ varias se puede expresar como una combinación lineal y la suma de esta es cero, las variables presentan colinealidad exacta.

                         $\sum_{i=0}^n \lambda_iX_i=0$ ; Donde al menos dos $\lambda$ debe ser diferente de cero.

La multicolinealdiad imperfecta dicta que:

                                                 $\sum_{i=0}^n \lambda_iX_i+v_j=0$

La correlación está moldeada por el término estocástico $v$

**Recuerde que la colinealidad sólo mide el grado de relación LINEAL entre las covariables**

### Estimación en presencia de multicolinealdiad perfecta

Para el caso de multicolinealidad perfecta, observe que, si se escribe un modelo de dos variables, se tiene:

                                                          $y_i=\hat{\beta_2}x_2+\hat{\beta_3}x_3$

Donde:

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-41-14-image.png)

Y como se evidencia, el estimador por MCO para $\beta_2$ depende de las variables $x_2$ y $x_3$ De lo anterior se deduce evidentemente que, si $X_{3i}=\lambda X_{2i}$ (con colineales), el estimador se indetermina ($\frac{0}{0}$).

**Además, recuerde que la interpretación de un coeficiente ($\hat{\beta_2}$) se establece como un cambio unitario  cuando las demás covariables  son constantes; pero si  $X_2$ y $X_3$ son cominaciones lineales, $X_3$ no puede permanecer constante ya que este varía a factor de $\lambda$**

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-42-10-image.png)

En la econometría aplicada, este problema ocasiona  mucho daño, pues la idea consiste en separar los efectos parciales de cada X sobre la variable dependiente.

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-42-36-image.png)

### Estimación en presencia de multicolinealidad imperfecta

El caso de colinealidad perfecta es atípico. Los casos más comunes son los de colinealiad imperfecta. En este se tiene que:

                                                                $x_3=\lambda x_2+v_i$

Empero, para este caso es posible la estimación de los coeficientes. Siguiengo la metodología anterior:

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-42-58-image.png)

### Consecuencias de multicolinealidad

Es menester tener en cuenta que la multicolinealidad no es un gran problema per se, pues las propiedades de los estimadores por MCO se siguen cumpliendo (Sigue siendo de mínima varianza, pero no necesariamente la varianza del estimador es menor que este). **La multicolinealidad infla las varianzas**

**Problema similar se obtiene cuando no se tienen suficientes observaciones o, la variabilidad en cada una de ellas es pequeña (Apenas es mayor que el número de parámetros a estimar).**

- Para tener en cuenta, en presencia de multicolinealidad:
  
  - Por más que las propiedades de los estimadores por MCO se mantengan (*UMVUE*), dichas propiedades son de caracter multimuestral (muestreo repetido). Poco dicen estas sobre las propiedades de una muestra observada.
  
  - Los estimadores siguen siendo de mínima varianza, empero, lo anterior no indica que la varianza del estimador sea necesariamente menor que la estimación misma.
  
  - La multicolinealidad es un fenómeno muestral. Las variables poblacionales pueden no tener relación lineal alguna pero en la miestra sí pueden presentar colinealidad (eso puede deberse a pocos datos o al proceso de recolección de la información).

**Por todas estas razones, el hecho de que los estimadores de MCO sean MELI a pesar de la presencia de multicolinealidad es poco consuelo en la práctica. Se debe ver lo que sucede o puede suceder en una muestra dada.**

### Consecuencias de la multicolinealidad

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-43-37-image.png)

### Infla las varianzas

Observe que, la varianza de los estimadores del modelo de dos variables anterior, sigue las  ecuaciones:

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-43-55-image.png)

Note que, a medida que la correlación tiende a 1, la varianza aumenta ($\frac{Número}{Número-muy-pequeño}$). El límite cuando la correlación tiende a 1 es infinito.     

Note que la varianza del estimador de los coeficeitnes puede verse como: 

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-44-18-image.png)

**Ahora, ¿recuerda cuando se habló acerca del efecto similar a la multoclinalidad si la varianza de las variables es muy pequeña? Observe que si la variabilidad de $x_j$ es alta, la suma de esta al cuadrado será mayor que si la variabilidad de esta es menor. Si la variabilidad de una variable es alta, la varianza del estimador será menor. <mark>(IMPORTANTE INCLUIR INVESTIGACIÓN EN EL TBG)</mark>**

### Bondad de ajuste alto pero t NO significativas

Recuerde que los valores t individuales están basados  en el cociente $\frac{\hat{\beta_j}}{ee(\hat{\beta_j})}$ ; Si hay multicolinealidad, el error estandar será mayor respecto a la estimación y, el cociente será cada vez menor.  Lo que hace muy probable no rechazar la prueba t dado el bajo valor.

### Micronumericidad

Goldberger cita consecuencias exactamente iguales del análisis basado en muestras pequeñas, es decir, de la micronumerosidad.15 Se aconseja al lector consultar el análisis de Goldberger para ver la razón por  la cual da la misma importancia a la micronumerosidad que a la multicolinealidad. **Goldberger, Arthur S***<mark>(IMPORTANTE INCLUIR INVESTIGACIÓN EN EL TBG)</mark>

### Detección de multicolinealidad

Es menester remarcar que la multicolinealidad es un problema muestral (Sólo de las observaciones) y no poblacional, esto dado que se suponen las observaciones no son estocásticas. Con base en lo anterior, no tiene sentido realizar pruebas sobre multicolinealidad. Debe medirse descriptivamente.

1. **$R^2$ alto y valores t no significativos:** Como se vio anteriormente, un criterío razonable es ver si tal contradicción se cumple (dado que la inflar la varianza, el cociente de los valroes t tenderá a ser muy bajo). El problema con el presente criterio es que no lo considera gradualmente. Sólo considera el problema de multicolinealidad cuando no se puede separar  la totalidad de las influencias de las variables explicativas sobre $Y$ (Lo cual implica una multicolinealdiad muy fuerte). **Jan Kmenta, Elements of Econometrics, 2a. ed., Macmillan, Nueva York, 1986, p. 439**

2. **Correlaciones altas entre parejas de variables**: El problema de utilizar las correlación como método de detección de multicolinealidad es que este no es criterio de ncesariedad. Una correlación alta (mayor a 0.8) indicará problemas de multicolinealidad, más sin embargo, una correlación de 0.5 (o inferiores) entre dos variables de un modelo con más de dos variables no imposibilida la colinealdiad alta entre estas (Pues ignora la influencia lineal de las demás variables).  Observe: 

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-45-53-image.png)

3. **Correlaciones parciales:** Como método alternativo a la correlación de orden 0, se pueden pensar en usar la correlación parcial. Esta, de forma más general, indica la correlación ($\rho_{AB.C}$) entre A y B tomando C como constante; esto es, una vez, la correlación entre A y B cuando a estas ya se les retiró su mejor explicación lineal en función de  C. 

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-46-11-image.png)

4. **Indice de condición:** Investigar: Regression Diagnostics: Identifying Influential Data and  Sources of Collinearity, John Wiley & Sons, Nueva York

5. **Indice de inflación de varianza:** El VIF parece ser un buen indicardor, sin embargo, como se vió en la fórmula de la varianza del estimador, la inflación de la varianza no es algo único de la colinalidad. Un VIF alto puede contrarestarse con una variabildad de la variable alta.
   
   ![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-46-53-image.png)
   
   6. **Método gráfico:** Si se quiere estudiar la multicolinealidad por método gráfico, lo usual sería urilizar diagramas de dispersión, pero como se trato en el análisis del coeficiente de correlación, la gráfica sólo midel la correlación de grado 0 entre las variables. 
      
      ![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-47-18-image.png)

Para tomar en consideración:

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-12-47-45-image.png)

****Investigar: O.J. Blanchard, “Comment”, Journal of Business and Economic Statistics, vol. 5, 1967, pp. 449-451***



### Métodos de correción de multicolinealidad

#### Visión pesimista: No hacer nada.

Como se vio anteriormente, el problema de inflación de la varianza no es exclusivo a la colinealidad de los datos, puede deberse a la poca cantidad de estos. En ese caso, la posibilidad incrementar el tamaño muestral es poca o nula. O.J. Blanchard, “Comment”, Journal of Business and Economic Statistics, vol. 5, 1967, pp. 449-451. Peter Kennedy, A Guide to Econometrics, 4a. ed., MIT Press, Cambridge Massachusetts, 1998,  p. 190.

#### Otros métodos

**Información a priori**: Este busca hacer uso de la información histórica acerca el coeficientes de inteŕes (en este caso se supone se sabe la relación matemática de la dependencia entre las variables).

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-14-02-44-image.png)

**Eliminar una variable**: Suponiendo que la colinealidad genera inflación de varianza, un procedimiento intuitivo parece ser eliminar la variable que genera dicha dependencia. El problema es esto conlleva es el sesgo de especificación; si la variable eliminada es necesaria para la correcta modelación del fenómeno, la estimación de los coeficientes estará influenciada el coeficiente de la variable omitida (de alta relevancia teórica).

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-14-09-31-image.png)

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-14-12-03-image.png)

**Transformaciones**: Ya sea ver el modelo como resta de sus valores futuros o verl el modelo como un cociente percapita, el remedio tiende a ser peor. 

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-14-17-20-image.png)

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-14-18-14-image.png)

**Obtener datos adicionales**: Recuerde que la colinealidad puede ser contrarestada por un tamaño de muestra y varianza de la v.a grande. Empero:

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-14-21-08-image.png)

**Rregresiones de componentes Principales y Ridge**

### ¿Por qué la multicolinealidad no afecta las predicciones?

Consulte la lógica del libro para después: **La multicolinealidad no es un problema para la predicción dado que, si la dependencia se mantiene en los datos de validación, la predicción será correcta. Suponga que obtiene un modelo con dos covariables y una correlación perfecta. Si ajusta dos modelos con las covariables de manera individual, la estimación del coeficiente será similar en ambos modelos (por ejemplo, 3). Si ajusta el modelo en conjunto, al quedar la estimación como una función parametral $X_1(b_1+b_2\lambda) $, la estimación se engarcargaŕa de encontrar tal combinación que resulte igual a 3, por esto la predicción no se ve afectada SÍ EL CONJUNTO DE VALIDACIÓN PRESENTA LA MISMA COVARIANZA**

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-15-14-31-image.png)

![](/home/juan-c/snap/marktext/9/.config/marktext/images/2022-12-08-15-14-52-image.png)
