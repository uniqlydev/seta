/**
 * The function `redirectToPatientPrescriptions` redirects the user to a page displaying prescriptions
 * for a specific patient identified by their unique ID.
 * @param uid - The `uid` parameter in the `redirectToPatientPrescriptions` function is typically used
 * to represent the unique identifier of a patient. This identifier is used to fetch the prescriptions
 * specific to that patient when redirecting to the prescriptions page.
 */
function redirectToPatientPrescriptions(uid) {
    window.location.href = `/prescriptions?uid=${uid}`;
}
