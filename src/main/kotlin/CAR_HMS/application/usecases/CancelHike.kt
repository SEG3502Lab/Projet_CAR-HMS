package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.CancelHikeQuery

interface CancelHike {
    fun cancelHike(query: CancelHikeQuery)
}
