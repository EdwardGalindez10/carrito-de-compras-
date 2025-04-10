<?php
session_start();
$redirect = $_GET['redirect'] ?? 'inicio'; // Ej: 'producto' o 'carrito'
$idProducto = $_GET['id'] ?? null;

// Tras iniciar sesión exitosamente:
if (isset($_POST['login'])) {
    // ... (valida credenciales)
    if ($redirect == 'producto' && $idProducto) {
        header("Location: producto.php?id=$idProducto"); // Redirige al producto
    } else {
        header("Location: index.php"); // Página por defecto
    }
}
?>

<!-- HTML del formulario -->
<h1>Inicia sesión para continuar</h1>
<form method="POST">
    <input type="email" name="email" placeholder="Correo" required>
    <input type="password" name="password" placeholder="Contraseña" required>
    <button type="submit" name="login">Entrar</button>
</form>
<p>¿No tienes cuenta? <a href="registro.php">Regístrate</a></p>