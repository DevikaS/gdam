package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNFileRegister;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNFileWrapper;
import com.adstream.automate.babylon.JsonObjects.ordering.Destination;
import com.adstream.automate.babylon.JsonObjects.ordering.Market;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.ServiceLevel;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.UploadListener;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.IO;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: ruslan.semerenko
 * Date: 17.07.12 11:50
 */
public abstract class AbstractPerformanceTestServiceWrapper extends AbstractPerformanceTest {
    private static AtomicInteger uploadedFilesCount = new AtomicInteger(0);
    private static Map<String, Role> rolesByName = new ConcurrentHashMap<>();
    private static Map<String, Role> rolesById = new ConcurrentHashMap<>();
    private Agency currentAgency;
    private User currentUser;
    private FileStorage currentFileStorage;
    protected static String myAssetsId;

    public static int getUploadedFilesCount() {
        return uploadedFilesCount.get();
    }

    protected User getCurrentUser() {
        if (currentUser == null) {
            currentUser = getService().getCurrentUser();
        }
        return currentUser;
    }

    protected Agency getCurrentAgency() {
        if (currentAgency == null) {
            currentAgency = getService().getCurrentAgency();
        }
        return currentAgency;
    }

    protected FileStorage getCurrentFileStorage() {
        if (currentFileStorage == null) {
            String storageId = getCurrentAgency().getStorageId();
            List<FileStorage> storages = getService().getGdnStorages().getResult();
            for (FileStorage storage : storages) {
                if (storage.getFileStorageId().equals(storageId)) {
                    currentFileStorage = storage;
                    break;
                }
            }
        }
        return currentFileStorage;
    }

    protected Role getRoleByName(String roleName) {
        if (rolesByName.isEmpty()) {
            initDefaultRoles();
        }
        if (rolesByName.get(roleName) != null) {
            return rolesByName.get(roleName);
        }
        for (Role role : getService().findRoles(new LuceneSearchingParams()).getResult()) {
            if (role.getName().equals(roleName)) {
                rolesByName.put(roleName, role);
                rolesById.put(role.getId(), role);
                return role;
            }
        }
        return null;
    }

    protected Role getRoleById(String roleId) {
        if (rolesById.isEmpty()) {
            initDefaultRoles();
        }
        if (rolesById.get(roleId) != null) {
            return (rolesById.get(roleId));
        }
        for (Role role : getService().findRoles(new LuceneSearchingParams()).getResult()) {
            if (role.getId().equals(roleId)) {
                rolesByName.put(role.getName(), role);
                rolesById.put(role.getId(), role);
                return role;
            }
        }
        return null;
    }

    private void initDefaultRoles() {
        Map<String, String> defaultRoles = new HashMap<>();
        defaultRoles.put("4ef31ce1766ec96769b399c1", "global.administrators");
        defaultRoles.put("4f6acc74dff0676e018e6dcc", "agency.admin");
        defaultRoles.put("4f6acc74dff0676e018e6dcf", "agency.user");
        defaultRoles.put("4fba0ec37fec91f70b5a0917", "guest.user");
        defaultRoles.put("4f719aed0f915e82984dc84e", "project.admin");
        defaultRoles.put("506f0ff7e4b088f04d9d794a", "project.user");
        defaultRoles.put("509a93c29e02c7ba9d977f28", "project.observer");
        defaultRoles.put("509a93c29e02c7ba9d977f25", "project.contributor");
        defaultRoles.put("5059aa1ffbc55596d01a3da4", "approver");
        defaultRoles.put("512cef304caf8dda81c0fc8d", "library.admin");
        defaultRoles.put("512cef324caf8dda81c0fc8f", "library.user");
        defaultRoles.put("4f62d03c454adbaef94258cf", "agency.list");
        defaultRoles.put("4f71ac9a0f915e82984dc8de", "agency.enums.read");
        defaultRoles.put("4f71ac9b0f915e82984dc8e4", "agency.enums.write");
        defaultRoles.put("4f7045390f915e82984dc716", "agency.default.roles");
        defaultRoles.put("50254292fbc5101ae5785db1", "agency.reel.create.role");
        defaultRoles.put("50254292fbc5101ae5785db2", "agency.asset.share.role");
        defaultRoles.put("50253ce2fbc58f931c54d2d3", "agency.reel.read.role");
        defaultRoles.put("501638c2db016b1bf9952aba", "agency.category.read_write.role");
        defaultRoles.put("50056001db016b1bf995257e", "agency.category.read.role");
        defaultRoles.put("505c9504e4b04e7fe746c6ed", "agency.project.read.role");
        defaultRoles.put("52303a47fb49916fdf3aac51", "easyshare.view");
        defaultRoles.put("52303a47fb49916fdf3aac52", "easyshare.downloadMaster");
        defaultRoles.put("52303a47fb49916fdf3aac53", "easyshare.downloadProxy");

        for (Role role : getService().findRoles(new LuceneSearchingParams()).getResult()) {
            String roleName = defaultRoles.get(role.getId());
            if (roleName != null) {
                rolesById.put(role.getId(), role);
                rolesByName.put(roleName, role);
            }
        }
    }

