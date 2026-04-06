Análisis financiero de Adobe: ingresos, rentabilidad, inversión y endeudamiento (2019-2025).

1. Contexto

La empresa Adobe es una multinacional con presencia en todo el mundo, dentro de los mercados bursátiles representa una de las compañías más redituables en la actualidad, mantiene una posición consolidada en el mercado del software, aunque su capitalización bursátil ha mostrado variaciones significativas en el periodo analizado.

El objetivo de este análisis es investigar los datos públicos de esta empresa para conocer su estado financiero general y saber en qué invierte los elevados niveles de rentabilidad que presenta.

Para este estudio se analizarán los ingresos y el uso que la empresa hace de ellos, con el fin de evaluar si la empresa está comprometida con su desarrollo futuro.

2. Objetivo del proyecto

El objetivo principal de este proyecto es analizar la evolución en los ingresos de la empresa Adobe en el periodo de estudio (2019-2025) y responder a las siguientes preguntas:

•	¿Cómo evolucionaron los ingresos en el tiempo?

•	¿Cómo evolucionaron los distintos márgenes de rentabilidad de la empresa?

•	¿Cuánto dinero destina Adobe para recomprar sus propias acciones?

•	¿Cuánto porcentaje de los ingresos esta empresa invierte en tecnología y desarrollo?

•	¿Qué tan endeudada está la empresa?


El foco de la investigación es analizar la operativa financiera de la empresa y entender cómo se distribuyen estos altos márgenes de rentabilidad.

3. Fuentes de datos.

Los datos públicos oficiales utilizados en este proyecto provienen de SimFin que a su vez extrae los datos de la U.S. Securities and Exchange Commission (SEC) con un historial desde 2019 a 2025, para fines de esta investigación nos basamos en:

•	Balance general.

•	Flujo de efectivo.

•	Estado de resultados.

Nota: Los datos están representados en miles de millones de USD.

Todos los datasets descargados fueron previamente limpiados por medio de Power Query y estandarizados para su posterior análisis, no se alteró ni se agregó dato alguno.

4. Metodología
   
4.1.	Limpieza de datos

-	Se eliminaron filas descriptivas y encabezados no estructurados para el análisis en Excel.
-	Se eliminaron las filas de variables que no tenían ningún dato registrado.
-	Cambio de orientación, de filas a columnas. El dataset original tiene los datos para mostrarlo en un formato estadístico, pero poco práctico para la limpieza y posterior análisis, por lo que se procedió en Power Query a cambiar la ubicación de los datos sin alterar su contenido por medio de un Unpivot.
-	Se agregaron ‘compañía, tipo de estado o variable, métrica y año’ como columnas para una mejor comprensión en el análisis.
-	No se encontraron datos duplicados, pero se sustituyeron los datos faltantes ‘///’ por un ‘NULL’ para su correcta interpretación en SQL y Power BI.

4.2.	Modelado de datos.

Los datos fueron modelados en una estructura tabular normalizada por medio de Power Query, para que cada fila representara una observación única.

Las bases de datos correspondientes a ‘Balance general, flujo de efectivo, estado de resultados’ fueron unificadas en una sola tabla (adobe_financial) por medio de la variable o columna “Statement” en Power Query para facilitar el análisis comparativo entre estados financieros.

Esta decisión se hizo para facilitar las consultas en SQL y su posterior visualización en Power BI.

4.3.	Análisis exploratorio.

En esta etapa se realizó un análisis exploratorio de los datos (EDA) con el objetivo de identificar patrones, tendencias y relaciones relevantes entre las variables financieras. Se analizaron:

•	Tendencias temporales (crecimiento de ingresos y métricas clave año a año).

•	Variaciones porcentuales interanuales.

•	Relación entre variables (ej. ingresos vs rentabilidad, flujo de caja vs recompras).

•	Comportamientos atípicos o cambios estructurales en la serie.

Este análisis permitió formular hipótesis iniciales y orientar las consultas SQL hacia preguntas de negocio más específicas.

4.4.	Visualización.

-	Dashboard interactivo desarrollado en Power BI facilitando la interpretación de la información financiera, se busca conocer la salud financiera de Adobe.
-	Enfoque narrativo orientado a la toma de decisiones personales y comparativas de mercado para tomar decisiones basadas en el análisis.

5. Resultados

5.1. ¿Cómo evolucionaron los ingresos de Adobe en el tiempo?

Para poder entender la evolución de los ingresos de esta empresa, debemos saber los valores de los ingresos por año, desde el inicio del periodo hasta el último, con estos datos podemos saber el histórico de ingresos en miles de millones en USD y con esos datos podemos obtener el porcentaje de crecimiento nominal, consultamos la base de datos y los hallazgos principales fueron:

