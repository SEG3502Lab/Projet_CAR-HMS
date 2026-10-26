package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.BrowseOpenHikesQuery
import CAR_HMS.application.dtos.queries.ListMatchingHikesQuery
import CAR_HMS.application.dtos.results.HikeSummary

interface BrowseHikes {
    fun browseOpenHikes(query: BrowseOpenHikesQuery): List<HikeSummary>
    fun listMatchingHikes(query: ListMatchingHikesQuery): List<HikeSummary>
}
