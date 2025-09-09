<p align="center">
   <img src="./assets/logos/lunch_stem_light_logo_with_name.png" alt="Logo de lunchSTEM" width="300"/>
</p>

<h1 align="center">Democratizando el conocimiento <i>STEM</i> de manera organizada</h1><br>

<p align="center">
   <strong>🌟 Proyecto sin fines de lucro y de código abierto 🌟</strong>
</p>

<p align="center">
   <em>Piensa en una mejor Wikipedia para <i>STEM</i>.<br>
   Es como FreeCodeCamp, pero para documentos (y no solo para Ingeniería de Software).</em>
</p>

<p align="center">
   <a href="https://discord.gg/W6wmJbZx">
      <img src="https://img.shields.io/badge/Discord-Únete%20a%20Nuestra%20Comunidad-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord">
   </a>
</p>

<p align="center">
   <a href="README.md">
      <img src="https://img.shields.io/badge/English-README-blue?style=for-the-badge" alt="English">
   </a>
   <a href="README.es.md">
      <img src="https://img.shields.io/badge/Español-README-red?style=for-the-badge" alt="Español">
   </a>
   <a href="README.zh.md">
      <img src="https://img.shields.io/badge/中文-README-yellow?style=for-the-badge" alt="中文">
   </a>
   <a href="README.pt.md">
      <img src="https://img.shields.io/badge/Português-README-green?style=for-the-badge" alt="Português">
   </a>
   <a href="README.fr.md">
      <img src="https://img.shields.io/badge/Français-README-purple?style=for-the-badge" alt="Français">
   </a>
   <a href="README.de.md">
      <img src="https://img.shields.io/badge/Deutsch-README-orange?style=for-the-badge" alt="Deutsch">
   </a>
</p>

---

> [!WARNING]
> **⚠️ Importante**
> 
> Los documentos en *lunchSTEM* son creados por autores externos, no por nosotros. No apoyamos la inclusión de documentos no distribuibles sin el permiso del autor (para documentos no distribuibles: consulta `author_permissions.jsonl`).
> 
> Cada documento acredita a su(s) autor(es) en un archivo correspondiente `<nombre_archivo>.<extensión_archivo>.source.json`.
> 
> Los autores pueden solicitar la eliminación de contenido en cualquier momento. Después de seguir nuestro protocolo simplificado para *Solicitudes de Eliminación de Contenido*, eliminamos el contenido dentro de 24 horas. Esta opción es más rápida y amigable que una notificación de la *Ley de Derechos de Autor del Milenio Digital (DMCA)* (que puede cerrar el proyecto).

> [!NOTE]
> **🟩 Próximamente**
> 
> • **Sitio web** con páginas de autores, búsqueda por palabras clave/semántica, foros de discusión sobre documentos, vistas previas de contenido, visualizaciones interactivas de contenido, marcado/etiquetado/favoritos de contenido, toma de notas sobre documentos, documentos populares/tendencia, estadísticas para documentos y autores, y más.
> 
> • **Servidor MCP:** útil para Agentes de IA que realizan trabajo de ingeniería complejo o investigación científica.
> 
> • **CLI adecuado** donde los usuarios pueden hacer búsquedas por palabras clave y semánticas.

## Descripción General

Esta es una base de conocimiento *STEM* (Ciencia, Tecnología, Ingeniería y Matemáticas) en evolución, destinada a ser revisada y mejorada con el esfuerzo de la comunidad. Puede ser utilizada y mejorada por humanos y agentes de IA.

Su caso de uso ideal es **profundizar en un tema *STEM* (y temas relacionados) después de tener una comprensión inicial del mismo** (que puedes obtener fácilmente a través de Google Search o Asistentes de IA).

Debería ser más organizada y de mayor calidad (relación señal-ruido) que la búsqueda predeterminada de Google/investigación profunda de IA para este caso de uso.

El objetivo es, más adelante, permitir que los agentes de IA la utilicen fácilmente como herramienta creando un *Servidor MCP de lunchSTEM*.

## Solicitudes de Eliminación de Contenido y Atribución de Créditos