| año | ingresos | ingresos_anterior | crecimiento_interanual_pct |
|:---:|---:|---:|---:|
| 2019 | 11171 | - | - |
| 2020 | 12868 | 11171 | 15.19 |
| 2021 | 15785 | 12868 | 22.67 |
| 2022 | 17606 | 15785 | 11.54 |
| 2023 | 19409 | 17606 | 10.24 |
| 2024 | 21505 | 19409 | 10.80 |
| 2025 | 23769 | 21505 | 10.53 |

Tras estos resultados nos encontramos con las siguientes conclusiones:

•	El crecimiento promedio anual desde el inicio de periodo de estudio hasta el último fue de 13.40% marcando un constante crecimiento. 

•	El año con mayor crecimiento fue en el 2021, posiblemente impulsado por factores externos como la aceleración de la digitalización post-pandemia.

•	En el año 2019 fue de $11171.00 y para el 2025 fue de $23769.00, es decir, los ingresos se duplicaron en el período analizado.

Esto evidencia un crecimiento sostenido y consistente en los ingresos a lo largo del período.

Nota: En esta variable de Ingresos por año, solamente encontramos el total de dinero que Adobe recibió de sus clientes por vender sus servicios, es la cifra bruta antes de pagar cualquier costo.

5.2. ¿Cómo evolucionaron los distintos márgenes de rentabilidad de la empresa?

Para entender la rentabilidad de los ingresos de la empresa debemos saber los datos de las siguientes variables: ingresos, beneficio bruto, ingresos operativos y beneficio neto. Al tener estos datos podemos incluir en la consulta un porcentaje de lo que representa cada margen luego de pagar sus obligaciones, de esta manera podemos saber cuánto dinero le queda a la empresa luego de pagar todo. Al consultar estos datos nos encontramos con:

Nota: El beneficio bruto, ingresos operativos y beneficio neto ya estaba en el dataset y en esa variable se descuentan los costos directos de la empresa de los ingresos.


| año | ingresos | beneficio_bruto | ingresos_operativos | beneficio_neto | margen_bruto_pct | margen_operativo_pct | margen_neto_pct |
|:---:|---:|---:|---:|---:|---:|---:|---:|
| 2019 | 11171 | 9498 | 3268 | 2951 | 85.02 | 29.25 | 26.42 |
| 2020 | 12868 | 11146 | 4237 | 5260 | 86.62 | 32.93 | 40.88 |
| 2021 | 15785 | 13920 | 5802 | 4822 | 88.18 | 36.76 | 30.55 |
| 2022 | 17606 | 15441 | 6098 | 4756 | 87.70 | 34.64 | 27.01 |
| 2023 | 19409 | 17055 | 6650 | 5428 | 87.87 | 34.26 | 27.97 |
| 2024 | 21505 | 19147 | 7741 | 5560 | 89.04 | 36.00 | 25.85 |
| 2025 | 23769 | 21218 | 8706 | 7130 | 89.27 | 36.63 | 30.00 |

Tras estos resultados podemos deducir estos hallazgos:

•	Adobe tiene porcentaje promedio anual de margen bruto del 87.67%, este margen es tan alto ya que el costo de producción del servicio que ofrecen una vez desarrollado, distribuirlo a más clientes tiene un costo marginal casi nulo, lo que refleja una estructura de costos eficiente con bajos costos directos en relación con los ingresos, típico de empresas de software.

•	El margen operativo promedio anual es de 34.35%, lo que indica que, tras los gastos de servicio y sumándole los gastos de marketing, investigación, desarrollo y salarios a la empresa le sigue quedando un margen alto de beneficio.

•	El margen neto promedio en todo el periodo es de 29.81%, lo que indica que después de pagar todos los gastos arriba mencionados y sumándole los impuestos, intereses de deudas, etc… a la empresa le sigue quedando un buen margen de ganancia, un porcentaje alto que evidencia la buena rentabilidad del producto.

Se puede concluir que Adobe muestra una alta capacidad de generación de ingresos y rentabilidad sostenida, presentando un perfil financiero sólido, que se ve reflejado en la tendencia alcista año tras año. Todo esto se explica por su crecimiento sostenido, alta rentabilidad y generación consistente de flujo de caja.

La combinación de los altos márgenes y el crecimiento sostenido sugiere un modelo de negocio altamente escalable, típico de empresas de Software.

5.3. ¿Cuánto dinero destina Adobe para recomprar sus propias acciones?

