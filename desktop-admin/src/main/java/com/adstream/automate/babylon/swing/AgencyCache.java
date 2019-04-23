package com.adstream.automate.babylon.swing;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryItem;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.BabylonCoreService;
import org.apache.log4j.Logger;

import java.util.*;


/**
 * User: ruslan.semerenko
 * Date: 24.11.12 15:44
 */
public class AgencyCache {
    public static final String AGENCY_ADMIN_ROLE_ID = "4f6acc74dff0676e018e6dcc";

    private Logger log  = Logger.getLogger(this.getClass());
    private Environment environment;
    private BabylonServiceWrapper service;
    private Map<String, Agency> agenciesMap;
    private Map<String, Agency> agenciesNameMap;
    private Map<String, List<User>> usersMap = new HashMap<>();
    private Map<String, User> agencyAdminsMap = new HashMap<>();
    private Map<String, List<Content>> assetsMap = new HashMap<>();
    private Map<String, List<Role>> rolesMap = new HashMap<>();
    private List<FileStorage> storages;
    private Map<String, String> countries;
    private Map<String, String> countryCodes;
    private List<String> timeZoneNames;
    private List<String> organisationTypes;
    private Map<String, Role> defaultRoles;

    public AgencyCache(Environment environment, BabylonServiceWrapper service) {
        this.environment = environment;
        this.service = service;
    }

    public Map<String, Agency> getAgenciesMap() {
        if (agenciesMap == null) {
            agenciesMap = new HashMap<>();
            agenciesNameMap = new HashMap<>();
            log.info("Get agencies from core");
            List<Agency> agencies = service.getWrappedService().getAgenciesSimple();
            for (Agency agency : agencies) {
                agenciesMap.put(agency.getId(), agency);
                agenciesNameMap.put(agency.getName(), agency);
            }
        }
        return agenciesMap;
    }

    public Agency[] getAgencies() {
        Collection<Agency> col = getAgenciesMap().values();
        Agency[] agencies = col.toArray(new Agency[col.size()]);
        sortGroupsArray(agencies);
        return agencies;
    }

    public Agency getAgencyById(String agencyId) {
        if (agencyId == null) {
            return null;
        }
        Agency agency = agenciesMap.get(agencyId);
        if (agency.getCreated() == null) {
            agency = service.getAgencyById(agencyId);
            agenciesMap.put(agencyId, agency);
            agenciesNameMap.put(agency.getName(), agency);
        }
        return agency;
    }

    public Agency getAgencyByName(String name) {
        return agenciesNameMap.get(name);
    }

    public void clearAgenciesCache() {
        log.info("Clear agencies cache");
        agenciesMap = null;
        agenciesNameMap = null;
    }

    public List<User> getUsers(String agencyId) {
        if (!usersMap.containsKey(agencyId)) {
            log.info("Get users from core");
            LuceneSearchingParams query = new LuceneSearchingParams()
                    .setQuery("agency._id:" + agencyId)
                    .setSortingField("_cm.common.email.untouched")
                    .setResultsOnPage(1000);
            SearchResult<User> users = service.getWrappedService().findUsers(query);
            log.info(String.format("Got %d users. Has more: %s", users.getResult().size(), users.hasMore()));
            Map<String, User> tmpUsersMap = new HashMap<>();
            for (User user : users.getResult()) {
                tmpUsersMap.put(user.getId(), user);
            }
            for (String roleName : getGlobalRoles(agencyId)) {
                if (roleName.isEmpty()) {
                    continue;
                }
                Role role = getRoleByName(roleName, agencyId);
                for (User userWithRole : getUsersWithRole(agencyId, role.getId())) {
                    if (tmpUsersMap.containsKey(userWithRole.getId()) && tmpUsersMap.get(userWithRole.getId()).getRoles().length == 0) {
                        tmpUsersMap.get(userWithRole.getId()).setRoles(new BaseObject[] {role});
                    }
                }
            }
            usersMap.put(agencyId, users.getResult());
        }
        return usersMap.get(agencyId);
    }

    public void clearUsersCache(String agencyId) {
        log.info("Clear users cache");
        usersMap.remove(agencyId);
        agencyAdminsMap.remove(agencyId);
    }

