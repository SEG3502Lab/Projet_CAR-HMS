package CAR_HMS.application.dtos.queries

import java.time.LocalDate

data class RecordOrganizerCertificationQuery(
    val adminEmail: String,
    val hikerEmail: String,
    val certificateNumber: String,
    val issueDate: LocalDate,
    val expiryDate: LocalDate,
    val organizerLevel: String
)
