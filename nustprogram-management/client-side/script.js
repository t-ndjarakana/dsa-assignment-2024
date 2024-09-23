const apiUrl = 'http://localhost:4000/programme';

// Fetch and display all programmes
function fetchProgrammes() {
    fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
            const tableBody = document.querySelector("#programmes-table tbody");
            tableBody.innerHTML = ''; // Clear existing rows
            data.forEach(programme => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${programme.code}</td>
                    <td>${programme.nqf_level}</td>
                    <td>${programme.fac}</td>
                    <td>${programme.qual_title}</td>
                    <td>${programme.reg_date}</td>
                    <td>${programme.courses.map(course => course.course_name).join(", ")}</td>
                    <td class="actions">
                        <button onclick="deleteProgramme('${programme.code}')">Delete</button>
                        <button onclick="loadProgrammeForUpdate('${programme.code}')">Update</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error('Error fetching programmes:', error));
}

// Add a new programme
document.getElementById('add-programme-form').addEventListener('submit', function(event) {
    event.preventDefault();
    
    const programme = {
        code: document.getElementById('code').value,
        nqf_level: document.getElementById('nqf_level').value,
        fac: document.getElementById('fac').value,
        qual_title: document.getElementById('qual_title').value,
        reg_date: document.getElementById('reg_date').value,
        courses: [
            {
                course_name: document.getElementById('course_name').value,
                course_code: document.getElementById('course_code').value,
                nqf_level: document.getElementById('course_nqf').value
            }
        ]
    };

    fetch(apiUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(programme)
    })
    .then(response => response.text())
    .then(data => {
        alert(data);
        fetchProgrammes(); // Refresh the list
    })
    .catch(error => console.error('Error adding programme:', error));
});

// Delete a programme
function deleteProgramme(code) {
    fetch(`${apiUrl}/delete/${code}`, { method: 'DELETE' })
        .then(response => response.text())
        .then(data => {
            alert(data);
            fetchProgrammes(); // Refresh the list
        })
        .catch(error => console.error('Error deleting programme:', error));
}

// Load programme data into the update form
function loadProgrammeForUpdate(code) {
    fetch(`${apiUrl}/code/${code}`)
        .then(response => response.json())
        .then(programme => {
            document.getElementById('update-code').value = programme.code;
            document.getElementById('update-nqf_level').value = programme.nqf_level;
            document.getElementById('update-fac').value = programme.fac;
            document.getElementById('update-qual_title').value = programme.qual_title;
            document.getElementById('update-reg_date').value = programme.reg_date;
        })
        .catch(error => console.error('Error fetching programme for update:', error));
}

// Update a programme
document.getElementById('update-programme-form').addEventListener('submit', function(event) {
    event.preventDefault();
    
    const code = document.getElementById('update-code').value;
    const programme = {
        code: code,
        nqf_level: document.getElementById('update-nqf_level').value,
        fac: document.getElementById('update-fac').value,
        qual_title: document.getElementById('update-qual_title').value,
        reg_date: document.getElementById('update-reg_date').value,
        courses: [] // Leave empty for simplicity
    };

    fetch(`${apiUrl}/${code}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(programme)
    })
    .then(response => response.text())
    .then(data => {
        alert(data);
        fetchProgrammes(); // Refresh the list
    })
    .catch(error => console.error('Error updating programme:', error));
});

// Fetch programmes on page load
fetchProgrammes();
