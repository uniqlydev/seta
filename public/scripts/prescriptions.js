async function updatePrescriptionClaimedStatus(prescriptionId, claimed) {
    try {
        const response = await fetch('/update-status', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ prescriptionId, claimed }),
        });

        const data = await response.json();

        if (response.ok) {
            window.location.reload();
        } else {
            alert(data.message);
        }
    } catch (error) {
        console.error(error);
    }
}