    public void updateUsersCache(String agencyId, User user) {
        log.info(String.format("Update user '%s' in cache", user.getId()));
        for (String roleName : getGlobalRoles(agencyId)) {
            if (roleName.isEmpty()) {
                continue;
            }
            Role role = getRoleByName(roleName, agencyId);
            for (User userWithRole : getUsersWithRole(agencyId, role.getId())) {
                if (user.getId().equals(userWithRole.getId())) {
                    user.setRoles(new BaseObject[] {role});
                    break;
                }
            }
            if (user.getRoles().length > 0) {
                break;
            }
        }
        List<User> users = usersMap.get(agencyId);
        if (users == null) {
            users = new ArrayList<>();
            usersMap.put(agencyId, users);
        }
        boolean foundInCache = false;
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId().equals(user.getId())) {
                users.set(i, user);
                foundInCache = true;
                break;
            }
        }
        if (!foundInCache) {
            users.add(user);
        }
        Collections.sort(users, new Comparator<User>() {
            @Override
            public int compare(User o1, User o2) {
                return o1.getEmail().compareTo(o2.getEmail());
            }
        });
    }

    public User getAgencyAdmin(String agencyId) {
        if (!agencyAdminsMap.containsKey(agencyId)) {
            List<User> users = getUsersWithRole(agencyId, AGENCY_ADMIN_ROLE_ID);
            if (users.size() > 0) {
                agencyAdminsMap.put(agencyId, users.get(0));
            }
        }
        return agencyAdminsMap.get(agencyId);
    }

    public List<Content> getAssets(String agencyId) {
        if (!assetsMap.containsKey(agencyId)) {
            log.info("Get assets from core");
            User agencyAdmin = getAgencyAdmin(agencyId);
            if (agencyAdmin == null) {
                log.info("Should be at least one agency admin in agency to see assets.");
                return new ArrayList<>();
            }
            BabylonCoreService agencyAdminService =
                    new BabylonCoreService(environment.getAddress(), agencyAdmin.getId());
            SearchResult<Content> assets =
                    agencyAdminService.findAssets(new LuceneSearchingParams().setSortingField("_cm.common.name.untouched"));
            log.info(String.format("Got %d assets. Has more: %s", assets.getResult().size(), assets.hasMore()));
            assetsMap.put(agencyId, assets.getResult());
        }
        return assetsMap.get(agencyId);
    }

    public void deleteAsset(String agencyId, String assetId) {
        log.info("Delete asset " + assetId);
        BabylonCoreService agencyAdminService =
                new BabylonCoreService(environment.getAddress(), getAgencyAdmin(agencyId).getId());
        agencyAdminService.deleteAsset(assetId);
        clearAssetsCache(agencyId);
        getAssets(agencyId);
    }

    public void clearAssetsCache(String agencyId) {
        log.info("Clear assets cache");
        assetsMap.remove(agencyId);
    }

    public List<Role> getRoles(String agencyId) {
        if (!rolesMap.containsKey(agencyId)) {
            log.info("Get roles from core");
            List<Role> result = service.findRoles(new LuceneSearchingParams().setQuery("_parents.$id:" + agencyId)).getResult();
            log.info(String.format("Got %d roles", result.size()));
            Collections.sort(result, new Comparator<Role>() {
                @Override
                public int compare(Role o1, Role o2) {
                    return o1.getName().compareToIgnoreCase(o2.getName());
                }
            });
            rolesMap.put(agencyId, result);
        }
        return rolesMap.get(agencyId);
    }

    public List<String> getGlobalRoles(String agencyId) {
        List<String> roleNames = new ArrayList<>();
        for (Role role : getRoles(agencyId)) {
            if (role.getGroup().equals("global")) {
                roleNames.add(role.getName());
            }
        }
        roleNames.addAll(getDefaultGlobalRoles());
        Collections.sort(roleNames, String.CASE_INSENSITIVE_ORDER);
        return roleNames;
    }

    public void deleteRole(String agencyId, String roleId) {
        log.info("Delete role " + roleId);
        service.getWrappedService().deleteRole(roleId);
        clearRolesCache(agencyId);
        getRoles(agencyId);
    }

    public void clearRolesCache(String agencyId) {
        log.info("Clear roles cache");
        rolesMap.remove(agencyId);
    }

    public List<String> getDefaultGlobalRoles() {
        if (defaultRoles == null) {
            log.info("Get roles from core");
            List<Role> result = service.findRoles(
                    new LuceneSearchingParams().setQuery("_parents.$id:4ef31ce1766ec96769b399bd")).getResult();
            defaultRoles = new HashMap<>();
            defaultRoles.put("", null);
            for (Role role : result) {
                if (!role.getGroup().equals("global")) {
                    continue;
                }
                defaultRoles.put(role.getName(), role);
            }
            log.info(String.format("Got %d roles", defaultRoles.size()));
        }
        Set<String> keys = defaultRoles.keySet();
        List<String> result = new ArrayList<>(keys);
        Collections.sort(result);
        return result;
    }

    public Role getRoleByName(String name, String agencyId) {
        Role role = getRoleByName(name);
        if (role == null) {
            for (Role nextRole : getRoles(agencyId)) {
                if (nextRole.getName().equals(name)) {
                    return nextRole;
                }
            }
        }
        return role;
    }

    public Role getRoleByName(String name) {
        if (defaultRoles == null) {
            getDefaultGlobalRoles();
        }
        return defaultRoles.get(name);
    }

    public List<FileStorage> getStorages() {
        if (storages == null) {
            log.info("Get file storages from core");
            storages = service.getFileStorages();
            log.info(String.format("Got %d storages", storages.size()));
        }
        return storages;
    }

    public FileStorage getStorageById(String storageId) {
        for (FileStorage storage : storages) {
            if (storage.getFileStorageId().equals(storageId)) {
                return storage;
            }
        }
        return null;
    }

    public List<String> getCountries() {
        if (countries == null) {
            log.info("Get countries from core");
            DictionaryValues dictionary = service.getDictionary(DictionaryType.COUNTRY).getValues();
            log.info(String.format("Got %s elements", dictionary.size()));
            countries = new HashMap<>();
            countryCodes = new HashMap<>();
            for (DictionaryItem item : dictionary) {
                countries.put(item.getName(), item.getKey());
                countryCodes.put(item.getKey(), item.getName());
            }
        }
        Set<String> keys = countries.keySet();
        List<String> result = new ArrayList<>(keys);
        Collections.sort(result);
        return result;
    }

    public String getCountryCode(String countryName) {
        getCountries();
        return countries.get(countryName);
    }

    public String getCountryName(String countryCode) {
        getCountries();
        return countryCodes.get(countryCode);
    }

    public List<String> getTimeZones() {
        if (timeZoneNames == null) {
            log.info("Get time zones from core");
            DictionaryValues timeZones = service.getDictionary(DictionaryType.TIME_ZONE).getValues();
            log.info(String.format("Got %d elements", timeZones.size()));
            timeZoneNames = timeZones.getKeys();
        }
        return timeZoneNames;
    }

    public List<String> getOrganisationTypes() {
        if (organisationTypes == null) {
            log.info("Get organisation types from core");
            DictionaryValues types = service.getDictionary(DictionaryType.ORGANISATION_TYPE).getValues();
            log.info(String.format("Got %d elements", types.size()));
            organisationTypes = types.getKeys();
            Collections.sort(organisationTypes);
        }
        return organisationTypes;
    }

    public void rebuildIndex(String agencyId, String indexType) {
        log.info("Rebuild index" + (indexType == null ? "" : " '" + indexType + "'")
                + (agencyId == null ? "" : " for agency '" + agencyId + "'"));
        String[] agenciesId = agencyId == null ? null : new String[] {agencyId};
        String[] indexTypes = indexType == null ? null : new String[] {indexType};
        service.getWrappedService().rebuildIndex(indexTypes, agenciesId, null);
    }

    private void sortGroupsArray(BaseObject[] array) {
        Arrays.sort(array, new Comparator<BaseObject>() {
            @Override
            public int compare(BaseObject a1, BaseObject a2) {
                String name1 = a1.getName() == null ? "" : a1.getName();
                String name2 = a2.getName() == null ? "" : a2.getName();
                return name1.compareToIgnoreCase(name2);
            }
        });
    }

    private List<User> getUsersWithRole(String agencyId, String roleId) {
        return service.getWrappedService().getAclSubjects(roleId, agencyId).getResult();
    }
}