    protected String logIn(String login, String password) {
        String userId;
        if (getParamBoolean("useSSO"))
            userId = getService().authSSO(login, password);
        else
            userId = getService().auth(login, password);
        if (userId == null) fail("Can not authorize");
        if (isCoreService()) {
            currentAgency = getService().getCurrentAgency();
            currentUser = getService().getCurrentUser();
            getService().getCurrentUser();
            getService().getCurrentAgency();
        }
        return userId;
    }

    public Content getProjectRootFolder(String projectId) {
        if (isCoreService()) {
            SearchResult<Content> result = getService().findContent(projectId, new LuceneSearchingParams().setQuery("_parents.$id:" + projectId));
            if (result.getResult().size() > 0) {
                return result.getResult().get(0);
            }
        } else {
            Project project = getService().getProject(projectId);
            List<Content> result = ((BabylonMiddlewareService) getService()).getProjectFolders(projectId, projectId);
            for (Content folder : result) {
                if (folder.getName().equals(project.getName())) {
                    return folder;
                }
            }
        }
        return null;
    }

    public Content uploadFile(File file, String folderId) {
        return uploadFileToGDN(file, folderId);
    }

    public Content uploadFileToGDN(File file, String folderId) {
        return uploadFileToGDN(file, folderId, null);
    }

    public Content uploadFileToGDN(File file, String folderId, UploadListener uploadListener) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerGDNContent(folderId, gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        HashMap<String, String> uploadResult = prepareFileToUploadToGDN(gdnFileWrapper, postURI, uploadListener);
        Content content = createContentGDN(folderId, file.getName(), gdnFileId);
        if (uploadListener != null)
            uploadListener.uploadComplete(uploadResult.get("targetFileName"), content.getId());
        return content;
    }

    public Content uploadAsset(File file) {
        return uploadAssetToGDN(file, null);
    }

    public Content uploadAssetToGDN(File file, UploadListener uploadListener) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerGDNAsset(gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        HashMap<String, String> uploadResult = prepareFileToUploadToGDN(gdnFileWrapper, postURI, uploadListener);
        Content content = createAssetGDN(file.getName(), gdnFileId);
        if (uploadListener != null)
            uploadListener.uploadComplete(uploadResult.get("targetFileName"), content.getId());
        return content;
    }

    public GDNFileRegister registerGDNAsset(GDNFileWrapper gdnFileWrapper) {
        return getService().registerGDNAssets(Arrays.asList(gdnFileWrapper));
    }

    public Content createAssetGDN(String fileName, String gdnFileId) {
        Content content = new Content();
        //content.setId(fileName);
        content.setName(fileName);
        return getService().createAssetGDN(content, gdnFileId);
    }

    public GDNFileRegister registerGDNContent(String parentId, GDNFileWrapper gdnFileWrapper) {
        return getService().registerGDNContent(parentId, Arrays.asList(gdnFileWrapper));
    }

    public Content createContentGDN(String folderId, String fileName, String gdnFileId) {
        Content content = new Content();
        content.setSubtype("element");
        content.setName(fileName);
        return getService().createContentGDN(folderId, content, gdnFileId);
    }

