package com.adstream.automate.babylon.tests.performance;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;

import java.net.URL;
import java.util.*;

/**
 * User: ruslan.semerenko
 * Date: 30.09.13 16:24
 */
public class CreateProjectWithManyFoldersWorkflow extends Workflow {
    private Agency currentAgency;
    private Role agencyUserRole;
    private Role projectContributorRole;

    public CreateProjectWithManyFoldersWorkflow(URL baseUrl, URL coreUrl, String login, String password) {
        super(baseUrl, coreUrl, login, password);
    }

    @Override
    public WorkflowActionStats perform() {
        performAction("Open login page and log in", new WorkflowAction() {
            @Override
            public void prepare(Workflow workflow) {
                int createdProjectsCount = getProjectsCount();
                for (int i = 0; i < 100; i++) {
                    if (i < createdProjectsCount) {
                        continue;
                    }
                    String projectName = "Pr_" + i;
                    if (getCoreApi().getProjectByName(projectName, 0) == null) {
                        System.out.println("Create project #" + (i + 1));
                        Project project = getCoreApi().createProject(generateProject(projectName));
                        List<TeamPermission> permissions = createFolders(project.getId(), 5, 5, 5);
                        System.out.println("Share project");
                        getCoreApi().addUserToProjectTeam(permissions.toArray(new TeamPermission[permissions.size()]));
                    }
                }
                getCache().put("projectId", getCoreApi().getProjectByName("Pr_0").getId());
            }

            @Override
            public void perform(Workflow workflow) {
                getPageNavigator().getLoginPage().login(getLogin(), getPassword());
            }
        });

        performAction("Open project files page", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                getPageNavigator().getProjectFilesPage(getCache().get("projectId"), null);
            }
        });

        performAction("Open third level folder", new WorkflowAction() {
            @Override
            public void prepare(Workflow workflow) {
                List<Content> folders =
                        getCoreApi().findContent(getCache().get("projectId"), new LuceneSearchingParams()).getResult();
                FoldersTree foldersTree = FoldersTree.build(folders);
                Content folder = foldersTree.getSubFoldersTree().get(0)
                        .getSubFoldersTree().get(0)
                        .getSubFoldersTree().get(0).getFolder();
                getCache().put("folderId", folder.getId());
            }

            @Override
            public void perform(Workflow workflow) {
                getPageNavigator().getProjectFilesPage(getCache().get("projectId"), getCache().get("folderId"));
            }
        });

        performAction("Perform global search", new WorkflowAction() {
            @Override
            public void perform(Workflow workflow) {
                getPageNavigator().getProjectFilesPage().searchObject("Pr_");
            }
        });
        return getStats();
    }

    private List<TeamPermission> createFolders(String parentId, int... foldersOnLevel) {
        List<TeamPermission> permissions = new ArrayList<>();
        if (foldersOnLevel.length > 0) {
            for (int i = 0; i < foldersOnLevel[0]; i++) {
                User user = getCoreApi().createUser(generateUser(getCurrentAgency()));
                Content folder = getCoreApi().createFolder(parentId, Gen.getHumanReadableString(6, true));
                long expiration = System.currentTimeMillis() + 10 * 24 * 60 * 60 * 1000;
                TeamPermission permission =
                        new TeamPermission(folder.getId(), user.getId(), getProjectContributorRole().getId(), false, expiration);
                permissions.add(permission);
                permissions.addAll(createFolders(folder.getId(), Arrays.copyOfRange(foldersOnLevel, 1, foldersOnLevel.length)));
            }
        }
        return permissions;
    }

    private int getProjectsCount() {
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setQuery("_cm.common.name:Pr_*")
                .setResultsOnPage(100);
        return getCoreApi().findProjects(query).getResult().size();
    }

    private Agency getCurrentAgency() {
        if (currentAgency == null) {
            currentAgency = getCoreApi().getCurrentAgency();
        }
        return currentAgency;
    }

    private User generateUser(Agency agency) {
        User user = new User();
        user.setAgency(agency);
        user.setPhoneNumber("1234567890");
        user.setAdvertiser(agency.getId());
        user.setPassword("1");
        user.setFullAccess();
        user.setRoles(new BaseObject[] {getAgencyUserRole()});
        user.setFirstName(Gen.getHumanReadableString(6, true));
        user.setLastName(Gen.getHumanReadableString(6, true));
        user.setEmail(user.getFirstName().toLowerCase() + "." + user.getLastName().toLowerCase() + "@test.com");
        return user;
    }

    private Role getAgencyUserRole() {
        if (agencyUserRole == null) {
            agencyUserRole = getRole("agency.user");
        }
        return agencyUserRole;
    }

    private Role getProjectContributorRole() {
        if (projectContributorRole == null) {
            projectContributorRole = getRole("project.contributor");
        }
        return projectContributorRole;
    }

    private Role getRole(String roleName) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name:\"%s\"", roleName));
        return getCoreApi().findRoles(query).getResult().get(0);
    }

    private Project generateProject(String name) {
        Project project = new Project();
        project.setMediaType("Broadcast");
        project.setAdministrators(new String[0]);
        project.setSubtype("project");
        project.setLogo("");
        project.setDateStart(new DateTime());
        project.setDateEnd(new DateTime().plus(Period.days(1)));
        project.setName(name);
        project.setJobNumber(Gen.getHumanReadableString(8, true));
        return project;
    }
}

class FoldersTree {
    private Content folder;
    private List<FoldersTree> subFolders;

    public static FoldersTree build(List<Content> folders) {
        Map<String, List<Content>> foldersMap = new HashMap<>();
        String projectId = folders.get(0).getProject().getId();
        for (Content folder : folders) {
            String parentId = folder.getParents()[0];
            List<Content> subFolders = foldersMap.get(parentId);
            if (subFolders == null) {
                subFolders = new ArrayList<>();
                foldersMap.put(parentId, subFolders);
            }
            subFolders.add(folder);
        }
        FoldersTree tree = new FoldersTree();
        tree.setSubFoldersTree(buildTree(foldersMap, projectId));
        return tree;
    }

    private static List<FoldersTree> buildTree(Map<String, List<Content>> foldersMap, String parentFolderId) {
        List<Content> subFolders = foldersMap.get(parentFolderId);
        List<FoldersTree> subFoldersTree = new ArrayList<>();
        if (subFolders != null) {
            for (Content subFolder : subFolders) {
                FoldersTree subTree = new FoldersTree();
                subTree.setFolder(subFolder);
                subTree.setSubFoldersTree(buildTree(foldersMap, subFolder.getId()));
                subFoldersTree.add(subTree);
            }
            return subFoldersTree;
        }
        return null;
    }

    public Content getFolder() {
        return folder;
    }

    public void setFolder(Content folder) {
        this.folder = folder;
    }

    public List<FoldersTree> getSubFoldersTree() {
        return subFolders;
    }

    public void setSubFoldersTree(List<FoldersTree> subFolders) {
        this.subFolders = subFolders;
    }
}
