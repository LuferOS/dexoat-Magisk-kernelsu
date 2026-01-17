#!/system/bin/sh
# Modulo: Android App Optimizer
# Dev: LuferOS
# Script optimizado con failovers, logs y protección de batería.

# --- Variables y Configuración ---
MODDIR=${0%/*}
LOG_FILE="/data/local/tmp/luferos_optimizer.log"
MARKER_FILE="$MODDIR/.ran_once"
COMPILER_FILTER="speed-profile"
BATTERY_THRESHOLD=20

# --- Funciones ---

# Función de Log dual (Logcat + Archivo)
print_log() {
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$timestamp - $1" >> "$LOG_FILE"
  log -p i -t LuferOS_Optimizer "$1"
}

# --- Inicio del Script ---

# 1. Espera a que el sistema arranque
while [ "$(getprop sys.boot_completed)" != "1" ]; do
  sleep 1
done

# 2. Espera de estabilización (60s)
sleep 60

# 3. Verificación de Ejecución Única (Run-Once)
# Si el archivo marcador existe, el script asume que ya hizo su trabajo y se detiene.
if [ -f "$MARKER_FILE" ]; then
  log -p i -t LuferOS_Optimizer "El script ya se ejecutó anteriormente. Saliendo."
  exit 0
fi

# 4. Verificación de Batería (Failover de seguridad)
# Lee la capacidad actual de la batería. Si falla la lectura, asume 100 para no bloquear.
BATTERY_LEVEL=$(cat /sys/class/power_supply/battery/capacity 2>/dev/null || echo 100)

if [ "$BATTERY_LEVEL" -lt "$BATTERY_THRESHOLD" ]; then
  print_log "ABORTADO: Batería baja ($BATTERY_LEVEL%). Se requiere mínimo $BATTERY_THRESHOLD%."
  exit 1
fi

# --- Lógica Principal ---

print_log "Iniciando proceso de optimización. Filtro: $COMPILER_FILTER"
print_log "Batería actual: $BATTERY_LEVEL%"

# Limpia el log anterior si es muy grande (opcional)
if [ -f "$LOG_FILE" ] && [ $(stat -c%s "$LOG_FILE") -gt 102400 ]; then
  rm "$LOG_FILE"
fi

# Obtiene la lista limpia de paquetes de terceros
# Usamos 'awk' o 'sed' para limpiar la salida de 'pm list' de forma más segura
PACKAGES=$(pm list packages -3 | sed 's/^package://')

if [ -z "$PACKAGES" ]; then
  print_log "Error: No se detectaron aplicaciones de terceros."
  exit 1
fi

COUNT=0
TOTAL=$(echo "$PACKAGES" | wc -l)

print_log "Se encontraron $TOTAL aplicaciones para optimizar."

for pkg in $PACKAGES; do
  # Verifica si el paquete aún existe
  if pm path "$pkg" > /dev/null 2>&1; then
    
    # Ejecuta la compilación con 'nice -n 19'
    # Esto le da la prioridad MÁS BAJA al proceso, evitando que el teléfono se congele (lag)
    nice -n 19 cmd package compile -m "$COMPILER_FILTER" -f "$pkg" > /dev/null 2>&1
    
    # Verificamos el código de salida del comando anterior
    if [ $? -eq 0 ]; then
      print_log "[$((++COUNT))/$TOTAL] OK: $pkg"
    else
      print_log "[$((++COUNT))/$TOTAL] FAIL: $pkg (Error en cmd compile)"
    fi
    
    # Pequeña pausa para enfriar CPU
    sleep 0.5
  else
    print_log "SKIP: $pkg ya no existe."
  fi
done

# --- Finalización ---

print_log "Optimización completada exitosamente."

# Crear el archivo marcador para que NO se ejecute en el próximo reinicio
touch "$MARKER_FILE"
print_log "Marcador creado. No se ejecutará de nuevo hasta reinstalar el módulo."

exit 0
