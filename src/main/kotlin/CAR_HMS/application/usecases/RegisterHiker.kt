package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.RegisterHikerQuery

interface RegisterHiker {
    fun registerHiker(query: RegisterHikerQuery): String
}
