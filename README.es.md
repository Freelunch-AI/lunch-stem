<div align="center">
   <img src="./assets/logos/lunch_stem_light_logo_with_name.png" alt="lunchSTEM Logo" width="300" style="display: inline-block; margin-right: 30px;"/> 
   <img src="./assets/lunch-stem-promotion-meme.jpg" alt="lunchSTEM meme" width="300" style="display: inline-block;">
</div>

<h1 align="center">Democratizando el conocimiento <i>STEM</i> de manera organizada</h1><br>

<p align="center">
   <strong>🌟 Proyecto sin fines de lucro, código abierto (v0.1.0) 🌟</strong>
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

<h2 align="center">⭐ Dale una Estrella al Proyecto</h2>

Si encuentras lunchSTEM útil, ¡por favor considera darnos una estrella en GitHub! Nos ayuda a llegar a más personas y nos mantiene motivados.

<p align="center">
   <a href="https://github.com/Freelunch-AI/lunch-stem">
      <img src="assets/star-github.png" alt="Dale una estrella a un proyecto de Github" width=200>
   </a> <br>
   <em>Imagen de Ejemplo</em>
</p>

---

## 📚 Tabla de Contenidos

- [🔍 Descripción General](#-descripción-general)
- [🎯 ¿Para quién es esto?](#-para-quién-es-esto)
- [📊 Estadísticas del Proyecto](#-estadísticas-del-proyecto)
- [⚙️ Requisitos para el Uso](#-requisitos-para-el-uso)
- [🚀 Cómo Usar](#-cómo-usar)
- [📁 Estructura de Directorios y Convenciones de Nomenclatura](#-estructura-de-directorios-y-convenciones-de-nomenclatura)
- [🔬 Cobertura de Campos STEM](#-cobertura-de-campos-stem)
- [🤝 Contribuciones](#-contribuciones)
- [🗺️ Intento de Hoja de Ruta](#-intento-de-hoja-de-ruta)
- [🗑️ Solicitudes de Eliminación de Contenido y Atribución de Créditos](#-solicitudes-de-eliminación-de-contenido-y-atribución-de-créditos)
- [📝 Atribución de Créditos](#-atribución-de-créditos)
- [⚖️ Descargo de Responsabilidad y Términos](#-descargo-de-responsabilidad-y-términos)
- [💎 Patrocinadores](#-patrocinadores)
- [🙏 Agradecimientos](#-agradecimientos)

## 🔍 Descripción General

Esta es una base de conocimiento *STEM* (Science, Technology, Engineering and Mathematics) en evolución, destinada a ser revisada y mejorada con el esfuerzo de la comunidad. Puede ser utilizada y mejorada por humanos y agentes de IA.

Su caso de uso ideal es ser utilizada para **profundizar en un tema *STEM* (y temas relacionados) después de que tengas una comprensión inicial del mismo** (que puedes obtener fácilmente a través de búsquedas en Google o asistentes de IA).

Debería ser más organizada y de mayor calidad (relación señal-ruido) que la búsqueda predeterminada de Google/investigación profunda de IA para este caso de uso.

El objetivo es, más adelante, permitir que los agentes de IA la utilicen fácilmente como herramienta creando un *servidor MCP de lunchSTEM*.

## 🎯 ¿Para quién es esto?

- **Estudiantes** que buscan materiales de aprendizaje complementarios
- **Profesionales** que quieren profundizar su conocimiento STEM
- **Investigadores** que necesitan materiales de referencia organizados
- **Educadores** que buscan recursos de enseñanza
- **Autodidactas** que persiguen el estudio independiente

## 📊 Estadísticas del Proyecto

- **Tamaño:** 60+ GB (incluyendo muchos enlaces)
- **Número de archivos PDF:** 10k+
- **Número de sub-temas:** 6k+
- **Idioma de los materiales:** Inglés

## ⚙️ Requisitos para el Uso

Asegúrate de tener estas herramientas instaladas:

- `git`
- `rclone`

Estas pueden instalarse siguiendo su respectiva guía de instalación en sus sitios web.

- [Guía de instalación de git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Guía de instalación de rclone](https://rclone.org/install/)

> [!NOTE]
> Al configurar un almacenamiento remoto para _rclone_, asegúrate de usar la opción de cuenta de servicio y `lunch-stem-fadf503639fe.json` como archivo de cuenta de servicio.
>
> Además, al instalar *rclone*, los usuarios de *Windows* podrían ver una advertencia de seguridad, es normal.

## 🚀 Cómo Usar

1. **Abrir una terminal**: Para abrir la terminal, usa la función de búsqueda de tu sistema operativo (presionando la tecla Windows o Cmd + barra espaciadora en Mac) y escribe "terminal", "Símbolo del sistema" o "Windows Terminal" y selecciona la aplicación

2. **Clonar el repositorio con git** (este comando creará una carpeta `lunch-stem` en tu directorio actual)

   ```bash
   git clone https://github.com/Freelunch-AI/lunch-stem.git
   ```
   > [!NOTE]
   > Si estás usando Windows, es importante clonar dentro de un directorio de nivel superior, para evitar errores potenciales relacionados con la creación de rutas de archivo que son demasiado largas. Windows típicamente tiene una ruta de archivo máxima de 260 caracteres.

   > [!NOTE]
   > El comando `git clone` copiará el proyecto en tu máquina con toda la estructura de carpetas ya en su lugar.

3. Entrar a la carpeta `lunch-stem`

   ```bash
   cd lunch-stem
   ```

4. Configurar el proyecto

   **Para Linux**

   Configurar rclone

   Habilitar ejecución de scripts

   ```bash
   chmod +x scripts/setup 
      ```

   Ejecutar script de configuración

   ```bash
   source scripts/setup 
      ```

   Deberías ver el mensaje `Setup complete!` impreso en la terminal, junto con otros detalles.

   **Para Windows:**

   Habilitar ejecución de scripts dentro de la sesión de terminal

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
      ```

   Ejecutar script de configuración

   ```powershell
   scripts/setup.ps1
      ```

   Deberías ver el mensaje `Setup complete!` impreso en la terminal, junto con otros detalles.

5. **Navegar dentro de la carpeta `ai2f`**

   Estructura de la carpeta `ai2f`:

         ├── __Loopback
         ├── Computer Science and Engineering 
         ├── Hardcore Engineering 
         ├── Hardcore Science  
         └── Mathematics

6. **Descargar archivos PDF:**

   - Para archivos `.pdf.dvc`

      **Descargar archivos PDF específicos con:**

      ```bash
      lunch files "<primera/ruta/archivo/dvc/marcador.pdf.dvc>" "[segunda/ruta/archivo/dvc/marcador.pdf.dvc]"
      ```

      donde puedes poner múltiples rutas de archivo, solo la primera es requerida.

      Este comando obtendrá los archivos `.pdf` y los pondrá en tu directorio actual.

      > [!TIP]
      > **Ejemplo de Uso:**
      > 
      > ```bash
      > lunch files "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\3 - OS, Virtual Memory, OS Abstractions.pdf.dvc" "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\4 - Bounded Buffers, Concurrency, Locks.pdf.dvc" "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\5 - Threads, Condition Variables, Preemption.pdf.dvc"
      > ```
      > Descarga `3 - OS, Virtual Memory, OS Abstractions.pdf`, `4 - Bounded Buffers, Concurrency, Locks.pdf` y `5 - Threads, Condition Variables, Preemption.pdf` en el directorio donde se ejecutó el comando.


      Si quieres poner archivos en el mismo lugar que el archivo `pdf.dvc`, entonces usa:

      ```bash
      lunch files "<primera/ruta/archivo/dvc/marcador.pdf.dvc>" "[segunda/ruta/archivo/dvc/marcador.pdf.dvc]" --in-place
      ```

      - _Nota 1:_ el primer argumento de ruta de archivo es requerido, el resto son opcionales.
      - _Nota 2:_ la ruta de archivo usada en este comando no debería tener `.source.json` al final. debería terminar con `.pdf.dvc`.
      - _Nota 3:_ otros tipos de archivos (ej. `.txt`) deberían abrirse directamente, sin usar la CLI de lunch.
      - _Nota 4:_ si `.web.txt` está presente, entonces no deberías intentar este comando, solo copia y pega el enlace dentro de `.web.txt` en tu navegador. Implementaremos un `lunch get` más tarde para obtener archivos de la web.
      - _Nota 5:_ el archivo `.pdf` no debería ser visible antes de que ejecutes este comando.
      - _Nota 6:_ puedes obtener las rutas de archivo a través de la interfaz gráfica de usuario de tu Sistema Operativo, cada sistema operativo tiene una manera fácil.


      **Descargar todos los archivos de una carpeta específica vía:**

      ```bash
      lunch folder "<ruta/carpeta/marcador>"
      ```

      Si quieres poner los nuevos archivos PDF en el mismo lugar que sus archivos `pdf.dvc` correspondientes, entonces usa:

      ```bash
      lunch folder "<ruta/carpeta/marcador>" --in-place
      ```

      Si quieres descargar todos los archivos de todos los subdirectorios (recursivamente), entonces usa:

      ```bash
      lunch folder "<ruta/carpeta/marcador>" --recursive
      ```

      Si quieres poner archivos en el mismo lugar que el archivo `pdf.dvc` y para todos los subdirectorios, entonces usa:

      ```bash
      lunch folder "<ruta/carpeta/marcador>" --in-place --recursive
      ```
      Para depuración, usa la bandera `--verbose`.

   - Para archivos `pdf.web.txt`:

      Simplemente abre el archivo y sigue el enlace web dentro de él.

   - Para archivos `.sym.txt`:

      Simplemente abre el archivo y navega a la ruta de archivo o carpeta escrita dentro de él. Este archivo o carpeta estará dentro del `__Loopback`.

> [!WARNING]
> **⚠️ Importante**
> 
> Los documentos en *lunchSTEM* son creados por autores externos, no por nosotros. No apoyamos la inclusión de documentos no distribuibles sin permiso del autor (para documentos no distribuibles: revisa `author_permissions.jsonl`).
> 
> Cada documento acredita a su(s) autor(es) en un archivo correspondiente `<nombre_archivo>.<extensión_archivo>.source.json`.
> 
> Los autores pueden solicitar la eliminación de contenido en cualquier momento. Después de seguir nuestro protocolo simplificado para *Solicitudes de Eliminación de Contenido*, removemos el contenido dentro de 24 horas. Esta opción es más rápida y amigable que una notificación *Digital Millennium Copyright Act (DMCA)* (que puede cerrar el proyecto).

> [!NOTE]
> **🟩 Próximamente**
> 
> • **Sitio web** con páginas de inicio de autores, búsqueda por palabras clave/semántica, foros de discusión sobre documentos, vistas previas de contenido, visualizaciones de contenido interactivo, marcado/etiquetado/favoritos de contenido, tomar notas sobre documentos, documentos en tendencia/populares, estadísticas para documentos y autores, y más.
> 
> • **Servidor MCP:** útil para Agentes de IA que realizan trabajo de ingeniería complejo o investigación científica.
> 
> • **CLI apropiada** donde los usuarios pueden hacer búsquedas por palabras clave y búsquedas semánticas.

## 📁 Estructura de Directorios y Convenciones de Nomenclatura

- El directorio **`__Loopback`** contiene archivos que tenían una ruta que era demasiado larga. Se creó un archivo puntero `.sym.txt` en lugar de estos archivos apuntando al archivo real ubicado dentro del directorio `__Loopback`. Estos archivos txt puntero siguen esta convención de nomenclatura: `nombre_archivo.extensión_archivo.sym.txt` y están ubicados en el mismo directorio donde debería estar el archivo real.

- El archivo **`to_add.txt`** en la raíz contiene enlaces a materiales que se incluirán más tarde en lunchSTEM.

- Los archivos o carpetas que comienzan con **MEGA** indican materiales agregadores (materiales que agregan un montón de enlaces sobre un tema específico).

- Los archivos o carpetas que comienzan con **Awesome** indican contenido de súper alta calidad.

## 🔬 Cobertura de Campos _STEM_

### Campos Más Fuertes

*lunchSTEM* es por el momento más completo en los campos de `Computer Science & Engineering` e `IA` específicamente.

### Campos Más Débiles

Los campos de `Hardcore Science` (Física, Química, Biología, Economía) son notablemente más superficiales en términos de la profundidad de su árbol de temas.

## 🤝 Contribuciones

Si quieres contribuir al proyecto, revisa nuestro [CONTRIBUTING.md](https://github.com/Freelunch-AI/lunch-stem/blob/main/CONTRIBUTING.md).

> [!WARNING]
> El archivo de cuenta de servicio GCP es intencionalmente público en este repositorio, solo tiene derechos de lectura a la carpeta de Google Drive que contiene los PDFs.
>
> Sabemos que no es buena práctica hacerlos públicamente disponibles, pero fue la manera de poder aprovechar nuestra suscripción existente de Google Drive (sin tener que hacer un backend globalmente escalable).
>
> Pronto nos moveremos a un bucket S3 público, y entonces, este pequeño "hack" será removido.

## 🗺️ Intento de Hoja de Ruta

> **Nota:** Los pasos con la misma **[letra]** pueden hacerse en paralelo.

### Fase A: Problemas Fundamentales

1. **[b][a]** Crear convención de nomenclatura de ramas y reglas de ramas.

2. **[a]** Resolver problemas urgentes de derechos de autor y atribución de créditos relacionados con archivos reales siendo almacenados
   - Hacer script CI que construya una lista de rutas `.source.json` que no tienen información de autor - estos deberían ser prioridad.

3. **[a]** Reemplazar archivos reales (y enlaces de página de inicio/punto de entrada) con enlaces para obtener los archivos directamente de su host original (usar un agente de IA que use navegador para ayudar con esto). El objetivo es que la mayoría de archivos sean `nombre_archivo.extensión_archivo.web.txt` con el enlace dentro de él (i.e., archivo hospedado externamente). Los usuarios aún pueden contribuir con archivos reales si son los autores de estos archivos (como hace *arXiv*) porque bajo el capó seguiremos usando DVC para archivos reales.

4. **[a]** Implementar enlaces simbólicos apropiados que funcionen en todos los Sistemas Operativos. No más buscar manualmente la ruta dentro del archivo `.sym.txt` y navegar manualmente a ese directorio. También implementar enlaces web fáciles, para evitar copiar/pegar manualmente rutas dentro de `.web.txt` al navegador.

### Fase B: Adiciones Importantes

5. **[b][a]** Crear un paquete/instalable *CLI de lunchSTEM* apropiado (no en bash, con docstrings, modular, con pruebas, compilado) donde puedas:
   1. Obtener archivos o directorios (ya implementado de manera básica)
   2. Ocultar/Mostrar ciertos tipos de archivo (ej., ocultar: .dvc, .source.json, .prerequisites.json, enlaces simbólicos para otros sistemas operativos, etc.)
   3. Hacer búsqueda: búsqueda por palabras clave y búsqueda semántica

6. **[b]** Hacer un *Servidor MCP de lunchSTEM*: primero, necesita crear una versión `.md` de cada `.pdf`

7. **[b][a]** Hacer un sitio web para facilitar el consumo de *lunchSTEM* por humanos, donde los usuarios puedan:
   1. Visualizar y navegar el repositorio como un grafo
   2. Usar búsqueda por palabras clave, basada en filtros y semántica
   3. Ver vista previa de documentos sin tener que abrirlos
   4. Abrir documentos directamente en el navegador
   5. Marcar un documento con estrella
   6. Hacer su propio etiquetado/favoritos sobre los materiales, que solo será visible para ellos
   7. Hacer resaltados y notas en materiales que solo serán visibles para ellos
   8. Ver páginas de inicio de autores que enlazan a todos los materiales de un autor específico
   9. Participar en foros de discusión sobre documentos específicos
   10. Ver documentos y autores en tendencia/populares
   11. Ver estadísticas para documentos y autores

8. **[b]** Conseguir patrocinadores y subvenciones para: (1) apoyar nuestro alojamiento de aplicación; (2) construir un equipo dedicado de mantenedores de *lunchSTEM*; (3) pagar expertos para procesos de revisión por pares; y (4) enrutar un porcentaje del dinero a autores contribuyentes. Todo el dinero de patrocinio sería reinvertido en el proyecto, es un proyecto sin fines de lucro.

9. Hacer Flujos de Trabajo CI

   1. **[b][a]** Reemplazar archivos `.pdf` reales con archivos `.pdf.dvc`, evitando archivos de conocimiento reales en el repositorio.

   2. **[b][a]** Agregar eliminación de archivos maliciosos, eliminación de archivos grandes, eliminación de repositorio git, eliminación de archivos con extensiones no aceptadas, eliminación de material con derechos de autor, etc. para evitar automáticamente PRs malos.

   3. **[b][a]** Agregar aplicación de convenciones estándar en CI para mantener la base de conocimiento consistente, evitando PRs inconsistentes.

### Fase C: Más Características Centrales

10. **[b][c][d]** Agregar características a *lunchSTEM*, potencialmente usando *AgentPool* para ayudar (en paralelo: seguir agregando más materiales de `to_add.txt`, pero agregar como `nombre_archivo.extensión_archivo.web.txt` con el enlace HTTPS dentro del archivo):
    - **Prerrequisitos:** Agregar `<nombre_archivo>.<extensión_archivo>.prerequisites.json` conteniendo lista jerárquica de prerrequisitos para cada archivo
    - **Ejercicios:** Poner ejercicios con soluciones en cada directorio de tema dentro de `__Exercises`
    - **Herramientas:** poner herramientas de software en cada tema dentro de `__Tools`. Pueden ser herramientas para hacer o entender algo relacionado con el tema.
    - **Pistas de aprendizaje y certificación:** pistas secuenciales guiadas (ej., pista de Ingeniero ML) con tiempo estimado de finalización de 3 o 6 meses, y con un examen/certificación interno o externo al final.
    - **Proyectos de muestra:** Poner proyectos de muestra en cada directorio de tema dentro de `__Sample Projects`
    - **Asistente de IA dentro de la CLI de lunchSTEM para hacer tu documento más fácil de entender**: puede agregar diagramas, notebook, escribimos en palabras más fáciles de entender, hacer ejemplos, etc. Un dataset de entrenamiento/prompting puede generarse empeorando sintéticamente buenos materiales de aprendizaje a propósito.
    - **Tutor de IA que usa lunchSTEM como su base de conocimiento**: tutor que puede hacer guías de estudio personalizadas, explicar bloques de texto enseñando todos sus prerrequisitos requeridos, hacer materiales interactivos personalizados, etc.
    - **Revisor por pares de IA que usa lunchSTEM como su base de conocimiento**: construir un Agente de IA capaz de revisar nuevos documentos *STEM* incluidos en PRs (y que no están en la lista de fuentes respetadas), para evitar tener que depender de revisiones por pares humanas que son lentas y costosas. Las Revisiones por Pares Humanas deberían entonces hacerse anualmente para atrapar errores del Revisor por Pares de IA y generar datos para mejorar el Revisor por Pares de IA en sus puntos débiles.
    - **Universidad lunchSTEM:** universidad gratuita, en línea para personas que prefieren fechas límite estrictas, responsabilidades y aprender con otros. Sin exámenes. Cada año, los estudiantes construirán tecnologías o métodos existentes desde cero, inspirados por [build-your-own-x](https://github.com/codecrafters-io/build-your-own-x) junto con una monografía con todos los detalles importantes y compartirlo con la comunidad vía una publicación de blog. Los estudiantes terminan la universidad con un portafolio estelar para mostrar. Enfoque de enseñanza de arriba hacia abajo donde ayudamos a los estudiantes a aprender temas bajo demanda cuando lo necesitan para construir algo.

### Fase D: Mejoras Agradables de Tener

11. **[d]** Migrar de *Google Drive* (ya estaba pagando por 2TB, por eso lo usé) a una mejor opción de almacenamiento (ej., *S3*).

12. **[d]** Hacer *AgentPool*: equipo de agentes diversos que hacen PRs al repositorio *lunchSTEM* después de discusiones internas, haciendo preguntas a humanos y evaluando cambios propuestos mediante fine-tuning de SLMs. Los agentes son continuamente modificados para asegurar diversidad y mejorar su inteligencia basada en nuevo conocimiento aprobado agregado a *lunchSTEM*.

## 🗑️ Solicitudes de Eliminación de Contenido y Atribución de Créditos

Se hizo un gran esfuerzo para detectar y eliminar contenido con derechos de autor (no distribuible), y para reconocer a los autores/editores/universidades de los materiales restantes. La revisión manual de cada archivo no pudo hacerse debido a la cantidad absoluta de archivos (pero damos la bienvenida a la comunidad para ayudarnos con esto abriendo issues y PRs).
1. Ejecutamos scripts para eliminar cualquier archivo que contenga cualquier otra extensión fuera de: `.pdf`, `.txt`, `.md`, `.ipynb`, `.json`
2. Ejecutamos scripts para detección automatizada de palabras clave relacionadas con derechos de autor en documentos y eliminación de tales documentos
3. Ejecutamos scripts para eliminación automatizada de artículos académicos.
4. Reemplazamos manualmente cada PDF de libro por un enlace a él.
5. Ejecutamos scripts para creación automatizada de un archivo de atribución de crédito (`.source.json`) para cada PDF restante, con información como: autores, enlace a la fuente, modificado o no, etc. El valor predeterminado de los campos son `null`, con la excepción del valor predeterminado del campo `changes_were_made` que es `False`. Los valores predeterminados se usan cuando la información no puede encontrarse en el PDF mismo.

Sin embargo, no podemos garantizar perfección en este proceso, por lo tanto, si encuentras cualquier contenido con derechos de autor o contenido sin datos de atribución de crédito apropiados, por favor abre un issue y/o haz un PR y/o envía un email a bruno.c.scaglione@gmail.com. Apuntamos a resolver el problema en 24h. Refiere al archivo `CONTRIBUTING.md` para las pautas para esto.

> **Protocolo Simplificado para Solicitudes de Eliminación de Contenido (Recomendado sobre _DMCA_)**
   > 1. Lee CONTRIBUTING.md para ver pautas de issues
   > 2. Abre un issue de *solicitud de eliminación de contenido*
   > 3. Envía un email a bruno.c.scaglione@gmail.com con el asunto "[lunchSTEM] Solicitud de Eliminación de Contenido: #NUMERO_DE_ISSUE_DE_GITHUB_MARCADOR" explicando: quién eres, la ruta del/los contenido(s) que necesitas que sean removidos y enlace al issue específico que abriste.

<br>

> Esta opción es __más rápida y amigable que una notificación *DMCA*__. Si recibimos múltiples notificaciones *DMCA*, el proyecto corre riesgo de ser removido de *Github* (incluso después de quitar los contenidos) y muchas personas que podrían beneficiarse de él serán afectadas.

***Cumplimiento del Digital Millennium Copyright Act* (*DMCA*):** cumplimos con el Digital Millennium Copyright Act (DMCA). Para solicitudes formales de eliminación, por favor sigue el proceso *DMCA*.

## 📝 Atribución de Créditos

Los datos de atribución de créditos de un archivo PDF se almacenan en `<nombre_archivo>.pdf.source.json` que debería abrirse directamente (sin `dvc pull`). Este archivo puede contener autores, universidad, editor, enlace a la fuente, y otros metadatos sobre el archivo específico al que hace referencia. El valor predeterminado de los campos son `null`, con la excepción del valor predeterminado del campo `changes_were_made` que es `False`.

## ⚖️ Descargo de Responsabilidad y Términos

**BASE COMO-ES:** Este proyecto se proporciona "como-es" sin garantías de ningún tipo. No hacemos representaciones sobre la precisión, completitud o legalidad del contenido.

**LIMITACIÓN DE RESPONSABILIDAD:** En la máxima medida permitida por la ley, los mantenedores del proyecto no serán responsables por daños que surjan del uso de este repositorio.

**TÉRMINOS DE SERVICIO:** Al usar este repositorio, aceptas respetar las leyes de derechos de autor, usar contenido solo para propósitos educativos, y cumplir con todas las leyes aplicables en tu jurisdicción.

**NO ES ASESORÍA LEGAL:** Nada en este repositorio constituye asesoría legal, financiera o profesional.

**Propósito Educativo:** Este proyecto apunta a proporcionar acceso organizado a materiales educativos para propósitos educativos no comerciales. Creemos que muchos usos del contenido pueden calificar para protecciones de uso justo, pero las determinaciones de uso justo se hacen caso por caso por los tribunales.

## 💎 Patrocinadores

__¿Quieres ser un patrocinador? Envía un email a bruno.c.scaglione@gmail.com con el asunto "[lunchSTEM] Patrocinio"__ 

## [Freelunch](https://freelunch.dev)

![Freelunch Logo](./sponsors/freelunch/logo_freelunch_with_name.png)

## 🙏 Agradecimientos

A todos los autores que hicieron su contenido públicamente disponible.

A nuestros testeadores tempranos.

A nuestros contribuyentes, mantenedores y patrocinadores que mantienen el proyecto vivo y evolucionando.
