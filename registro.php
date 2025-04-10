<?php
session_start();
if (isset($_POST['registro'])) {
    // ... (procesa el registro)
    if (isset($_SESSION['producto_actual'])) {
        header("Location: producto.php?id=" . $_SESSION['producto_actual']);
    } else {
        header("Location: index.php");
    }
}
?>