Para calcular cuánto dinero destina la empresa para recomprar sus propias acciones debemos ver el efectivo que queda en el flujo operativo y ver qué cantidad se destina para la recompra, luego podemos obtener un porcentaje se usó para esto, este es un indicador relevante, ya que una empresa que recompra sus propias acciones suele reflejar confianza al inversor de que obtiene sus ganancias y sus intereses a cabalidad.

Al hacer la consulta nos encontramos con:


| año | flujo_operativo | recompra_acciones | pocentaje_recompra |
|:---:|---:|---:|---:|
| 2019 | 4422 | 2517 | 56.92 |
| 2020 | 5727 | 2780 | 48.54 |
| 2021 | 7230 | 3659 | 50.61 |
| 2022 | 7838 | 6272 | 80.02 |
| 2023 | 7302 | 4086 | 55.96 |
| 2024 | 8056 | 9139 | 113.44 |
| 2025 | 10031 | 10933 | 108.99 |

Desde 2019 a 2025 la empresa ha comprado un total de 39386 millones de dólares de sus propias acciones, es decir un 73.50% del flujo operativo. Esto refuerza la política de retorno al accionista que se evidencia por los montos tan altos de recompra, el año 2024 fue el más alto ya que compraron un 113.44% del flujo operativo, es decir, las recompras superan el flujo operativo, lo que sugiere que la empresa podría estar financiándolas mediante efectivo acumulado o deuda, esto introduce un riesgo que merece seguimiento.

A pesar de que cumple sus obligaciones, está usando un mayor porcentaje del flujo operativo. Por otro lado, puede ser interpretado como que la empresa confía tanto en si misma que prefiere comprar sus propias acciones en lugar de invertir en otra cosa.

Para explicar porque esto sería un riesgo debemos saber que cuando las recompras de acciones superan el flujo de caja operativo, implica que la empresa no está financiando estas recompras únicamente con el dinero generado por su actividad principal. Ese dato puede implicar:

•	Uso de efectivo acumulado (reduciendo liquidez).

•	Incremento del endeudamiento.

Los posibles riesgos asociados incluyen:

•	Menor flexibilidad financiera ante crisis o caídas en ingresos.

•	Mayor exposición a deuda si esta estrategia se mantiene en el tiempo.

•	Posible priorización del retorno al accionista sobre la reinversión en el negocio.

Si bien en el corto plazo puede interpretarse como una señal de confianza, en el largo plazo requiere seguimiento para evaluar su sostenibilidad.

5.4. ¿Cuánto porcentaje de los ingresos esta empresa invierte en tecnología y desarrollo?

Es importante saber qué porcentaje de los ingresos la empresa invierte en tecnología y desarrollo (siempre y cuando los datos lo permitan) ya que es un indicador muy saludable que demuestra el compromiso de la empresa que tiene con su expansión y crecimiento, además la confianza que tiene la empresa en seguir desarrollando su propio producto. Para saber esto analizamos los ingresos y la cantidad que se destina a inversión y su respectivo porcentaje, tras la consulta nos encontramos:


| año | ingresos | inversion_id | porcentaje_id |
|:---:|---:|---:|---:|
| 2019 | 11171 | 1930 | 17.28 |
| 2020 | 12868 | 2188 | 17.00 |
| 2021 | 15785 | 2540 | 16.09 |
| 2022 | 17606 | 2987 | 16.97 |
| 2023 | 19409 | 3473 | 17.89 |
| 2024 | 21505 | 3944 | 18.34 |
| 2025 | 23769 | 4294 | 18.07 |

Estos resultados nos demuestran que Adobe invierte un aproximado del 17% de sus ingresos en investigación y desarrollo, lo que puede interpretarse como una señal positiva para los inversores, esto indica que la empresa está comprometida cada año en expandirse e invertir en mejorar la tecnología.

5.5. ¿Qué tan endeudada esta la empresa?

Para saber que tan endeuda esta la empresa debemos saber los datos sobre el patrimonio neto por año y compararla con la deuda a largo plazo, esto es clave ya que nos va a decir el porcentaje de endeudamiento real que tiene sobre todo el patrimonio de la empresa y poder saber la tendencia que viene teniendo año tras año. Al consultar nos encontramos:


| año | deuda_largo_plazo | patrimonio_total | pct_deuda_patrimonio | acciones_tesoro |
|:---:|---:|---:|---:|---:|
| 2019 | 989 | 10530 | 9.39 | -10615 |
| 2020 | 4117 | 13264 | 31.04 | -13546 |
| 2021 | 4123 | 14797 | 27.86 | -17399 |
| 2022 | 4129 | 14051 | 29.39 | -23843 |
| 2023 | 3634 | 16518 | 22.00 | -28129 |
| 2024 | 5628 | 14105 | 39.90 | -37583 |
| 2025 | 6210 | 11623 | 53.43 | -48843 |

