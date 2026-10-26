package CAR_HMS.application.dtos.queries

import java.time.Duration
import java.time.LocalDateTime

data class CreateHikeQuery(
    val organizerEmail: String,
    val title: String,
    val description: String,
    val trailId: String,
    val startDateTime: LocalDateTime,
    val expectedDuration: Duration,
    val registrationDeadline: LocalDateTime,
    val capacity: Int
)
