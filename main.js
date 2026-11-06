const data = JSON.parse(localStorage.getItem('data')) || [];
function handleSubmit(e) {
    e.preventDefault();
    let {nombre, apellido, edad} = e.target;
    let newHuman = {
        id: data.length + 1, nombre: nombre.value, apellido: apellido.value, edad: edad.value //tiene que ser un autoincrement el id
    };
    data.push(newHuman);
    localStorage.setItem('data', JSON.stringify(data));
    updateTable();
}

function updateTable(){
    let tbody = document.querySelector('tbody');
    tbody.innerHTML = '';
    
    for (let human of data) {
        tbody.innerHTML += '<tr><td>' + human.id + '</td><td>' + human.nombre + '</td><td>' + human.apellido + '</td><td>' + human.edad + '</td></tr>';
    }
}