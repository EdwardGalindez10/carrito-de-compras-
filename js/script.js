// Cuando el usuario hace clic en "Comprar" sin estar logueado:
function verProducto(idProducto) {
    if (!usuarioLogueado) { // Verifica si hay sesión (ej: con PHP o cookie)
        window.location.href = `login.php?redirect=producto&id=${idProducto}`;
    } else {
        agregarAlCarrito(idProducto); // Función existente
    }
}