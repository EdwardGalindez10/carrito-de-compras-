document.querySelectorAll('.accordion h3').forEach(button => {
    button.addEventListener('click', () => {
        const content = button.nextElementSibling;
        content.style.display = content.style.display === 'block' ? 'none' : 'block';
    });
});


document.querySelectorAll('.sizes button').forEach(button => {
    button.addEventListener('click', function () {
        // Remueve la clase 'selected' de todos los botones
        document.querySelectorAll('.sizes button').forEach(btn => {
            btn.classList.remove('selected');
        });

        // Añade la clase 'selected' al botón clicado
        this.classList.add('selected');
    });
});

