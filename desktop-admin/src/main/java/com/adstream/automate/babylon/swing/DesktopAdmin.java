package com.adstream.automate.babylon.swing;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.swing.tree.*;
import com.adstream.automate.utils.Common;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import javax.swing.*;
import javax.swing.event.TreeExpansionEvent;
import javax.swing.event.TreeExpansionListener;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreePath;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 03.11.12 13:09
 */
public class DesktopAdmin extends JFrame implements ActionListener, ComponentListener, WindowStateListener,
        TreeExpansionListener, TreeSelectionListener, ItemListener {

    public static void main(String[] args) {
        new DesktopAdmin();
    }

    private Logger log = Logger.getLogger(this.getClass());
    private BabylonServiceWrapper service;
    private AgencyCache agencyCache;
    private JComboBox envCombo;
    private JLabel envLabel;
    private JButton connectButton;
    private JTextArea logArea;
    private JScrollPane logScrollPane;
    private JTree tree;
    private JScrollPane treeScrollPane;

    private List<JButton> buttons;
    private JButton createAgencyButton;
    private JButton createUserButton;
    private JButton rebuildIndexButton;

    private List<JPanel> panels;
    private AgencyPanel agencyPanel;
    private UserPanel userPanel;
    private AssetPanel assetPanel;
    private RolePanel rolePanel;
    private RebuildIndexPanel rebuildIndexPanel;

    private DesktopAdmin() {
        super("Babylon desktop admin");
        setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        setLayout(null);
        setMinimumSize(new Dimension(900, 700));
        setSize(900, 700);
        drawLogArea();
        initLog4j();
        drawLoginFields();
        drawTree();
        drawControls();
        drawInfoPanels();
        addComponentListener(this);
        addWindowStateListener(this);
        setVisible(true);
    }

    protected BabylonServiceWrapper getService() {
        return service;
    }

    protected AgencyCache getAgencyCache() {
        return agencyCache;
    }

    protected Environment getSelectedEnvironment() {
        return (Environment) envCombo.getSelectedItem();
    }

    private void drawLoginFields() {
        envCombo = new JComboBox(getEnvironments());
        envCombo.setLocation(5, 5);
        envCombo.setSize(envCombo.getPreferredSize());
        envCombo.addItemListener(this);
        add(envCombo);

        envLabel = new JLabel("<-- Please select environment");
        envLabel.setLocation(envCombo.getX() + envCombo.getWidth() + 5, 10);
        envLabel.setSize(envLabel.getPreferredSize());
        add(envLabel);

        connectButton = new JButton("Connect");
        connectButton.setSize(connectButton.getPreferredSize());
        connectButton.setLocation((int) getSize().getWidth() - getInsets().right - connectButton.getWidth() - 20, 5);
        connectButton.addActionListener(this);
        connectButton.setEnabled(false);
        add(connectButton);
    }

    private Environment[] getEnvironments() {
        List<Environment> envs = new ArrayList<Environment>();
        envs.add(new Environment());
        File file = new File("environment.list");
        try {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty())
                    continue;
                String[] parts = line.split(";");
                if (parts.length != 4)
                    continue;
                URL url;
                try {
                    url = new URL(parts[1].trim());
                } catch (MalformedURLException e) {
                    continue;
                }
                Environment env = new Environment();
                env.setName(parts[0].trim());
                env.setAddress(url);
                env.setLogin(parts[2].trim());
                env.setPassword(parts[3].trim());
                envs.add(env);
            }
        } catch (FileNotFoundException e) {
            log.error("Environment list file not found");
            log.debug(Common.exceptionToString(e));
        } catch (IOException e) {
            log.error("Error on reading environment list file");
            log.debug(Common.exceptionToString(e));
        }
        return envs.toArray(new Environment[envs.size()]);
    }

    private void drawControls() {
        int left = 310;
        int top = connectButton.getY() + connectButton.getHeight() + 10;

        buttons = new ArrayList<>();
        buttons.add(createAgencyButton = new JButton("Create Agency"));
        buttons.add(createUserButton = new JButton("Create User"));
        buttons.add(rebuildIndexButton = new JButton("Rebuild Index"));

        int max = 0;
        for (JButton button : buttons) {
            int current = (int) button.getPreferredSize().getWidth();
            if (current > max)
                max = current;
        }
        Dimension dim = new Dimension(max, (int) buttons.get(0).getPreferredSize().getHeight());
        for (int i = 0; i < buttons.size(); i++) {
            JButton button = buttons.get(i);
            button.setLocation(left, top + ((int) dim.getHeight() + 10) * i);
            button.setSize(dim);
            button.setEnabled(false);
            button.addActionListener(this);
            add(button);
        }
    }

    private void drawInfoPanels() {
        panels = new ArrayList<>();
        panels.add(agencyPanel = new AgencyPanel(this));
        panels.add(userPanel = new UserPanel(this));
        panels.add(assetPanel = new AssetPanel(this));
        panels.add(rolePanel = new RolePanel(this));
        panels.add(rebuildIndexPanel = new RebuildIndexPanel(this));

        for (JPanel panel : panels) {
            panel.setLocation(createAgencyButton.getX() + createAgencyButton.getWidth() + 10, createAgencyButton.getY());
            panel.setVisible(false);
            add(panel);
        }
    }

    private void initLog4j() {
        TextAreaAppender.setTextArea(logArea);
        Properties props = new Properties();
        props.put("log4j.rootLogger", "INFO, console, textarea");
        props.put("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        props.put("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        props.put("log4j.appender.console.layout.ConversionPattern", "%d %-5p %m%n");
        props.put("log4j.appender.textarea", "com.adstream.automate.babylon.swing.TextAreaAppender");
        props.put("log4j.appender.textarea.layout", "org.apache.log4j.PatternLayout");
        props.put("log4j.appender.textarea.layout.ConversionPattern", "%d %-5p %m%n");
        props.put("log4j.appender.textarea.Threshold", "INFO");
        props.put("log4j.logger.com.adstream.automate.babylon.BabylonService", "DEBUG");
        PropertyConfigurator.configure(props);
    }

    private void drawTree() {
        tree = new JTree(new DefaultMutableTreeNode("Not connected"));
        tree.addTreeExpansionListener(this);
        tree.addTreeSelectionListener(this);
        tree.setCellRenderer(new AgencyAdminTreeCellRenderer());

        treeScrollPane = new JScrollPane(tree);
        treeScrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
        treeScrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
        treeScrollPane.setLocation(0, connectButton.getY() + connectButton.getHeight() + 10);
        add(treeScrollPane);
    }

    private void drawLogArea() {
        logArea = new JTextArea();
        logArea.setEditable(false);

        logScrollPane = new JScrollPane(logArea);
        logScrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
        logScrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
        add(logScrollPane);
    }

    private void connect() {
        new Thread() {
            public void run() {
                disableFields();
                Environment env = getSelectedEnvironment();
                log.info(String.format("Try to connect to %s (%s)", env.getName(), env.getAddress()));
                service = new BabylonServiceWrapper(new BabylonCoreService(env.getAddress()), null);
                if (!service.logIn(env.getLogin(), env.getPassword())) {
                    log.error("Unable to login");
                    enableFields();
                    return;
                }
//                String version = service.getVersion();
//                if (!version.startsWith("5.2")) {
//                    log.error("Only 5.2 core version is supported. Current core version - " + version);
//                    enableFields();
//                    return;
//                }
                log.info("Successfully logged in");
                agencyCache = new AgencyCache(getSelectedEnvironment(), service);
                enableButtonControls();
                rebuildTree();
            }

            private void disableFields() {
                envCombo.setEnabled(false);
                connectButton.setEnabled(false);
            }

            private void enableFields() {
                envCombo.setEnabled(true);
                connectButton.setEnabled(true);
            }
        }.start();
    }

    protected void rebuildTree() {
        this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
        DefaultMutableTreeNode root = new DefaultMutableTreeNode("Agencies");
        for (Agency agency : agencyCache.getAgencies()) {
            AgencyEntry agencyEntry = new AgencyEntry(agency.getId(), agency.getName());
            DefaultMutableTreeNode agencyNode = new DefaultMutableTreeNode(agencyEntry);
            for (AgencyChildEntry.Type type : AgencyChildEntry.Type.values())
                agencyNode.add(getAgencyChildNode(type, "", agency.getId()));
            root.add(agencyNode);
        }
        tree.setModel(new DefaultTreeModel(root));
        tree.expandPath(new TreePath(root));
        this.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
    }

    private TreePath getAgencyNodePath(String agencyId) {
        Object root = tree.getModel().getRoot();
        TreePath path = null;
        for (int i = 0; i < tree.getModel().getChildCount(root); i++) {
            DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getModel().getChild(root, i);
            if (((AgencyEntry) node.getUserObject()).getAgencyId().equals(agencyId)) {
                path = new TreePath(node.getPath());
                break;
            }
        }
        return path;
    }

    private TreePath getAgencyChildNodePath(String agencyId, String name) {
        TreePath agencyNode = getAgencyNodePath(agencyId);
        tree.expandPath(agencyNode);
        Object root = agencyNode.getLastPathComponent();
        TreePath path = null;
        for (int i = 0; i < tree.getModel().getChildCount(root); i++) {
            DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getModel().getChild(root, i);
            if (node.toString().equals(name))
                path = new TreePath(node.getPath());
        }
        return path;
    }

    private TreePath getUserNodePath(String agencyId, String userId) {
        TreePath usersNode = getAgencyChildNodePath(agencyId, "Users");
        tree.expandPath(usersNode);
        Object root = usersNode.getLastPathComponent();
        TreePath path = null;
        for (int i = 0; i < tree.getModel().getChildCount(root); i++) {
            DefaultMutableTreeNode node = (DefaultMutableTreeNode) tree.getModel().getChild(root, i);
            if (((UserEntry) node.getUserObject()).getUser().getId().equals(userId)) {
                path = new TreePath(node.getPath());
                break;
            }
        }
        return path;
    }

    protected void selectAgencyNode(String agencyId) {
        TreePath path = getAgencyNodePath(agencyId);
        tree.setSelectionPath(path);
        tree.scrollPathToVisible(path);
    }

    protected void selectAgencyChildNode(String agencyId, AgencyChildEntry.Type type) {
        TreePath node = getAgencyChildNodePath(agencyId, type.toString());
        tree.setSelectionPath(node);
        tree.scrollPathToVisible(node);
        tree.expandPath(node);
        showPanel(null);
    }

    protected void selectUserNode(String agencyId, String userId) {
        TreePath path = getUserNodePath(agencyId, userId);
        tree.setSelectionPath(path);
        tree.scrollPathToVisible(path);
    }

    private String getSelectedAgencyId() {
        TreePath path = tree.getSelectionPath();
        if (path != null) {
            DefaultMutableTreeNode node = (DefaultMutableTreeNode) path.getLastPathComponent();
            Object userObject = node.getUserObject();
            if (userObject instanceof AgencyEntry)
                return ((AgencyEntry) userObject).getAgencyId();
            if (userObject instanceof AgencyChildEntry)
                return ((AgencyChildEntry) userObject).getParentId();
        }
        return null;
    }

    private DefaultMutableTreeNode getAgencyChildNode(AgencyChildEntry.Type type, String value, String parentId) {
        DefaultMutableTreeNode node = new DefaultMutableTreeNode(new AgencyChildEntry(type, value, parentId));
        node.add(new DefaultMutableTreeNode("Loading..."));
        return node;
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        Object source = e.getSource();
        if (source == connectButton) {
            connect();
        } else if (source == createAgencyButton) {
            tree.setSelectionPath(null);
            enableButtonControls();
            showPanel(agencyPanel);
            agencyPanel.fill(new Agency());
        } else if (source == createUserButton) {
            showPanel(userPanel);
            User user = new User();
            user.setAgency(agencyCache.getAgencyById(getSelectedAgencyId()));
            userPanel.fill(user);
        } else if (source == rebuildIndexButton) {
            Agency agency = agencyCache.getAgencyById(getSelectedAgencyId());
            String agencyName = agency == null ? null : agency.getName();
            showPanel(rebuildIndexPanel);
            rebuildIndexPanel.fill(agencyName);
        }
    }

    @Override
    public void componentResized(ComponentEvent e) {
        int horScrollBarHeight = logScrollPane.getHorizontalScrollBar().getPreferredSize().height;
        logScrollPane.setLocation(0, (int) getSize().getHeight() - 2 * horScrollBarHeight - getInsets().bottom - 200);
        logScrollPane.setSize((int) getSize().getWidth() - logScrollPane.getVerticalScrollBar().getPreferredSize().width, 200);

        treeScrollPane.setSize(300, logScrollPane.getY() - treeScrollPane.getY());

        agencyPanel.setSize((int) getSize().getWidth() - getInsets().right - agencyPanel.getX(), (int) treeScrollPane.getSize().getHeight());
        userPanel.setSize(agencyPanel.getSize());
        assetPanel.setSize(agencyPanel.getSize());
        rolePanel.setSize(agencyPanel.getSize());
        rebuildIndexPanel.setSize(agencyPanel.getSize());
    }

    @Override
    public void componentMoved(ComponentEvent e) {
    }

    @Override
    public void componentShown(ComponentEvent e) {
    }

    @Override
    public void componentHidden(ComponentEvent e) {
    }

    @Override
    public void windowStateChanged(WindowEvent e) {
        componentResized(e);
    }

    @Override
    public void treeExpanded(TreeExpansionEvent event) {
        this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
        DefaultMutableTreeNode node = (DefaultMutableTreeNode) event.getPath().getLastPathComponent();
        Object userObject = node.getUserObject();
        if (userObject instanceof AgencyChildEntry) {
            AgencyChildEntry entry = (AgencyChildEntry) userObject;
            if (!entry.isLoaded()) {
                List elements = new ArrayList();
                switch (entry.getType()) {
                    case USERS:
                        elements = agencyCache.getUsers(entry.getParentId());
                        break;
                    case ASSETS:
                        elements = agencyCache.getAssets(entry.getParentId());
                        break;
                    case ROLES:
                        elements = agencyCache.getRoles(entry.getParentId());
                        break;
                }
                node.removeAllChildren();
                for (Object element : elements)
                    if (element instanceof User) {
                        User user = (User) element;
                        node.add(new DefaultMutableTreeNode(new UserEntry(user)));
                    } else if (element instanceof Content) {
                        Content asset = (Content) element;
                        node.add(new DefaultMutableTreeNode(new AssetEntry(asset)));
                    } else if (element instanceof Role) {
                        Role role = (Role) element;
                        node.add(new DefaultMutableTreeNode(new RoleEntry(role)));
                    }
                entry.setLoaded(true);
                ((DefaultTreeModel) tree.getModel()).reload(node);
            }
        }
        this.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
    }

    @Override
    public void treeCollapsed(TreeExpansionEvent event) {
    }

    @Override
    public void valueChanged(TreeSelectionEvent e) {
        DefaultMutableTreeNode node = (DefaultMutableTreeNode) e.getPath().getLastPathComponent();
        Object userObject = node.getUserObject();
        enableButtonControls();
        if (userObject instanceof AgencyEntry) {
            AgencyEntry entry = (AgencyEntry) userObject;
            Agency agency = agencyCache.getAgencyById(entry.getAgencyId());
            agencyPanel.fill(agency);
            showPanel(agencyPanel);
            enableButtonControls(createUserButton);
        } else if (userObject instanceof UserEntry) {
            UserEntry entry = (UserEntry) userObject;
            userPanel.fill(entry.getUser());
            showPanel(userPanel);
        } else if (userObject instanceof AssetEntry) {
            AssetEntry entry = (AssetEntry) userObject;
            assetPanel.fill(entry.getAsset());
            showPanel(assetPanel);
        } else if (userObject instanceof RoleEntry) {
            RoleEntry entry = (RoleEntry) userObject;
            rolePanel.fill(entry.getRole());
            showPanel(rolePanel);
        } else if (userObject instanceof AgencyChildEntry) {
            enableButtonControls(createUserButton);
        } else {
            showPanel(null);
        }
    }

    @Override
    public void itemStateChanged(ItemEvent e) {
        if (e.getStateChange() == ItemEvent.DESELECTED)
            return;
        Environment env = (Environment) e.getItem();
        if (env.getName() == null) {
            envLabel.setText("<-- Please select environment");
            envLabel.setSize(envLabel.getPreferredSize());
            connectButton.setEnabled(false);
            return;
        }
        envLabel.setText(String.format("Selected environment: %s (%s)", env.getName(), env.getAddress()));
        envLabel.setSize(envLabel.getPreferredSize());
        connectButton.setEnabled(true);
    }

    private void showPanel(JPanel panelToShow) {
        for (JPanel panel : panels)
            panel.setVisible(panel == panelToShow);
    }

    private void enableButtonControls(JButton... enabledButtons) {
        for (JButton button : buttons) {
            boolean enabled = false;
            for (JButton enabledButton : enabledButtons)
                if (button == enabledButton) {
                    enabled = true;
                    break;
                }
            button.setEnabled(enabled);
        }
        createAgencyButton.setEnabled(true);
        rebuildIndexButton.setEnabled(true);
    }
}