    // emulate JumpLoader ( Adgate support both: JumpLoader and PlupLoader)
    public HashMap<String, String> prepareFileToUploadToGDN(GDNFileWrapper fileWrapper, String postURI, UploadListener uploadListener) {
        File file = fileWrapper.getFile();
        if (!file.exists())
            throw new IllegalArgumentException(String.format("File %s does not exist", file.toString()));

        HashMap<String, String> result = new HashMap<>();

        long fileLength = file.length();
        String fileName = file.getName();
        String fileExtension = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : "";
        String targetFileName = fileWrapper.getExternalId() + fileExtension;
        String lastModified = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").format(new Date(file.lastModified()));

        CloseableHttpClient client = HttpClients.createDefault();
        final int chunkLength = 10485760;
        int bytesToSend;
        int chunksCount = (int) (fileLength / chunkLength) + 1;
        int fileId = Gen.getInt(10000000, 99999999);
        long totalTime = 0;
        for (int i = 0; i < chunksCount; i++) {
            int bytesUploaded = i * chunkLength;
            bytesToSend = i < chunksCount - 1 ? chunkLength : (int) (fileLength - bytesUploaded);
            byte[] bytes = IO.readFile(file, bytesUploaded, bytesToSend);
            HttpPost request = new HttpPost(postURI);
            MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
            entityBuilder.addTextBody("partitionIndex", "" + i);
            entityBuilder.addTextBody("targetFileName", targetFileName);
            entityBuilder.addTextBody("fileId", "" + fileId);
            entityBuilder.addTextBody("partitionLength", "" + chunkLength);
            entityBuilder.addTextBody("lastModified", lastModified);
            entityBuilder.addTextBody("fileLength", "" + fileLength);
            entityBuilder.addTextBody("fileName", fileName);
            entityBuilder.addTextBody("partitionCount", "" + chunksCount);
            entityBuilder.addBinaryBody("file", bytes, ContentType.APPLICATION_OCTET_STREAM, fileName);
            request.setHeader("Authorization", "Basic YWxleEB1bml0LnR2LnVhOjE=");
            request.setEntity(entityBuilder.build());
            try {
                long start = System.currentTimeMillis();
                HttpResponse response = client.execute(request);
                if (response.getStatusLine().getStatusCode() != 200) {
                    System.out.println("File upload request: " + request.getURI());
                    System.out.println("File upload response: " + response.getStatusLine().getStatusCode());
                    System.out.println(EntityUtils.toString(response.getEntity()));
                    throw new IllegalStateException("File not uploaded");
                } else {
                    long time = System.currentTimeMillis() - start;
                    EntityUtils.consume(response.getEntity());
                    totalTime += time;
                    if (uploadListener != null)
                        uploadListener.chunkUploadComplete(bytesUploaded + bytesToSend, fileLength, bytesToSend, time, totalTime, targetFileName);
                }
            } catch (IOException e) {
                throw new IllegalStateException("File not uploaded", e);
            }
        }
        result.put("targetFileName", targetFileName);
        uploadedFilesCount.incrementAndGet();
        return result;
    }

    protected String getAssetsCategoryId(String filterName) {
        if (myAssetsId == null) {
            AssetFilters filters = getService().getAssetFilters();
            for (AssetFilter filter : filters.getFilters())
                if (filter.getName().equals(filterName)) {
                    myAssetsId = filter.getId();
                    break;
                }
        }
        return myAssetsId;
    }

    protected String getMyAssetsCategoryId() {
        return getAssetsCategoryId("My Assets");
    }

    protected String getEverythingCategoryId() {
        return getAssetsCategoryId("Everything");
    }

    /*
    ORDERING
     */

    protected Order prepareOrder() {
        Order order = new Order();
        order.setSubtype(getParam("orderType"));
        return order;
    }

    public List<Market> getTvMarkets() {
        return getService().getTvMarkets().getValues();
    }

    public Market getTvMarketByName(String name) {
        for (Market market : getTvMarkets())
            if (market.getName().equals(name))
                return market;
        throw new IllegalArgumentException("There is no following market :" + name);
    }

    protected Destination getDestinationByName(List<Destination> destinations, String name) {
        for (Destination destination : destinations)
            if (destination.getName().equals(name))
                return destination;
        throw new IllegalArgumentException("There is no following destination: " + name);
    }

    protected ServiceLevel getDestinationServiceLevelByName(Destination destination, String serviceLevelName) {
        if (destination == null) throw new NullPointerException("Destination is not exist!");
        for (ServiceLevel serviceLevel : destination.getServiceLevelValues())
            if (serviceLevel.getName().equals(serviceLevelName))
                return serviceLevel;
        throw new IllegalArgumentException("There is no service level with name: " + serviceLevelName + " for destination: " + destination.getName());
    }
}