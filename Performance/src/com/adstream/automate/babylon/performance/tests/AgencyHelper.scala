package com.adstream.automate.babylon
package performance.tests

import com.adstream.automate.babylon.JsonObjects.{Agency, BaseObject, User}
import com.adstream.automate.utils.Gen

trait AgencyHelper {
  self: AbstractPerformanceTestServiceWrapper =>

  lazy val _defaultUser = {
    val defaultUser = new User
    defaultUser.setPhoneNumber("1234567890")
    defaultUser.setPassword(defaultPassword)
    defaultUser.setAccess()
    defaultUser.setRoles(Array[BaseObject](getRoleByName("agency.admin")))
    defaultUser
  }

  lazy val _defaultAgency = {
    val defaultAgency = new Agency
    defaultAgency.setTimeZone("Europe-Andorra")
    defaultAgency.setPin("1")
    defaultAgency.setAgencyType("Advertiser")
    defaultAgency.setCountry("AF")
    defaultAgency.setStorageId(getParam("storageId"))
    defaultAgency
  }

  protected def generateUser: User = {
    _defaultUser.setFirstName(Gen.getHumanReadableString(6, true))
    _defaultUser.setLastName(Gen.getHumanReadableString(6, true))
    _defaultUser.setEmail((_defaultUser.getFirstName + "." + _defaultUser.getLastName + "@test.com").toLowerCase)
    _defaultUser.setRoles(Array(getService.getRole(AGENCY_ADMIN_ROLE_ID)));
    log.info(_defaultUser.getEmail)

    _defaultUser
  }

  protected def generateAgency: Agency = {
    _defaultAgency.setName(Gen.getHumanReadableString(6, true) + " Agency")
    _defaultAgency
  }

  @inline def defaultPassword = AgencyHelper.defaultPassword
  @inline def AGENCY_ADMIN_ROLE_ID = AgencyHelper.AGENCY_ADMIN_ROLE_ID
}

object AgencyHelper {
  final val defaultPassword: String = "abcdefghA1"
  private final val AGENCY_ADMIN_ROLE_ID: String = "4f6acc74dff0676e018e6dcc"
}
