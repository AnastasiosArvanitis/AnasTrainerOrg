# GitHub Actions Workflows Analysis

## Overview

This repository contains three GitHub Actions workflows designed to support Salesforce development and deployment processes. These workflows automate code quality checks, UAT deployments, and production deployments.

## Workflows Summary

| Workflow | Trigger | Purpose | Environment |
|----------|---------|---------|-------------|
| PMD Static Analysis | Pull Request | Code quality checks on Apex files | N/A |
| Deploy to UAT | Manual (workflow_dispatch) | Deploy to UAT sandbox | UAT Sandbox |
| Deploy to PROD | Manual (workflow_dispatch) | Deploy to production org | Production (main branch only) |

---

## 1. PMD Static Analysis (`pmd-action.yml`)

### Purpose
Performs static code analysis on Apex classes and triggers using PMD (Programming Mistake Detector) to identify potential code quality issues before merging pull requests.

### Trigger
- **Event**: Pull Request
- **Target Branches**: `main`, `dev`, `uat`

### Key Features
- **Smart File Detection**: Only analyzes changed Apex files (.cls, .trigger) in the PR
- **Automated Comments**: Posts analysis results as PR comments
- **Priority-Based Blocking**: Fails the workflow if Priority 1 violations are found
- **Detailed Reporting**: Generates a comprehensive report with violation details

### Workflow Steps

1. **Checkout code** (actions/checkout@v4.1.7)
   - Fetches the full git history for comparison

2. **Get changed Apex files**
   - Compares the PR branch with the base branch
   - Identifies modified Apex classes and triggers
   - Skips analysis if no Apex files changed

3. **Install PMD**
   - Downloads PMD version 7.0.0
   - Adds PMD to the system PATH
   - Only runs if Apex files were changed

4. **Run PMD Analysis**
   - Executes PMD with custom ruleset (`.pmd/pmd-ruleset.xml`)
   - Outputs results in JSON format
   - Counts violations by priority level (P1 and P2)
   - Generates a markdown report with:
     - Summary statistics
     - Detailed violation table
     - Status indicator (✅ Pass / ❌ Fail)

5. **Comment PR**
   - Uses GitHub Script action to post results
   - Includes full analysis report in PR comments
   - Runs even if previous steps fail (always condition)

6. **Fail on Priority 1 violations**
   - Blocks PR merge if P1 violations exist
   - Allows P2 warnings without blocking

7. **Success**
   - Confirms analysis passed
   - Warns about P2 violations if present

### Configuration
- **PMD Version**: 7.0.0
- **Ruleset**: `.pmd/pmd-ruleset.xml`
- **Language**: Apex (forced)
- **Output Format**: JSON

### Permissions Required
- `contents: read` - Read repository content
- `pull-requests: write` - Post comments on PRs

### Violation Priority Levels
- **Priority 1 (Blocking)**: Critical issues that must be fixed before merging
- **Priority 2 (Warning)**: Non-blocking issues that should be addressed

---

## 2. Deploy to UAT (`deploy-uat.yml`)

### Purpose
Deploys Salesforce metadata from the `force-app` directory to the UAT (User Acceptance Testing) sandbox environment.

### Trigger
- **Event**: Manual workflow dispatch (`workflow_dispatch`)
- **Branches**: Any branch

### Key Features
- **JWT Authentication**: Secure authentication using JWT Bearer Flow
- **Automatic Test Detection**: Detects Apex classes and runs corresponding tests
- **Flexible Test Execution**: Runs tests only if Apex classes exist
- **Deployment Artifacts**: Saves deployment results for 30 days
- **Comprehensive Summaries**: Provides detailed deployment information

### Workflow Steps

1. **Checkout repository** (actions/checkout@v4)
   - Retrieves the code from the repository

2. **Install Salesforce CLI**
   - Installs the latest Salesforce CLI globally
   - Verifies installation with version check

3. **Authenticate to UAT**
   - Uses JWT Bearer Flow for secure authentication
   - Creates temporary file for private key (secure handling)
   - Authenticates with:
     - Client ID: `SF_CONSUMER_KEY` secret
     - JWT Key: `SF_JWT_KEY` secret
     - Username: `SF_USERNAME` secret
     - Instance URL: `SF_INSTANCE_URL` secret
   - Sets the org as default with alias "uat"
   - Removes temporary key file after authentication

4. **Detect Apex classes for testing**
   - Searches for Apex classes in `force-app` directory
   - Excludes test classes (*_Test.cls) and metadata files
   - If Apex classes found:
     - Sets `TEST_LEVEL=RunSpecifiedTests`
     - Generates list of corresponding test classes
   - If no Apex classes found:
     - Sets `TEST_LEVEL=NoTestRun`

