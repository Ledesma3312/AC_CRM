import { activities_calendar_backend } from "../../declarations/activities_calendar_backend";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("button");

  const name = document.getElementById("name").value.toString();

  button.setAttribute("disabled", true);

  // Interact with foo actor, calling the greet method
  const greeting = await activities_calendar_backend.greet(name);

  button.removeAttribute("disabled");

  document.getElementById("greeting").innerText = greeting;

  return false;
}
);


  document.getElementById('addActivityForm').addEventListener('submit', function(event) {
    event.preventDefault();
    let activityDate = document.getElementById('activityDate').value;
    // Obtener otros valores del formulario
    // Llamar a la función saveActivity en tu canister con los detalles de la actividad
    // Ejemplo: 
    canister.saveActivity({ day: day, month: month, year: year, id: id }, { hora: hora, name: name, corp: corp, job: job, phone: phone, email: email });
    getActivity(activityDate);
  });


function getActivity(activityDate) {
    // Aquí se debe hacer la llamada al servidor para obtener las actividades para la fecha especificada
    // Puedes usar Fetch API o Axios para hacer la solicitud HTTP
    // Ejemplo usando Fetch API:
    fetch("/getActivities?date=" + activityDate)
    .then(response => response.json())
    .then(data => {
        console.log("Activities retrieved:", data);
        displayActivities(data);
    })
    .catch(error => {
        console.error("Error retrieving activities:", error);
    });
}

function displayActivities(activities) {
    const tableBody = document.getElementById("activityTableBody");
    tableBody.innerHTML = ""; // Limpiar la tabla antes de agregar nuevas filas

    activities.forEach(activity => {
        const newRow = document.createElement("tr");
        newRow.innerHTML = `
            <td>${activity.date}</td>
            <td>${activity.hora}</td>
            <td>${activity.name}</td>
            <td>${activity.corp}</td>
            <td>${activity.job}</td>
            <td>${activity.phone}</td>
            <td>${activity.email}</td>
        `;
        tableBody.appendChild(newRow);
    });
}


  document.getElementById('removeActivityForm').addEventListener('submit', function(event) {
    event.preventDefault();
    let removeActivityDate = document.getElementById('removeActivityDate').value;
    // Llamar a la función removeActivity en tu canister con la fecha de la actividad a eliminar
    // Ejemplo: 
    canister.removeActivity({ day: day, month: month, year: year, id: id });
  });