Se hizo un gran esfuerzo para detectar y eliminar contenido con derechos de autor (no distribuible), y para reconocer a los autores/editores/universidades de los materiales restantes. No se pudo hacer una revisión manual de cada archivo debido a la gran cantidad de archivos (pero damos la bienvenida a la comunidad para que nos ayude con esto abriendo issues y PRs).
1. Ejecutamos scripts para eliminar cualquier archivo que contenga cualquier otra extensión fuera de: `.pdf`, `.txt`, `.md`, `.ipynb`, `.json`
2. Ejecutamos scripts para la detección automatizada de palabras clave relacionadas con derechos de autor en documentos y eliminación de dichos documentos
3. Ejecutamos scripts para la eliminación automatizada de artículos académicos.
4. Reemplazamos manualmente cada pdf de libro por un enlace al mismo.
5. Ejecutamos scripts para la creación automatizada de un archivo de atribución de créditos (`.source.json`) para cada pdf restante, con información como: autores, enlace a la fuente, modificado o no, etc. El valor predeterminado de los campos es `null`, con la excepción del valor predeterminado del campo `changes_were_made` que es `False`. Los valores predeterminados se usan cuando la información no se puede encontrar en el propio pdf.

Sin embargo, no podemos garantizar la perfección en este proceso, por lo tanto, si encuentras cualquier contenido con derechos de autor o contenido sin datos de atribución de créditos adecuados, por favor abre un issue y/o haz un PR y/o envía un correo electrónico a bruno.c.scaglione@gmail.com. Nuestro objetivo es resolver el problema en 24h. Consulta el archivo `CONTRIBUTING.md` para las pautas sobre esto.

> **Protocolo Simplificado para Solicitudes de Eliminación de Contenido (Recomendado sobre _DMCA_)**
   > 1. Lee CONTRIBUTING.md para ver las pautas de issues
   > 2. Abre un issue de *solicitud de eliminación de contenido*
   > 3. Envía un correo electrónico a bruno.c.scaglione@gmail.com con el asunto "[lunchSTEM] Solicitud de Eliminación de Contenido: #NUMERO_DE_ISSUE_GITHUB_PLACEHOLDER" explicando: quién eres, la ruta del contenido(s) que necesitas que sea eliminado y enlace al issue específico que abriste.

<br>

> Esta opción es __más rápida y más amigable que una notificación *DMCA*__. Si recibimos múltiples notificaciones *DMCA*, el proyecto corre el riesgo de ser eliminado de *Github* (incluso después de quitar los contenidos) y muchas personas que podrían beneficiarse de él se verán afectadas.

**Cumplimiento de la *Ley de Derechos de Autor del Milenio Digital* (*DMCA*):** cumplimos con la Ley de Derechos de Autor del Milenio Digital (DMCA). Para solicitudes formales de eliminación, por favor sigue el proceso *DMCA*.

## Atribución de Créditos

Los datos de atribución de créditos de un archivo pdf se almacenan en `<nombre_archivo>.pdf.source.json` que debe abrirse directamente (sin `dvc pull`). Este archivo puede contener autores, universidad, editorial, enlace a la fuente, y otros metadatos sobre el archivo específico al que hace referencia. El valor predeterminado de los campos es `null`, con la excepción del valor predeterminado del campo `changes_were_made` que es `False`.

## Requisitos para el Uso

Asegúrate de tener estas herramientas instaladas:

- `git`
- `rclone`

Estas pueden instalarse siguiendo su respectiva guía de instalación en sus sitios web.

