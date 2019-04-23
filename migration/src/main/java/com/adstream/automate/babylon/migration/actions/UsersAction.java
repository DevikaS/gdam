package com.adstream.automate.babylon.migration.actions;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.usagerights.UsageRight;
import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.babylon.migration.objects.User;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/11/13
 * Time: 9:29 AM

 */

public class UsersAction {
    private User currentUser;
    private List<Project> projects;
    private Project project;
    private Content folder;
    private String folderName;
    private File file;
    private List<Asset> assetFromXML;
    private Asset oneAssetFromXML;
    private List<UsageRight> usageRight;
    private boolean isAdmin = true;
    private String advertiser;
    private List<User> allAgencyUsers;


    public Content getContentAfterCreateFolder(Project projectApp) {
        folder = new CreateFolder().addNewFolder(projectApp);
        return folder;
    }

    public User getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }

    public List<Project> getProjects() {
        return projects;
    }

    public void addProject(Project project) {
        if (projects == null)
            projects = new ArrayList<Project>();
        projects.add(project);
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public Content getFolder() {
        return folder;
    }

    public void setFolder(Content folder) {
        this.folder = folder;
    }

    public String getFolderName() {
        return folderName;
    }

    public void setFolderName(String folderName) {
        this.folderName = folderName;
    }

    public File getFile() {
        return file;
    }

    public static File[] getAllFilesFromDir(File folder) {
        File myFolder = new File(folder.getAbsolutePath());
        return myFolder.listFiles();
    }

    public void setFile(File file) {
        this.file = file;
    }

    public void setFile() {
        try {
            file = File.createTempFile(Gen.getString(10), Gen.getString(3));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void setFile(String filePath) {
        file = new File(filePath);
        File current_directory = new File(System.getProperty("user.dir"));
        System.out.println();
    }

    public List<Asset> getAssetFromXML() {
        return assetFromXML;
    }

    public void setAssetFromXML(List<Asset> assetFromXML) {
        this.assetFromXML = assetFromXML;
    }

    public void addAssetFromXML(Asset asset) {
        if (assetFromXML == null) {
            assetFromXML = new ArrayList<Asset>();
        }
        assetFromXML.add(asset);
    }

    public Asset getOneAssetFromXML() {
        return oneAssetFromXML;
    }

    public void setOneAssetFromXML(Asset onrAssetFromXML) {
        this.oneAssetFromXML = onrAssetFromXML;
    }

    public List<UsageRight> getUsageRight() {
        return usageRight;
    }

    public void addUsageRight(UsageRight usageRight) {
        if (this.usageRight == null)
            this.usageRight = new ArrayList<UsageRight>();
        this.usageRight.add(usageRight);
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public String getAdvertiser() {
        return advertiser;
    }

    public void setAdvertiser(String advertiser) {
        this.advertiser = advertiser;
    }

    public List<User> getAllAgencyUsers() {
        return allAgencyUsers;
    }

    public void setAllAgencyUsers(List<User> allAgencyUsers) {
        this.allAgencyUsers = allAgencyUsers;
    }
}
