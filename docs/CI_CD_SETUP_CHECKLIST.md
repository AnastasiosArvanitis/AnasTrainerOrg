# CI/CD Setup Checklist

Use this checklist to track your progress in setting up secure CI/CD deployment.

## ✅ Completed Steps

- [x] Create `CI_CD_Deployment` permission set metadata
- [x] Create dedicated integration users in both orgs
- [x] Create documentation

## 🔄 Your Next Steps

### 1. Deploy Permission Set
- [ ] Deploy permission set to PROD org
  ```bash
  sf project deploy start --source-dir force-app/main/default/permissionsets -o prod-alias
  ```
- [ ] Deploy permission set to UAT org
  ```bash
  sf project deploy start --source-dir force-app/main/default/permissionsets -o uat-alias
  ```

### 2. Assign Permission Set to Users
- [ ] **PROD**: Setup > Users > Integration User > Permission Set Assignments > Assign "CI/CD Deployment"
- [ ] **UAT**: Setup > Users > Integration User > Permission Set Assignments > Assign "CI/CD Deployment"

### 3. Configure Connected Apps
- [ ] **PROD**: Setup > App Manager > Connected App > Manage > **Manage Permission Sets** > Add "CI/CD Deployment"
- [ ] **UAT**: Setup > App Manager > Connected App > Manage > **Manage Permission Sets** > Add "CI/CD Deployment"

### 4. Fix Connected App OAuth Settings (if needed)
- [ ] **PROD**: Edit Policies > **UNCHECK** these if checked:
  - [ ] Require secret for Web Server Flow
  - [ ] Require secret for Refresh Token Flow
  - [ ] Require Proof Key for Code Exchange (PKCE)
- [ ] **UAT**: Same as PROD

### 5. Update GitHub Secrets
- [ ] Add/Update PROD secrets:
  - [ ] `SF_PROD_CLIENT_ID`
  - [ ] `SF_PROD_JWT_KEY`
  - [ ] `SF_PROD_USERNAME`
  - [ ] `SF_PROD_INSTANCE_URL`
- [ ] Add/Update UAT secrets:
  - [ ] `SF_UAT_CLIENT_ID`
  - [ ] `SF_UAT_JWT_KEY`
  - [ ] `SF_UAT_USERNAME`
  - [ ] `SF_UAT_INSTANCE_URL`

### 6. Test Authentication
- [ ] Test PROD authentication locally (see CI_CD_SETUP.md for commands)
- [ ] Test UAT authentication locally
- [ ] Verify integration user can log in via JWT

### 7. Test Deployment Workflows
- [ ] Trigger deploy-prod.yml workflow manually
- [ ] Verify deployment succeeds with new integration user
- [ ] Trigger deploy-uat.yml workflow manually
- [ ] Verify UAT deployment succeeds

### 8. Security Verification
- [ ] Confirm System Administrator profile CANNOT authenticate via Connected App
- [ ] Confirm only integration users with permission set CAN authenticate
- [ ] Review integration user login history
- [ ] Document setup in team wiki/docs

## 📋 Information You'll Need

### From Connected App (both orgs):
- Consumer Key (Client ID)
- Certificate's private key file content

### Integration User Details:
- PROD username: `_________________`
- UAT username: `_________________`

## 🔍 Quick Verification Commands

```bash
# Verify permission set is deployed
sf org list metadata --metadata-type PermissionSet -o <org-alias>

# Check org connection
sf org display -o <org-alias>

# Test JWT authentication
sf org login jwt --client-id <CLIENT_ID> --jwt-key-file <KEY_FILE> --username <USERNAME> --instance-url https://login.salesforce.com
```

## ❓ Need Help?

Refer to `docs/CI_CD_SETUP.md` for:
- Detailed step-by-step instructions
- Troubleshooting guide
- Security best practices
- Command examples

---

**Good luck with your setup! 🚀**