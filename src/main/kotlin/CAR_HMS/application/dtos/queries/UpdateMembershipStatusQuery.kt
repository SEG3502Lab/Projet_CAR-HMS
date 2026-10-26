package CAR_HMS.application.dtos.queries

data class UpdateMembershipStatusQuery(
    val adminEmail: String,
    val hikerEmail: String,
    val newStatus: String
)
