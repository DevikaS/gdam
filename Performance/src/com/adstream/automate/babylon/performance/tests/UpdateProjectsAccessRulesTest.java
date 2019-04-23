package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.projectsaccessrure.ProjectsAccessRule;
import com.adstream.automate.babylon.JsonObjects.projectsaccessrure.ProjectsAccessRuleTerm;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;

/**
 * User: lynda-k
 * Date: 12.08.14
 * Time: 12:35
 */
public class UpdateProjectsAccessRulesTest extends CreateProjectsAccessRulesTest {
    private static ProjectsAccessRule projectsAccessRule;
    @Override
    public void runOnce() {
        super.runOnce();
    }

    @Override
    public void beforeStart() {
        super.beforeStart();
        projectsAccessRule = getService().createProjectsAccessRule(generateProjectsAccessRule());
    }

    @Override
    public void start() {
        List<ProjectsAccessRuleTerm> projectsAccessRuleTerms = new ArrayList<>();
        String projectsAccessRuleTermKey = ACCESS_RULE_TERM_KEY;
        List<String> projectsAccessRuleTermValue = new ArrayList<>();

        projectsAccessRuleTermValue.add(advertisers.get(Gen.getInt(advertisers.size())));
        projectsAccessRuleTerms.add(new ProjectsAccessRuleTerm(projectsAccessRuleTermKey, projectsAccessRuleTermValue));

        projectsAccessRule.setTerms(projectsAccessRuleTerms);
        getService().updateProjectsAccessRule(projectsAccessRule);
    }

    @Override
    public void afterRun() {
        super.afterRun();
    }
}
