# CI/CD Setup Documentation

## Overview
This document describes the secure CI/CD deployment setup for PROD and UAT environments using GitHub Actions with JWT authentication.

## Architecture

### Components
1. **Dedicated Integration Users**: Separate users for PROD and UAT with minimal permissions
2. **Custom Permission Set**: `CI_CD_Deployment` - grants only required permissions for deployment
3. **Connected Apps**: Same app configuration in both orgs using JWT Bearer Flow
4. **GitHub Actions**: Automated deployment workflows with secure secret management

### Security Principles
- ✅ Dedicated integration users (not personal System Admin accounts)
- ✅ Minimal Access profile + permission set (principle of least privilege)
- ✅ Connected App restricted to permission set holders only
- ✅ JWT authentication (no password sharing)
- ✅ Secrets stored in GitHub (not in code)

## Setup Steps

### 1. Permission Set Deployment

**Deploy to PROD:**
```bash
sf project deploy start --source-dir force-app/main/default/permissionsets -o prod-alias
```

**Deploy to UAT:**
```bash
sf project deploy start --source-dir force-app/main/default/permissionsets -o uat-alias
```

### 2. Assign Permission Set to Integration Users

**In PROD Org:**
1. Setup > Users > Find your integration user (e.g., `cicd-prod@yourdomain.com`)
2. Permission Set Assignments > Assign Permission Sets
3. Select `CI/CD Deployment`
4. Click Assign

**In UAT Org:**
1. Repeat the same steps for your UAT integration user (e.g., `cicd-uat@yourdomain.com`)

### 3. Configure Connected App Access

**In Both PROD and UAT Orgs:**

1. Setup > App Manager > Your Connected App > Manage
2. Click **"Manage Permission Sets"** (NOT "Manage Profiles")
3. Add the `CI_CD_Deployment` permission set
4. Save

**Important:** Do NOT add any profiles. This ensures only users with the specific permission set can authenticate via this Connected App.

### 4. Verify Connected App OAuth Settings

Ensure the following settings are configured (in both orgs):

**OAuth Policies:**
- ✅ Enable OAuth Settings: Checked
- ✅ Permitted Users: "Admin approved users are pre-authorized"
- ❌ Require secret for Web Server Flow: **UNCHECKED** (not needed for JWT)
- ❌ Require secret for Refresh Token Flow: **UNCHECKED** (not needed for JWT)
- ❌ Require Proof Key for Code Exchange (PKCE): **UNCHECKED** (not needed for JWT)

**OAuth Scopes:**
- Access the identity URL service (id, profile, email, address, phone)
- Manage user data via APIs (api)
- Perform requests at any time (refresh_token, offline_access)

### 5. GitHub Secrets Configuration

In your GitHub repository (Settings > Secrets and variables > Actions > Repository secrets):

**PROD Secrets:**
- `SF_PROD_CLIENT_ID`: Consumer Key from Connected App
- `SF_PROD_JWT_KEY`: Private key content (entire .key file as text)
- `SF_PROD_USERNAME`: Integration user username (e.g., `cicd-prod@yourdomain.com`)
- `SF_PROD_INSTANCE_URL`: `login.salesforce.com`

**UAT Secrets:**
- `SF_UAT_CLIENT_ID`: Consumer Key from Connected App
- `SF_UAT_JWT_KEY`: Private key content (entire .key file as text)
- `SF_UAT_USERNAME`: Integration user username (e.g., `cicd-uat@yourdomain.com`)
- `SF_UAT_INSTANCE_URL`: `login.salesforce.com`

### 6. Test Authentication

**Test PROD Authentication:**
```bash
# Create temporary key file
echo "$SF_PROD_JWT_KEY" > temp_key.key

# Test JWT login
sf org login jwt \
  --client-id "$SF_PROD_CLIENT_ID" \
  --jwt-key-file temp_key.key \
  --username "$SF_PROD_USERNAME" \
  --instance-url "https://login.salesforce.com" \
  --alias prod-test

# Verify connection
sf org display --target-org prod-test

# Clean up
rm temp_key.key
```

**Test UAT Authentication:**
```bash
# Same steps but with UAT credentials
echo "$SF_UAT_JWT_KEY" > temp_key.key

sf org login jwt \
  --client-id "$SF_UAT_CLIENT_ID" \
  --jwt-key-file temp_key.key \
  --username "$SF_UAT_USERNAME" \
  --instance-url "https://login.salesforce.com" \
  --alias uat-test

sf org display --target-org uat-test

rm temp_key.key
```

## Permission Set Details

The `CI_CD_Deployment` permission set grants the following permissions:

| Permission | Purpose |
|------------|---------|
| ApiEnabled | Required for CLI/API access |
| AuthorApex | Deploy Apex classes and triggers |
| ModifyAllData | Deploy data-related metadata |
| ViewAllData | Read org data during deployment |
| ViewSetup | Access Setup menu for metadata operations |
| ModifyMetadata | Deploy all metadata types |
| ManageCustomPermissions | Deploy custom permissions |

## Workflows

### deploy-prod.yml
- **Trigger**: Manual (workflow_dispatch)
- **Branch**: main only
- **Environment**: Production
- **Test Level**: RunLocalTests (always)

### deploy-uat.yml
- **Trigger**: Manual (workflow_dispatch)
- **Branch**: main only
- **Environment**: UAT
- **Test Level**: Configurable (default: RunLocalTests)

## Troubleshooting

### Authentication Fails
1. Verify the integration user has the `CI_CD_Deployment` permission set assigned
2. Verify the `CI_CD_Deployment` permission set is added to the Connected App
3. Check that the Connected App certificate matches the private key
4. Ensure OAuth policies don't have unnecessary requirements enabled (Web Server Flow, Refresh Token, PKCE)

### Deployment Fails
1. Check if the user has sufficient permissions in the permission set
2. Verify the org is unlocked (not in maintenance mode)
3. Check for validation errors in the GitHub Actions logs

### Connected App Access Issues
1. Verify "Permitted Users" is set to "Admin approved users are pre-authorized"
2. Ensure the integration user has the permission set (not just the profile)
3. Confirm no IP restrictions are blocking GitHub Actions IPs

## Security Best Practices

✅ **Do:**
- Use dedicated integration users for each environment
- Keep JWT private keys secure in GitHub Secrets
- Use minimal permissions (Minimum Access profile + specific permission set)
- Rotate certificates periodically
- Review deployment logs regularly
- Use permission sets (not profiles) for Connected App access

❌ **Don't:**
- Use personal user accounts for CI/CD
- Commit private keys to the repository
- Grant System Administrator profile to integration users
- Share credentials between environments
- Skip test execution in production deployments
- Use profiles for Connected App access control

## Maintenance

### Rotating JWT Certificate
1. Generate new certificate and private key
2. Update Connected App with new certificate in both orgs
3. Update GitHub secrets with new private key
4. Test authentication before deleting old certificate

### Adding New Permissions
1. Update `CI_CD_Deployment.permissionset-meta.xml`
2. Commit to repository
3. Deploy to PROD and UAT
4. Verify permissions via Setup > Permission Sets

### Audit Integration User Activity
1. Setup > Users > Your integration user
2. Click "Login History" to see authentication attempts
3. Setup > Deployment Status to see deployment history

## References

- [Salesforce JWT Bearer Flow](https://help.salesforce.com/s/articleView?id=sf.remoteaccess_oauth_jwt_flow.htm)
- [Salesforce CLI Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

---

**Document Version**: 1.0  
**Last Updated**: April 18, 2026  
**Maintained By**: CI/CD Team