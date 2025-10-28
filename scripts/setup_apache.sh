#!/usr/bin/env bash
# Script para instalar Apache y dejar listo un servidor web en Ubuntu/Debian
# Autor: S3rk1s

# Salir si algo falla
set -e

echo "Actualizando paquetes..."
sudo apt update -y

echo "Instalando Apache..."
sudo apt install -y apache2

echo "Habilitando Apache para que arranque al inicio..."
sudo systemctl enable apache2

echo "Iniciando Apache..."
sudo systemctl start apache2

echo "Verificando que Apache esté activo..."
sudo systemctl status apache2 --no-pager | grep Active

# Crear una página de prueba si no existe
WEB_ROOT="/var/www/html"
if [ ! -f "$WEB_ROOT/index.html" ]; then
    echo "Creando página de ejemplo..."
    sudo bash -c "cat > $WEB_ROOT/index.html <<'EOF'
<!DOCTYPE html>
<html lang='es'>
<head>
    <meta charset='UTF-8'>
    <title>Mi servidor Apache</title>
</head>
<body style='font-family: Arial; text-align: center; margin-top: 50px;'>
    <h1>¡Apache funcionando!</h1>
    <p>Esta página se generó automáticamente con un script.</p>
</body>
</html>
EOF"
fi

# Permisos correctos
sudo chown -R www-data:www-data "$WEB_ROOT"
sudo chmod -R 755 "$WEB_ROOT"

# Reiniciar Apache para aplicar cambios
sudo systemctl restart apache2