5. **Deploy to UAT**
   - Deploys all metadata from `force-app` directory
   - Executes deployment with appropriate test level:
     - **RunSpecifiedTests**: Runs tests for detected Apex classes
     - **NoTestRun**: No tests executed (no Apex classes)
   - Outputs results in JSON format
   - Captures deployment status (success/failure)
   - Saves results to `deploy-results.json`

6. **Upload deployment results** (actions/upload-artifact@v4)
   - Uploads `deploy-results.json` as artifact
   - Retention: 30 days
   - Runs even if deployment fails (always condition)

7. **Add deployment summary**
   - Creates GitHub Step Summary with:
     - Branch and commit information
     - Deployment scope
     - Test classes executed (or note about no tests)
     - Deployment status (✅ Success / ❌ Failed)
   - Runs even if deployment fails (always condition)

### Required Secrets
- `SF_CONSUMER_KEY` - Salesforce Connected App Consumer Key
- `SF_JWT_KEY` - JWT private key for authentication
- `SF_USERNAME` - Salesforce username for UAT sandbox
- `SF_INSTANCE_URL` - UAT sandbox instance URL (e.g., test.salesforce.com)

### Test Strategy
- **Smart Test Detection**: Automatically detects Apex classes and runs corresponding tests
- **Naming Convention**: Assumes test classes follow `{ClassName}_Test` pattern
- **No Apex = No Tests**: If no Apex classes exist, uses `NoTestRun`

---

## 3. Deploy to PROD (`deploy-prod.yml`)

### Purpose
Deploys Salesforce metadata from the `force-app` directory to the production Salesforce org with mandatory test execution.

### Trigger
- **Event**: Manual workflow dispatch (`workflow_dispatch`)
- **Branches**: **Only `main` branch** (enforced by condition)

### Key Features
- **Branch Protection**: Only allows deployments from the main branch
- **Mandatory Testing**: Always runs local tests (RunLocalTests)
- **JWT Authentication**: Secure authentication using JWT Bearer Flow
- **Deployment Artifacts**: Saves deployment results for 30 days
- **Production Safety**: Enforces stricter test requirements than UAT

### Workflow Steps

1. **Checkout repository** (actions/checkout@v4)
   - Retrieves the code from the repository

2. **Install Salesforce CLI**
   - Installs the latest Salesforce CLI globally
   - Verifies installation with version check

3. **Authenticate to PROD**
   - Uses JWT Bearer Flow for secure authentication
   - Creates temporary file for private key (secure handling)
   - Authenticates with:
     - Client ID: `SF_PROD_CLIENT_ID` secret
     - JWT Key: `SF_PROD_JWT_KEY` secret
     - Username: `SF_PROD_USERNAME` secret
     - Instance URL: `SF_PROD_INSTANCE_URL` secret
   - Sets the org as default with alias "prod"
   - Removes temporary key file after authentication

4. **Configure test execution**
   - Sets test level to `RunLocalTests` (mandatory for production)
   - Production deployments always run tests (no NoTestRun option)
   - Logs test configuration for transparency

5. **Deploy to PROD**
   - Deploys all metadata from `force-app` directory
   - Always executes with `RunLocalTests`:
     - Runs all local tests in the org
     - Ensures code coverage requirements are met
   - Outputs results in JSON format
   - Captures deployment status (success/failure)
   - Saves results to `deploy-results.json`

6. **Upload deployment results** (actions/upload-artifact@v4)
   - Uploads `deploy-results.json` as artifact
   - Artifact name: `prod-deployment-results`
   - Retention: 30 days
   - Runs even if deployment fails (always condition)

7. **Add deployment summary**
   - Creates GitHub Step Summary with:
     - Branch and commit information
     - Deployment scope
     - Test configuration (RunLocalTests)
     - Deployment status (✅ Success / ❌ Failed)
   - Runs even if deployment fails (always condition)

### Required Secrets
- `SF_PROD_CLIENT_ID` - Salesforce Connected App Consumer Key for production
- `SF_PROD_JWT_KEY` - JWT private key for production authentication
- `SF_PROD_USERNAME` - Salesforce username for production org
- `SF_PROD_INSTANCE_URL` - Production instance URL (e.g., login.salesforce.com)

### Safety Features
- **Branch Restriction**: `if: github.ref_name == 'main'` prevents accidental deployments from other branches
- **Mandatory Testing**: Always runs `RunLocalTests` to ensure code quality
- **No Test Bypass**: Cannot use `NoTestRun` in production
- **Separate Secrets**: Uses different secrets than UAT for enhanced security

### Production vs UAT Comparison
| Feature | UAT | PROD |
|---------|-----|------|
| Branch Restriction | None | main branch only |
| Test Level | NoTestRun or RunSpecifiedTests | RunLocalTests (mandatory) |
| Test Coverage | Optional | Enforced by Salesforce |
| Secrets | SF_* | SF_PROD_* |

---

## Security Best Practices

