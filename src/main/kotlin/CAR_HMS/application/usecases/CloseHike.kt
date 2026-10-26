package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.CloseHikeQuery

interface CloseHike {
    fun closeHike(query: CloseHikeQuery)
}
