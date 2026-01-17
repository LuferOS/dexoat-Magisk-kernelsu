# 🚀 Android App Optimizer (Speed Profile)
> *Módulo para Magisk & KernelSU*

![Magisk](https://img.shields.io/badge/Magisk-Module-green?style=for-the-badge&logo=android)
![KernelSU](https://img.shields.io/badge/KernelSU-Supported-blue?style=for-the-badge&logo=linux)
![Author](https://img.shields.io/badge/Dev-LuferOS-orange?style=for-the-badge&logo=github)

¡Bienvenido! Este módulo está diseñado para darle un "empujón" de rendimiento a tus aplicaciones instaladas forzando una recompilación inteligente del sistema tras la instalación.

---

## 🧐 ¿Cómo funciona?

Este módulo actúa como un disparador de optimización post-arranque. Aquí está la magia bajo el capó:

1.  **⚡ Acción Principal:** Ejecuta un script (`service.sh`) **una única vez** tras el primer reinicio después de instalar el módulo.
2.  **🛠 Recompilación Forzada:** Ordena al sistema Android (vía `cmd package compile`) que recompile todas las aplicaciones de usuario (Terceros).
3.  **🧠 Filtro Inteligente (`speed-profile`):**
    * No compila todo "a lo bruto". Utiliza el perfil `speed-profile`.
    * **El equilibrio perfecto:** Optimiza las partes más usadas del código basándose en cómo usas tu móvil, mejorando la velocidad sin devorar tu almacenamiento.
4.  **🛑 Ejecución Única (Zero Lag):** Para no ralentizar tus siguientes arranques, el script crea un archivo testigo (`.ran_once`). Si el sistema ve este archivo, el script **no hace nada**, asegurando que tu inicio sea rápido siempre.

---

## 📲 Instalación

¡Es súper sencillo! Sigue estos pasos:

1.  **Descarga** el archivo `.zip` del módulo.
2.  Abre tu gestor favorito: **Magisk Manager** o **KernelSU**.
3.  Ve a la pestaña de **Módulos**.
4.  Toca en **"Instalar desde almacenamiento"** y selecciona el archivo.
5.  **Reinicia tu dispositivo**.
    * *Nota:* Tras arrancar, espera unos **60 segundos** adicionales. El módulo trabaja en segundo plano para asegurar estabilidad antes de empezar a compilar.

---

## 📋 Requisitos y Compatibilidad

| Requisito | Detalle |
| :--- | :--- |
| **Root Manager** | Magisk o KernelSU (versiones recientes recomendadas). |
| **Android** | Android 7 (Nougat) en adelante. |
| **Recomendado** | Funciona mejor y más consistentemente en **Android 9 (Pie) o superior**. |

---

## ⚠️ ¿Cuándo NO instalar este módulo?

Sé responsable con tu dispositivo. **Evita instalarlo si:**

* ❌ **No tienes Root:** Obvio, pero necesario recordar. Requiere acceso privilegiado.
* ❌ **Tienes poco espacio:** Aunque `speed-profile` es eficiente, compilar apps ocupa algo más de espacio que el código interpretado. Si estás al límite de almacenamiento, ten cuidado.
* ❌ **Tu móvil ya es inestable:** Si sufres de *bootloops* o reinicios aleatorios, no añadas más carga al sistema.
* ❌ **ROMs muy modificadas:** Algunas Custom ROMs ya traen sus propios scripts de `dexopt`. Esto podría causar conflictos.
* ❌ **Miedo al riesgo:** Siempre existe una mínima posibilidad de *bootloop* o consumo alto de batería temporal mientras se compila. **¡Haz siempre un Backup antes!**

> **Nota:** Android tiene su propio sistema de optimización en segundo plano (cuando el móvil carga de noche). Este módulo solo *fuerza* ese proceso inmediatamente para usuarios que quieren rendimiento *ya*.

---

## 🤝 Colaboración

¡Este proyecto es de código abierto y la comunidad es bienvenida!
Si tienes ideas para mejorar el script, nuevos filtros de compilación o correcciones:

1.  Haz un **Fork** del repositorio.
2.  Crea tu rama de características (`git checkout -b feature/AmazingFeature`).
3.  Haz tus cambios y **Commit** (`git commit -m 'Add some AmazingFeature'`).
4.  Sube tus cambios (`git push origin feature/AmazingFeature`).
5.  Abre un **Pull Request**.

---

<div align="center">

### Desarrollado con ❤️ por [LuferOS](https://github.com/LuferOS)
*Si te sirvió, ¡no olvides dejar una estrella ⭐ en el repo!*

</div>
