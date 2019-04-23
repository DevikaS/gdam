package com.adstream.automate.babylon.monitoring;

import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import org.apache.log4j.PropertyConfigurator;

import javax.xml.bind.JAXB;
import java.io.File;
import java.io.InputStream;
import java.lang.reflect.Array;
import java.lang.reflect.Method;
import java.util.Collection;

/**
 * User: ruslan.semerenko
 * Date: 24.07.13 17:41
 */
public class ScriptExecutor {
    public static void main(String[] args) throws Exception {
        InputStream propertiesStream = ScriptExecutor.class.getClassLoader().getResourceAsStream("log4j.properties");
        PropertyConfigurator.configure(propertiesStream);

        Script script = JAXB.unmarshal(getFileFromArgs(args), Script.class);
        BabylonMiddlewareService service = new BabylonMiddlewareService(script.getApplicationURL());

        if (script.getAction() != null) {
            for (Action action : script.getAction()) {
                executeAction(service, action);
            }
        }
        System.out.println("true");
    }

    private static File getFileFromArgs(String[] args) {
        if (args == null || args.length == 0) {
            throw new IllegalArgumentException("Please provide script file");
        }

        File file = new File(args[0]);

        if (!file.exists()) {
            throw new IllegalArgumentException(String.format("File '%s' is not exists", file.getName()));
        } else if (!file.isFile()) {
            throw new IllegalArgumentException(String.format("'%s' is not a file", file.getName()));
        } else if (!file.canRead()) {
            throw new IllegalArgumentException(String.format("Could not read file '%s'", file.getName()));
        }

        return file;
    }

    private static void executeAction(BabylonMiddlewareService service, Action action) throws Exception {
        int argsCount = action.getArgument() == null ? 0 : action.getArgument().length;

        Class[] parameterTypes = new Class[argsCount];
        Object[] parameterValues = new Object[argsCount];

        for (int i = 0; i < argsCount; i++) {
            Argument arg = action.getArgument()[i];

            parameterTypes[i] = arg.getType().getClassForType();
            parameterValues[i] = getInstanceForArgument(arg);
        }

        Method method = service.getClass().getDeclaredMethod(action.getMethod(), parameterTypes);
        Object result = method.invoke(service, parameterValues);

        if (action.getAssertion() != null) {
            for (Assertion assertion : action.getAssertion()) {
                executeAssertion(assertion, result);
            }
        }
    }

    private static Object getInstanceForArgument(Argument argument) throws Exception {
        Object value;
        Class parameterType = argument.getType().getClassForType();
        if (argument.getType() == ArgumentType.Search && argument.getSearchValue() != null) {
            return argument.getSearchValue();
        } else if (argument.getValue() == null) {
            value = parameterType.newInstance();
        } else {
            value = parameterType.getConstructor(String.class).newInstance(argument.getValue());
        }
        return value;
    }

    private static void executeAssertion(Assertion assertion, Object object) {
        if (assertion.getSize() != null
                || assertion.getSizeMin() != null
                || assertion.getSizeMax() != null) {
            assertSize(assertion, object);
        } else if (assertion.getName() != null) {
            assertName(assertion, object);
        } else {
            throw new IllegalArgumentException("Nothing to assert");
        }
    }

    private static void assertSize(Assertion assertion, Object object) {
        int actualSize;
        if (object instanceof Collection) {
            actualSize = ((Collection) object).size();
        } else if (object.getClass().isArray()) {
            actualSize = Array.getLength(object);
        } else if (object instanceof SearchResult) {
            actualSize = ((SearchResult) object).getResult().size();
        } else {
            throw new IllegalStateException("Could not get size for " + object.getClass());
        }
        if (assertion.getSize() != null && actualSize != assertion.getSize()) {
            throw new AssertionError(
                    String.format("Size is not equal. Expected '%d', but got '%d'.", assertion.getSize(), actualSize));
        }
        if (assertion.getSizeMin() != null && actualSize < assertion.getSizeMin()) {
            throw new AssertionError(
                    String.format("Size is too low. Expected minimum '%d', but got '%d'.", assertion.getSizeMin(), actualSize));
        }
        if (assertion.getSizeMax() != null && actualSize > assertion.getSizeMax()) {
            throw new AssertionError(
                    String.format("Size is too high. Expected maximum '%d', but got '%d'.", assertion.getSizeMax(), actualSize));
        }
    }

    private static void assertName(Assertion assertion, Object object) {
        String actualName;
        if (object instanceof BaseObject) {
            actualName = ((BaseObject) object).getName();
        } else {
            throw new IllegalStateException("Could not get name for " + object.getClass());
        }
        if (!actualName.equals(assertion.getName())) {
            throw new AssertionError(
                    String.format("Name is not equal. Expected '%s', but got '%s'.", assertion.getName(), actualName));
        }
    }
}
