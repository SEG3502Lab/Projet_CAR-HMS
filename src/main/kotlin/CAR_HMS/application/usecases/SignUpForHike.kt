package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.SignUpForHikeQuery

interface SignUpForHike {
    fun signUpForHike(query: SignUpForHikeQuery): String
}
