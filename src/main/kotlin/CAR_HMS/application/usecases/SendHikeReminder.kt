package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.SendHikeReminderQuery

interface SendHikeReminder {
    fun sendHikeReminder(query: SendHikeReminderQuery)
}
