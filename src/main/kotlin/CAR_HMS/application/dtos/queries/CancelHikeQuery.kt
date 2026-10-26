package CAR_HMS.application.dtos.queries

data class CancelHikeQuery(
    val hikeId: String,
    val requesterEmail: String,
    val reason: String
)
