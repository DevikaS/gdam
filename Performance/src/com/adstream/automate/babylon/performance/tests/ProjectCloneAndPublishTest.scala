package com.adstream.automate.babylon.performance.tests

import com.adstream.automate.babylon.JsonObjects._
import com.adstream.automate.babylon.LuceneSearchingParams
import com.adstream.automate.utils.Gen
import org.joda.time.{Period, DateTime}

class ProjectCloneAndPublishTest extends AbstractPerformanceTestServiceWrapper {
  private val FolderTeamUsersCount = 30
  private val FoldersCount = 15

  import ProjectCloneAndPublishTest._

  def runOnce {
    folderPrefix = Gen.getHumanReadableString(6, false)

    loginAndFetchAdminRoleWithAgency

    log.info("Preparing template")

    projectTemplate = getService.createProject(createProjectDescription("project_template"))
    assert(projectTemplate != null, "Could not create project")

    val rootFolder: Content = getService.createContent(projectTemplate.getId, createFolderDescription(projectTemplate.getId))

    1.to(FoldersCount).map { i =>
      val folder: Content = getService.createContent(rootFolder.getId, createFolderDescription(projectTemplate.getId))
      folders ::= folder
      log.info(s"Sharing ${i}th folder id: ${folder.getId}")
      getService.addUserToProjectTeam(folder.getId, createFolderTeam(folder.getId))
    }
  }

 private def loginAndFetchAdminRoleWithAgency {
    logIn(getParam("login"), getParam("password"))
    getCurrentAgency
    getProjectUserRole
  }

  private def createFolderDescription(projectId: String): Content = {
    val content: Content = new Content
    content.setProject(new Identity(projectId, null))
    content.setName(folderPrefix + "_" + Gen.getHumanReadableString(6, true))
    content.setSubtype("folder")
    return content
  }

  def beforeStart {
  }

  def start {
    loginAndFetchAdminRoleWithAgency

    log.info("Cloning template")
    val projectName = Gen.getHumanReadableString(10, true);
    getService.createProjectFromTemplate(projectTemplate.getId,
                                         projectName,
                                         Array[String]("Broadcast"),
                                         projectTemplate.getDateStart,
                                         projectTemplate.getDateEnd,
                                         true,
                                         true,
                                         false)

    log.info("Publishing cloned project")
    val query = new LuceneSearchingParams().setQuery(String.format("_cm.common.name.untouched:\"%s\"", projectName))
    val projectId = getService.findProjects(query).getResult.get(0).getId
    getService.publishProject(projectId, true, true)

    log.info("Pausing after cloning and publishing")

    Thread.sleep(60000)

    log.info("Starting user access verification")

    var i = 1
    users.foreach { user =>
      logIn(user.getEmail, getParam("password"))
      log.info(s"Checking access for ${i}th user email: ${user.getEmail}")
      val foundFolders = getService.findContentAllProjects(new LuceneSearchingParams().setQuery(s"${folderPrefix}*")).getResult
      assert(foundFolders.size != 0, s"User ${user.getEmail} does not see any folders")
      i += 1
    }

    loginAndFetchAdminRoleWithAgency
  }

  def afterRun {
  }

  private def createProjectDescription(subtype: String): Project = {
    val project: Project = new Project
    project.setMediaType("Broadcast")
    project.setAdministrators(new Array[String](0))
    project.setSubtype(subtype)
    project.setLogo("")
    project.setDateStart(new DateTime)
    project.setDateEnd(new DateTime().plus(Period.days(1)))
    project.setName(Gen.getHumanReadableString(8, true))
    project.setJobNumber(Gen.getHumanReadableString(8, true))
    return project
  }

  private def createFolderTeam(projectOrFolderId: String): Array[TeamPermission] = {
    createTeamUsers().map(u => createTeamPermission(projectOrFolderId, u.getEmail)).toArray
  }

  private def createTeamPermission(projectOrFolderId: String, userId: String): TeamPermission = {
    return new TeamPermission(projectOrFolderId, userId, getProjectUserRole.getId, false, null)
  }

  private def getProjectUserRole: Role = {
    val role = getRoleByName("Project User")
    return role
  }

  private def createTeamUsers(): List[User] = {
     1.to(FolderTeamUsersCount).map{ i =>
       val email = s"user${Gen.getHumanReadableString(6, true)}_$i@test.com"
       createTeamUser(email)
     }.toList
  }

  private def createTeamUser(email: String): User = {
    val user = new User
    user.setAgency(getCurrentAgency)
    user.setPhoneNumber("1234567890")
    user.setAdvertiser(getCurrentAgency.getId)
    user.setPassword("abcdefghA1")
    user.setAccess()
    user.setRoles(Array[BaseObject](getGuestRole))
    user.setFirstName(Gen.getHumanReadableString(6, true))
    user.setLastName(Gen.getHumanReadableString(6, true))
    user.setEmail(email.toLowerCase)
    getService.createUser(user.getAgency.getId, user)
    users ::= user
    user
  }

  private def getGuestRole: Role = {
    return getRoleById("4fba0ec37fec91f70b5a0917")
  }
}

object ProjectCloneAndPublishTest {
  private var projectTemplate: Project = _
  private var folders : List[Content] = List()
  private var users : List[User] = List()
  private var folderPrefix : String = _
}