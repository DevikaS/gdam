package com.adstream.automate.jbehave;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.steps.ParameterConverters;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 17.05.12
 * Time: 13:59
 */
public class CustomParameterConverters {

    public static class JodaDateConverter implements ParameterConverters.ParameterConverter {
        public static final DateTimeFormatter DEFAULT_FORMAT = DateTimeFormat.forPattern("dd/MM/yyyy");

        private final DateTimeFormatter dateFormat;

        public JodaDateConverter() {
            this(DEFAULT_FORMAT);
        }

        public JodaDateConverter(DateTimeFormatter dateFormat) {
            this.dateFormat = dateFormat;
        }

        public boolean accept(Type type) {
            return type instanceof Class<?> && DateTime.class.isAssignableFrom((Class<?>) type);
        }

        public Object convertValue(String value, Type type) {
            try {
                return dateFormat.parseDateTime(value);
            } catch (IllegalArgumentException e) {
                throw new ParameterConverters.ParameterConvertionFailed("Failed to convert value "
                        + value
                        + " with date format "
                        + (dateFormat != null ? dateFormat.toString(): "null")
                        , e);
            }
        }
    }

    public static class JsonObjectConverter extends BaseStep implements ParameterConverters.ParameterConverter {
        private Map<Type, Method> cache = new HashMap<>();

        @Override
        public boolean accept(Type type) {
            return type instanceof Class<?> && BaseObject.class.isAssignableFrom((Class<?>) type);
        }

        @Override
        public BaseObject convertValue(String name, Type type) {
            Method method = getMethodForType(type);
            if (method != null) {
                try {
                    return (BaseObject) method.invoke(this, name);
                } catch (Exception e) {
                    throw new ParameterConverters.ParameterConvertionFailed("Could not convert '" + name + "' into type '" + type + "'", e);
                }
            }
            throw new UnsupportedOperationException("Conversion for type '" + type + "' isn't implemented yet.");
        }

        private Method getMethodForType(Type type) {
            Method cachedMethod = cache.get(type);
            if (cachedMethod == null) {
                for (Method method : JsonObjectConverter.class.getDeclaredMethods()) {
                    if (method.getReturnType() == type) {
                        cache.put(type, method);
                        cachedMethod = method;
                        break;
                    }
                }
            }
            return cachedMethod;
        }

        private Agency convertAgency(String agencyName) {
            Agency agency = getData().getAgencyByName(agencyName);
            if (agency == null) {
                agencyName = wrapVariableWithTestSession(agencyName);
                agency = getData().getAgencyByName(agencyName);
                if (agency == null) {
                    agency = getCoreApiAdmin().getAgencyByName(agencyName);
                    if (agency == null) {
                        throw new ParameterConverters.ParameterConvertionFailed("Could not find agency '" + agencyName + "'");
                    } else {
                        getData().addAgency(agencyName, agency);
                    }
                }
            }
            return agency;
        }

        private Role convertRole(String roleName) {
            if (!getCoreApiAdmin().isDefaultRole(roleName)) {
                roleName = wrapVariableWithTestSession(roleName);
            }
            Role role = getCoreApiAdmin().getRoleByName(roleName,false);
            if (role == null) {
                throw new IllegalArgumentException("Could not find role '" + roleName + "'");
            }
            return role;
        }

        private AssetFilter convertCollection(String collectionName) {
            return getCoreApi().getAssetsFilterByName(wrapCollectionName(collectionName), "");
        }

        private User convertUser(String userName) {
            User user = getData().getUserByType(userName);
            if (user == null) {
                user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
            }
            return user;
        }

        private Project convertProject(String projectName) {
            return getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        }

        private Order convertToOrder(String clockNumber) {
            Order order = getCoreApi().getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
            if (order == null)
                throw new NullPointerException("Order was not found by following item clock number: " + clockNumber);
            return order;
        }
    }
}