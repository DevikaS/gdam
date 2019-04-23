package com.adstream.automate.babylon
package performance.tests.schema

import com.adstream.automate.babylon.JsonObjects.{Agency, User}
import com.adstream.automate.babylon.JsonObjects.schema.{AssetElementCommonSchema, AssetElementProjectCommonSchema, AssetSchema}
import com.adstream.automate.babylon.performance.tests.{AbstractPerformanceTestServiceWrapper, AgencyHelper}

import scala.collection.JavaConversions._

class UpdateSchemaTest extends AbstractPerformanceTestServiceWrapper with AgencyHelper {

  private var defaultAgency: Agency = _

  override def runOnce(): Unit = {}

  override def beforeStart(): Unit = {
    log.info("Login as global admin...")
    logIn(getParam("login"), getParam("password"))

    log.info("Creating agency...")
    defaultAgency = getService.createAgency(generateAgency)



    log.info("Creating user has access to ordering...")
    val user: User = getService.createUser(defaultAgency.getId, generateUser)

    log.info("Login to system by: " + user.getEmail)
    logIn(user.getEmail, defaultPassword)
  }

  override def afterRun(): Unit = {

  }

  override def start(): Unit = {
    getService.updateAssetElementProjectCommonSchema(defaultAgency.getId, generateAssetElementProjectCommonSchemaFields(defaultAgency.getId))
    getService.updateAssetElementCommonSchema(defaultAgency.getId, generateAssetElementCommonSchemaFields(defaultAgency.getId))
    getService.updateAssetSchema(defaultAgency.getId, generateAssetSchemaFields(defaultAgency.getId))
  }

  protected def generateAssetElementProjectCommonSchemaFields(agencyId: String): AssetElementProjectCommonSchema = {
    val schema: AssetElementProjectCommonSchema = getService.getAssetElementProjectCommonSchema(agencyId)
    val properties = collection.mutable.Map(
      "FieldSize" -> "Full",
      "Hidden" -> "false",
      "Compulsory" -> "false",
      "Description" -> "customField",
      "Schema" -> "common",
      "SchemaName" -> s"asset_element_project_common.agency.$agencyId",
      "FieldType" -> "string",
      "FieldId" -> s"customField_${System.currentTimeMillis}"
    )

    schema.createCMField(properties)

    schema
  }

  protected def generateAssetElementCommonSchemaFields(agencyId: String): AssetElementCommonSchema = {
    val schema: AssetElementCommonSchema = getService.getAssetElementCommonSchema(agencyId)
    val properties = collection.mutable.Map(
      "FieldSize" -> "Full",
      "Hidden" -> "false",
      "Compulsory" -> "false",
      "Description" -> "customField",
      "Schema" -> "common",
      "Section" -> "audio",
      "SchemaName" -> s"asset_element_common.agency.$agencyId",
      "FieldType" -> "string",
      "FieldId" -> s"customField_${System.currentTimeMillis}"
    )

    schema.createCMField(properties)

    schema
  }

  protected def generateAssetSchemaFields(agencyId: String): AssetSchema = {
    val schema: AssetSchema = getService.getAssetSchema(agencyId)
    val properties = collection.mutable.Map(
      "FieldSize" -> "Full",
      "Hidden" -> "false",
      "Compulsory" -> "false",
      "Description" -> "customField",
      "Schema" -> "common",
      "Section" -> "audio,video,print,document,digital,image,other",
      "SchemaName" -> s"asset.agency.$agencyId",
      "FieldType" -> "string",
      "FieldId" -> s"customField_${System.currentTimeMillis}"
    )

    schema.createFieldGroup(properties)

    schema
  }
}
