package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.CancelSignUpQuery

interface CancelSignUp {
    fun cancelSignUp(query: CancelSignUpQuery)
}
