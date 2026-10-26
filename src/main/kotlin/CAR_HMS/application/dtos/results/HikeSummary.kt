package CAR_HMS.application.dtos.results

import java.time.LocalDateTime

data class HikeSummary(
    val hikeId: String,
    val title: String,
    val trailName: String,
    val difficulty: String,
    val startDateTime: LocalDateTime,
    val status: String,
    val remainingSpots: Int
)
