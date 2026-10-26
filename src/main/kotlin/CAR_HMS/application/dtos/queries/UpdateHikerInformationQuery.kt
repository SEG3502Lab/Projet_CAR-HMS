package CAR_HMS.application.dtos.queries

data class UpdateHikerInformationQuery(
    val hikerEmail: String,
    val firstName: String,
    val lastName: String,
    val phoneNumber: String,
    val streetAddress: String,
    val city: String,
    val province: String,
    val postalCode: String,
    val emergencyContactName: String,
    val emergencyContactPhone: String,
    val skillLevel: String
)
