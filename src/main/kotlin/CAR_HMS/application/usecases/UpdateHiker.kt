package CAR_HMS.application.usecases

import CAR_HMS.application.dtos.queries.RecordOrganizerCertificationQuery
import CAR_HMS.application.dtos.queries.UpdateHikerInformationQuery
import CAR_HMS.application.dtos.queries.UpdateMembershipStatusQuery

interface UpdateHiker {
    fun updateHikerInformation(query: UpdateHikerInformationQuery)
    fun updateMembershipStatus(query: UpdateMembershipStatusQuery)
    fun recordOrganizerCertification(query: RecordOrganizerCertificationQuery)
}
