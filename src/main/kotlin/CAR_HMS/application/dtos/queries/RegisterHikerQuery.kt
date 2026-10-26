package CAR_HMS.application.dtos.queries

import java.time.LocalDate

data class RegisterHikerQuery(
    val invitationCode: String,
    val email: String,
    val password: String,
    val firstName: String,
    val lastName: String,
    val phoneNumber: String,
    val streetAddress: String,
    val city: String,
    val province: String,
    val postalCode: String,
    val dateOfBirth: LocalDate,
    val emergencyContactName: String,
    val emergencyContactPhone: String,
    val skillLevel: String,
    val waiverAccepted: Boolean,
    val guardianName: String?
)
