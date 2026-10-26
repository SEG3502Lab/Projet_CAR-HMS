package CAR_HMS.application.dtos.queries

import java.time.LocalDate

data class BrowseOpenHikesQuery(
    val trailName: String?,
    val date: LocalDate?,
    val difficulty: String?
)