Tras estos resultados encontramos que la empresa está aumentando el porcentaje de deuda desde el 2024, un dato que puede explicar por qué la recompra de acciones ha aumentado por encima del flujo operativo.

El patrimonio neto cayó desde su nivel más alto en 2021 con $14797 MM hasta los $11623 MM en 2025, esto podría interpretarse como un factor de riesgo, sin embargo, aunque ha aumentado, se mantiene en niveles manejables en comparación con estándares del sector.

Otro factor adicional que explica la caída del patrimonio es el efecto acumulado de las recompras de acciones sobre las acciones del tesoro o Treasury Stocks. En este apartado se registra el valor de las acciones propias recompradas, que pasó de -10.615 MM USD en 2019 a -48.847 MM USD en 2025.

En contabilidad, las acciones del tesoro se restan directamente del patrimonio, por lo que su crecimiento en valor absoluto explica la caída del patrimonio total, incluso cuando los beneficios netos siguen aumentando.

En conjunto, podemos concluir que Adobe presenta un modelo de negocio sólido y con características de escalabilidad, justificado por el crecimiento sostenido, alta rentabilidad y una estrategia clara de retorno al accionista. No obstante, el incremento en recompras financiadas potencialmente con deuda introduce un factor de riesgo que debe ser monitoreado en el tiempo.

6. Insights

Los hallazgos más relevantes son:

•	Los ingresos de la empresa crecen interanualmente en promedio un 13.4% lo que lo convierte en una empresa muy rentable, cada año ingresa cada vez más dinero.

•	Adobe presenta un modelo de negocio altamente rentable con márgenes consistentemente elevados.

•	La empresa deja una buena suma de dinero después de pagar todas sus obligaciones, esto indica una alta eficiencia operativa, parte de esta rentabilidad se explica por el producto que ofrece ya que, al ofrecer un software, los márgenes de beneficio resultan ser altos.

•	El crecimiento sostenido junto con altos márgenes sugiere una fuerte escalabilidad del negocio.

•	En el periodo de estudio la empresa ha comprado un total de 39386 MM de dólares de sus propias acciones, es decir un 73.50% del flujo operativo.

•	El año 2024 fue cuando la empresa hizo más recompra de sus propias acciones con un 113.44% sobre el flujo operativo, es decir compraron acciones por encima de lo que ingresaron.

•	El aumento en recompras junto con mayor endeudamiento indica un cambio en la estrategia de asignación de capital.

•	La empresa invierte un aproximado de un 17% de lo que ingresa en investigación y desarrollo, este dato demuestra que la empresa está comprometida cada año en expandirse e invertir en mejorar la tecnología, esto refuerza la sostenibilidad a largo plazo.

•	Adobe maneja un 30.43% aproximado de endeudamiento frente al patrimonio total de la empresa en todo el periodo de estudio.

•	Desde el inicio del periodo con un 9.39% al último con un 53.43% la empresa ha aumentado su endeudamiento, desde el 2024 los niveles aumentaron cada vez más.

•	Las acciones del tesoro acumuladas pasaron de -10.615 MM USD en 2019 a un total de -48.847 MM USD en 2025, erosionando el patrimonio contable a pesar del crecimiento sostenido en beneficios netos.

7. Limitaciones
   
•	El análisis se basa únicamente en datos históricos.

•	No se consideran factores macroeconómicos.

•	No se comparó con competidores.

•	No incluye análisis de valoración.

8. Próximos pasos
   
•	Incorporar datos del primer trimestre del año cuando sea publicado.

•	Realizar comparaciones con competidores del sector.

•	Analizar el impacto de cambios en leyes, demandas, factores regulatorios, inflación.

•	Seguir los indicadores de riesgo de deuda.

9. Herramientas
   
•	Excel y Power Query (Limpieza).

•	SQL (consultas análiticas y transformación de datos).

•	Power BI (dashboard y visualización).

•	GitHub (documentación y versionado).

11. Nota final.

Este proyecto fue desarrollado con fines educativos y de portfolio, aplicando criterios de análisis de datos orientados a negocio y toma de decisiones. Este trabajo evidencia el uso de herramientas como Power Query para transformar los datos, MySQL para consultas analíticas y responder preguntas y Power BI para visualización orientada a la toma de decisiones.