- [guía de instalación de git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [guía de instalación de rclone](https://rclone.org/install/)

> [!NOTE]
> Al configurar un almacenamiento remoto para _rclone_, asegúrate de usar la opción de cuenta de servicio y `lunch-stem-fadf503639fe.json` como archivo de cuenta de servicio.

## Cómo Usar

1. **Abre una terminal**: Para abrir la terminal, usa la funcionalidad de búsqueda de tu sistema operativo (presionando la tecla de Windows o Cmd + Espacio en Mac) y escribe "terminal", "símbolo del sistema" o "Windows Terminal" y selecciona la aplicación

2. **Clona el repositorio con git** (este comando creará una carpeta `lunch-stem` en tu directorio actual)

   ```bash
   git clone https://github.com/Freelunch-AI/lunch-stem.git
   ```
   > [!NOTE]
   > Si estás usando Windows, es importante clonar dentro de un directorio de nivel superior, para evitar errores potenciales relacionados con la creación de rutas de archivo demasiado largas. Windows típicamente tiene un máximo de ruta de archivo de 260 caracteres.

3. Entra en la carpeta `lunch-stem`

   ```bash
   cd lunch-stem
   ```

4. Configurar el proyecto

   **Para Linux**

   Habilitar ejecución de scripts

   ```bash
   chmod +x scripts/setup 
      ```

   Ejecutar script de configuración

   ```bash
   source scripts/setup 
      ```

   **Para Windows:**

   Habilitar ejecución de scripts dentro de la sesión de terminal

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
      ```

   Ejecutar script de configuración

   ```powershell
   scripts/setup.ps1
      ```

5. **Explora dentro de la carpeta `ai2f`**

6. **Descarga archivos pdf:**

   - Para archivos `.pdf.dvc`

      **Descarga archivos pdf específicos con:**

      ```bash
      lunch files "<primer_dvc_file_path_placeholder>" "[segundo_dvc_file_path_placeholder]" ...
      ```

      Este comando obtendrá los archivos `.pdf` y los colocará en tu directorio actual.

      Si quieres colocar los archivos en el mismo lugar que el archivo `pdf.dvc ` entonces usa:

      ```bash
      lunch files "<primer_dvc_file_path_placeholder>" "[segundo_dvc_file_path_placeholder]" --in-place ...
      ```

      - _Nota 1:_ el primer argumento de ruta de archivo es requerido, el resto son opcionales.
      - _Nota 2:_ la ruta del archivo utilizada en este comando no debe tener `.source.json` al final. debe terminar con `.pdf.dvc`.
      - _Nota 3:_ otros tipos de archivo (p. ej., `.txt`) deben abrirse directamente, sin dvc.
      - _Nota 4:_ si `.web.txt` está presente, entonces no debes intentar este comando, solo copia y pega el enlace dentro de `.web.txt` en tu navegador. Implementaremos un `lunch get` más adelante para obtener archivos de la web.
      - _Nota 5:_ el archivo `.pdf` no debería ser visible antes de ejecutar este comando.
      - _Nota 6:_ puedes obtener las rutas de archivos a través de la interfaz gráfica de usuario de tu Sistema Operativo, cada sistema operativo tiene una manera fácil.


      **Descarga todos los archivos de una carpeta específica via:**

      ```bash
         lunch folder "<folder_path_placeholder>"
      ```

      Si quieres colocar los nuevos archivos pdf en el mismo lugar que sus archivos `pdf.dvc` correspondientes entonces usa:

      ```bash
      lunch folder "<folder_path_placeholder>" --in-place
      ```

      Si quieres descargar todos los archivos de todos los subdirectorios (recursivamente) entonces usa:

      ```bash
      lunch folder "<folder_path_placeholder>" --recursive
      ```

      Si quieres colocar archivos en el mismo lugar que el archivo `pdf.dvc ` y para todos los subdirectorios entonces usa:

      ```bash
      lunch folder "<folder_path_placeholder>" --in-place --recursive
      ```
      Para depuración, usa la bandera `--verbose`.

   - Para archivos `pdf.web.txt`:

      Simplemente abre el archivo y sigue el enlace web dentro de él.

## Estructura de Directorios y Convenciones de Nomenclatura

- El directorio **`__Loopback`** contiene archivos que tenían una ruta demasiado larga. Se creó un archivo puntero `.sym.txt` en lugar de estos archivos apuntando al archivo real ubicado dentro del directorio `__Loopback`. Estos archivos txt puntero siguen esta convención de nomenclatura: `nombre_archivo.extensión_archivo.sym.txt` y están ubicados en el mismo directorio donde debería estar el archivo real.

- El archivo **`to-add.txt`** en la raíz contiene enlaces a materiales que se incluirán más tarde en lunchSTEM.

- Los archivos o carpetas que comienzan con **MEGA** indican materiales agregadores (materiales que agregan un montón de enlaces sobre un tema específico).

- Los archivos o carpetas que comienzan con **Awesome** indican contenido de súper alta calidad.

## Notas

- *lunchSTEM* está en este momento más completo en los campos de Ciencias de la Computación e IA específicamente. Los campos de `Hardcore Science` son notablemente más superficiales en términos del árbol de temas.

## Intento de Hoja de Ruta

> **Nota:** Los pasos con la misma **[letra]** pueden hacerse en paralelo.

### Fase A: Problemas Fundamentales

1. **[b][a]** Crear convención de nomenclatura de ramas y reglas de ramas.

2. **[a]** Resolver problemas urgentes de derechos de autor y atribución de créditos relacionados con archivos reales que se almacenan
   - Hacer script CI que construya una lista de rutas `.source.json` que no tienen información de autor - estos deberían ser prioridad.

3. **[a]** Reemplazar archivos reales (y enlaces de página de inicio/punto de entrada) con enlaces para obtener los archivos directamente de su host original (usar un agente de IA que use navegador para ayudar con esto). El objetivo es que la mayoría de los archivos sean `nombre_archivo.extensión_archivo.web.txt` con el enlace dentro (es decir, archivo alojado externamente). Los usuarios aún pueden contribuir con archivos reales si son los autores de estos archivos (como hace *arXiv*) porque internamente seguiremos usando DVC para archivos reales.

4. **[a]** Implementar enlaces simbólicos adecuados que funcionen en todos los Sistemas Operativos. No más buscar manualmente la ruta dentro del archivo `.sym.txt` e ir manualmente a ese directorio. También implementar enlaces web fáciles, para evitar copiar/pegar manual de rutas dentro de `.web.txt` al navegador.

### Fase B: Adiciones Importantes

5. **[b][a]** Crear un *CLI de lunchSTEM* adecuado (no en bash, con docstrings, modular, con pruebas, compilado) paquete/instalable donde puedas:
   1. Obtener archivos o directorios (ya implementado de manera básica)
   2. Ocultar/Mostrar ciertos tipos de archivos (ej., ocultar: .dvc, .source.json, .prerequisites.json, enlaces simbólicos para otros sistemas operativos, etc)
   3. Hacer búsqueda: búsqueda por palabras clave y búsqueda semántica

6. **[b]** Hacer un *Servidor MCP de lunchSTEM*: primero, necesitar crear una versión `.md` de cada `.pdf`

7. **[b][a]** Hacer un sitio web para facilitar el consumo de *lunchSTEM* por humanos, donde los usuarios puedan:
   1. Visualizar y navegar el repositorio como un gráfico
   2. Usar búsqueda por palabras clave, basada en filtros y semántica
   3. Ver vista previa de documentos sin tener que abrirlos
   4. Abrir documentos directamente en el navegador
   5. Marcar con estrella un documento
   6. Hacer su propio etiquetado/marcado de favoritos sobre los materiales, que solo será visible para ellos.
   7. Hacer resaltados y notas en materiales que solo serán visibles para ellos
   8. Ver páginas de autores que enlazan a todos los materiales de un autor específico.
   9. Participar en foros de discusión sobre documentos específicos
   10. Ver documentos y autores populares/tendencia
   11. Ver estadísticas para documentos y autores

8. **[b]** Conseguir patrocinadores y subvenciones para: (1) apoyar nuestro alojamiento de aplicación; (2) construir un equipo dedicado de mantenedores de *lunchSTEM*; (3) pagar expertos para procesos de revisión por pares; y (4) enrutar un porcentaje del dinero a autores contribuyentes. Todo el dinero de patrocinio sería reinvertido en el proyecto, es un proyecto sin fines de lucro.

9. Crear Flujos de Trabajo CI

   1. **[b][a]** Reemplazar archivos `.pdf` reales con archivos `.pdf.dvc`, evitando archivos de conocimiento reales en el repositorio.

   2. **[b][a]** Agregar eliminación de archivos maliciosos, eliminación de archivos grandes, eliminación de repositorios git, eliminación de archivos con extensiones no aceptadas, eliminación de material con derechos de autor, etc para evitar automáticamente PRs malos.

   3. **[b][a]** Agregar aplicación de convenciones estándar en CI para mantener consistente la base de conocimiento, evitando PRs inconsistentes.

### Fase C: Más Características Principales

10. **[b][c][d]** Agregar características a *lunchSTEM*, potencialmente usando *AgentPool* para ayudar (en paralelo: seguir agregando más materiales de `to_add.txt`, pero agregar como `nombre_archivo.extensión_archivo.web.txt` con el enlace HTTPS dentro del archivo):
    - **Prerrequisitos:** Agregar `[nombre_archivo.[extensión_archivo].prerequisites.json` conteniendo lista jerárquica de prerrequisitos para cada archivo
    - **Ejercicios:** Poner ejercicios con soluciones en cada directorio de tema dentro de `__Exercises`
    - **Herramientas:** poner herramientas de software en cada tema dentro de `__Tools`. Pueden ser herramientas para hacer o entender algo relacionado con el tema.
    - **Pistas de Aprendizaje y Certificación:** pistas secuenciales guiadas (ej., pista de Ingeniero ML) con tiempo estimado de finalización de 3 o 6 meses, y con un examen/certificación interno o externo al final.
    - **Proyectos de Muestra:** Poner proyectos de muestra en cada directorio de tema dentro de `__Sample Projects`
    - **Asistente de IA dentro del CLI de lunchSTEM para hacer tu documento más fácil de entender**: puede agregar diagramas, notebook, escribimos en palabras más fáciles de entender, hacer ejemplos, etc. Se puede generar un conjunto de datos de entrenamiento/prompting empeorando sintéticamente materiales de aprendizaje buenos a propósito.
    - **Tutor de IA que usa lunchSTEM como su base de conocimiento**: tutor que puede hacer guías de estudio personalizadas, explicar bloques de texto enseñando todos sus prerrequisitos requeridos, hacer materiales interactivos personalizados, etc
    - **Revisor por Pares de IA que usa lunchSTEM como su base de conocimiento**: construir un Agente de IA capaz de revisar nuevos documentos *STEM* incluidos en PRs (y que no están en la lista de fuentes respetadas), para evitar tener que depender de revisiones por pares humanas que son lentas y costosas. Las Revisiones por Pares Humanas deberían entonces hacerse anualmente para atrapar errores del Revisor por Pares de IA y generar datos para mejorar al Revisor por Pares de IA en sus puntos débiles.
    - **Universidad lunchSTEM:** universidad gratuita en línea para personas que prefieren fechas límite estrictas, responsabilidades y aprender con otros. Sin exámenes. Cada año, los estudiantes construirán tecnologías o métodos existentes desde cero, inspirados en [build-your-own-x](https://github.com/codecrafters-io/build-your-own-x) junto con una monografía con todos los detalles importantes y lo compartirán con la comunidad mediante una publicación de blog. Los estudiantes terminan la universidad con un portafolio estelar para mostrar. Enfoque de enseñanza de arriba hacia abajo donde ayudamos a los estudiantes a aprender temas bajo demanda cuando lo necesitan para construir algo.

### Fase D: Mejoras Agradables de Tener

11. **[d]** Migrar de *Google Drive* a una mejor opción de almacenamiento (ej., *S3*).

12. **[d]** Hacer *AgentPool*: equipo de agentes diversos que hacen PRs al repositorio *lunchSTEM* después de discusiones internas, haciendo preguntas a humanos y evaluando cambios propuestos mediante fine-tuning de SLMs. Los agentes se modifican continuamente para asegurar diversidad y para mejorar su inteligencia basada en nuevo conocimiento aprobado agregado a *lunchSTEM*.

## Descargo de Responsabilidad y Términos

**BASE TAL COMO ESTÁ:** Este proyecto se proporciona "tal como está" sin garantías de ningún tipo. No hacemos representaciones sobre la precisión, completitud o legalidad del contenido.

**LIMITACIÓN DE RESPONSABILIDAD:** En la máxima medida permitida por la ley, los mantenedores del proyecto no serán responsables de ningún daño que surja del uso de este repositorio.

**TÉRMINOS DE SERVICIO:** Al usar este repositorio, aceptas respetar las leyes de derechos de autor, usar el contenido solo para fines educativos, y cumplir con todas las leyes aplicables en tu jurisdicción.

**NO ASESORAMIENTO LEGAL:** Nada en este repositorio constituye asesoramiento legal, financiero o profesional.

**Propósito Educativo:** Este proyecto tiene como objetivo proporcionar acceso organizado a materiales educativos para fines educativos no comerciales. Creemos que muchos usos del contenido pueden calificar para protecciones de uso justo, pero las determinaciones de uso justo se hacen caso por caso por los tribunales.

## Patrocinadores

__¿Quieres ser un patrocinador? Envía un correo electrónico a bruno.c.scaglione@gmail.com con el asunto "[lunchSTEM] Patrocinio"__ 

## [Freelunch](https://freelunch.dev)

![Logo de Freelunch](./sponsors/freelunch/logo_freelunch_with_name.png)

## Reconocimientos