### JWT Authentication
All workflows use JWT Bearer Flow, which provides several security benefits:
- **No password exposure**: Authentication uses private keys instead of passwords
- **Temporary credentials**: JWT tokens are short-lived
- **Secure secret handling**: Private keys stored as GitHub secrets
- **Key cleanup**: Temporary key files are deleted after authentication

### Secret Management
- Secrets are stored in GitHub repository settings
- Each environment (UAT/PROD) uses separate secrets
- Private keys are never exposed in logs
- Temporary files are securely deleted after use

### Permissions
- PMD workflow has minimal permissions (read contents, write PR comments)
- Deployment workflows rely on repository-level secrets
- No hardcoded credentials in workflow files

---

## Deployment Artifacts

Both deployment workflows save results as artifacts:

### Artifact Details
- **File**: `deploy-results.json`
- **Format**: JSON (Salesforce CLI output)
- **Retention**: 30 days
- **Availability**: Even if deployment fails
- **Use Cases**:
  - Debugging failed deployments
  - Audit trail
  - Historical analysis

### Accessing Artifacts
1. Navigate to the workflow run in GitHub Actions
2. Scroll to the "Artifacts" section at the bottom
3. Download the deployment results

---

## Workflow Execution

### Running Deployments

#### Deploy to UAT
1. Go to Actions tab in GitHub
2. Select "Deploy to UAT" workflow
3. Click "Run workflow"
4. Select the branch to deploy
5. Click "Run workflow" button

#### Deploy to PROD
1. Go to Actions tab in GitHub
2. Select "Deploy to PROD" workflow
3. Click "Run workflow"
4. **Must be on main branch**
5. Click "Run workflow" button

### Monitoring Progress
- Each workflow provides real-time logs
- Step summaries show deployment details
- Artifacts contain full deployment results
- GitHub notifications for workflow completion

---

## Common Scenarios

### Scenario 1: Pull Request with Code Changes
1. Developer creates PR with Apex changes
2. PMD workflow automatically triggers
3. Workflow analyzes changed files
4. Results posted as PR comment
5. PR blocked if Priority 1 violations found

### Scenario 2: Deploying to UAT
1. Developer triggers "Deploy to UAT" workflow
2. Workflow authenticates to UAT sandbox
3. Detects Apex classes and generates test list
4. Deploys metadata with appropriate tests
5. Results available as artifact and summary

### Scenario 3: Production Deployment
1. Code merged to main branch
2. Developer manually triggers "Deploy to PROD"
3. Workflow verifies it's running from main branch
4. Authenticates to production org
5. Deploys with mandatory RunLocalTests
6. All local tests must pass for successful deployment

---

## Troubleshooting

### PMD Analysis Issues
- **No violations reported**: Check if `.pmd/pmd-ruleset.xml` exists
- **False positives**: Adjust ruleset configuration
- **Workflow skipped**: No Apex files changed in PR

### Deployment Failures
- **Authentication failed**: Verify secrets are correctly configured
- **Test failures**: Review `deploy-results.json` artifact for details
- **Branch restriction**: PROD deployments only work from main branch
- **Metadata errors**: Check Salesforce CLI output in workflow logs

### Missing Secrets
Required secrets must be added to repository settings:
1. Go to Settings → Secrets and variables → Actions
2. Add required secrets for each environment
3. Ensure secret names match exactly as defined in workflows

---

## Future Enhancements

### Potential Improvements
1. **Automated UAT Deployment**: Trigger UAT deployment on merge to specific branches
2. **Code Coverage Reporting**: Add code coverage metrics to PR comments
3. **Deployment Approvals**: Add manual approval gates for production
4. **Slack Notifications**: Integrate deployment notifications
5. **Incremental Deployments**: Deploy only changed components
6. **Rollback Capability**: Add workflow to rollback failed deployments
7. **Environment Variables**: Support for configurable test levels via workflow inputs

---

## Maintenance Notes

### Dependency Versions
- **actions/checkout**: v4.1.7 (PMD), v4 (deployments)
- **actions/upload-artifact**: v4
- **actions/github-script**: v7.0.1 (PMD)
- **PMD**: 7.0.0
- **Salesforce CLI**: Latest (installed from npm)

### Regular Maintenance
- Update action versions periodically
- Review and update PMD ruleset as needed
- Rotate JWT keys according to security policy
- Clean up old deployment artifacts if needed

---

## Conclusion

These three workflows provide a robust CI/CD pipeline for Salesforce development:

1. **PMD Static Analysis**: Ensures code quality before merge
2. **Deploy to UAT**: Enables safe testing in sandbox environment
3. **Deploy to PROD**: Controlled production deployments with safety checks

The workflows follow best practices for:
- Security (JWT authentication, secret management)
- Quality (mandatory testing, code analysis)
- Transparency (detailed summaries, artifacts)
- Safety (branch restrictions, test requirements)

This automation reduces manual errors and provides consistent, repeatable deployment processes across environments.
