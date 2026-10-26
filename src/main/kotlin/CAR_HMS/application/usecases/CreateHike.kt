package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.CreateHikeQuery

interface CreateHike {
    fun createHike(query: CreateHikeQuery): String
}
