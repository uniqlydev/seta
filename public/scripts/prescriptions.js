/**
 * The function `updatePrescriptionClaimedStatus` sends a POST request to update the claimed status of
 * a prescription and reloads the page upon success or displays an alert with an error message if the
 * request fails.
 * @param prescriptionId - Prescription ID is a unique identifier for a specific prescription in the
 * system. It is used to distinguish one prescription from another and is typically assigned when a
 * prescription is created or stored in a database.
 * @param claimed - The `claimed` parameter in the `updatePrescriptionClaimedStatus` function is a
 * boolean value that indicates whether a prescription has been claimed or not. When calling this
 * function, you would pass `true` if the prescription has been claimed and `false` if it has not been
 * claimed.
 */
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