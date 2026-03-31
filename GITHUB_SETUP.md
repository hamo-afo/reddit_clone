# GitHub Setup & Deployment Guide

Follow this guide to prepare your Reddit Tutorial app for GitHub and push it successfully while protecting sensitive information.

## 🔍 Pre-Push Checklist

### 1. Verify Sensitive Files Are Ignored

Before pushing, ensure these files are **NOT** in your repository:

**⚠️ CRITICAL - Never commit these:**

```
android/app/google-services.json          ← Firebase Android config
lib/firebase_options.dart                  ← Firebase settings
android/local.properties                   ← Local build configuration
.env, .env.local, .env.*.local            ← Environment variables
build/                                     ← Build output
.dart_tool/                                ← Dart cache
```

**Verify they're in .gitignore:** Check `.gitignore` contains these entries.

### 2. Clean Up Before Pushing

From the project root, run these commands:

```bash
# Remove build artifacts (safe to delete)
flutter clean
rm -r build .dart_tool (Windows: rmdir /s build .dart_tool)

# Check git status - should NOT show sensitive files
git status
```

**❌ If you see sensitive files in git status:**

```bash
# Remove from git tracking (but keep locally)
git rm --cached android/app/google-services.json
git rm --cached lib/firebase_options.dart
git rm --cached android/local.properties

# Commit the removal
git commit -m "Remove sensitive files from tracking"
```

### 3. Check for Existing Secret History

⚠️ If sensitive files were committed previously:

```bash
# View git history
git log --all --full-history -- android/app/google-services.json

# If found, you MUST:
# 1. Rotate all API keys in Firebase Console
# 2. Regenerate OAuth clients
# 3. Consider rewriting git history (advanced)
```

## 🚀 Initial Push to GitHub

### Step 1: Create GitHub Repository

1. Go to [github.com/new](https://github.com/new)
2. Enter repository name: `reddit_tutorial`
3. **Choose: Private** (recommended for learning projects with credentials)
4. **Do NOT** initialize with README (you already have one)
5. Click **Create repository**

### Step 2: Add Remote & Push

```bash
# Navigate to project
cd reddit_tutorial

# Add GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/reddit_tutorial.git

# Or if using SSH (requires setup):
git remote add origin git@github.com:YOUR_USERNAME/reddit_tutorial.git

# Verify remote
git remote -v
```

### Step 3: Push to GitHub

```bash
# Create and switch to main branch (if not already)
git branch -M main

# Push all branches and tags
git push -u origin main

# Verify successful push
git log --oneline -5
```

## 📋 Post-Push Tasks

### 1. Set Repository Visibility

In GitHub repository settings:

- **Settings → Visibility** → Choose:
  - **Public**: For tutorials/portfolios
  - **Private**: For projects with any sensitive data risk

### 2. Configure Branch Protection (Optional)

1. **Settings → Branches → Add Branch Protection**
2. Enter: `main`
3. Enable:
   - ✅ Require pull request reviews before merging
   - ✅ Dismiss stale reviews
   - ✅ Require status checks to pass

### 3. Add Code Owners (Optional)

Create `.github/CODEOWNERS`:

```
* @YOUR_USERNAME
```

### 4. Enable Security Features

**Settings → Security & Analysis:**

- ✅ Enable Dependabot alerts
- ✅ Enable Dependabot security updates
- ✅ Enable secret scanning

## 🔐 Securing Secrets in GitHub

### Never Store Secrets in Repository

❌ **NEVER do:**

```dart
// ❌ BAD - Don't hardcode secrets
const apiKey = "AIzaSyDxxxxxxxxxxxxxx";
```

### Use GitHub Secrets for CI/CD

If you need secrets for GitHub Actions:

1. **Settings → Secrets and variables → Actions**
2. **New repository secret:**
   - Name: `FIREBASE_JSON`
   - Value: (base64 encoded google-services.json content)

### Example GitHub Actions Workflow

Create `.github/workflows/flutter_test.yml`:

```yaml
name: Flutter Build & Test

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.5.0"

      - name: Install dependencies
        run: flutter pub get

      - name: Analyze
        run: flutter analyze

      - name: Run tests
        run: flutter test
```

## 📝 Template Files for Users

Create `android/app/google-services.json.example`:

```json
{
  "type": "service_account",
  "project_id": "YOUR_PROJECT_ID",
  "private_key_id": "KEY_ID_HERE",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-xxxxx@YOUR_PROJECT_ID.iam.gserviceaccount.com",
  "client_id": "YOUR_CLIENT_ID",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs"
}
```

This file is already committed and shows the structure without actual secrets.

## 🔄 Future Pushes

For subsequent updates:

```bash
# Check status
git status

# Verify no secrets will be committed
git diff --name-only

# Stage changes
git add .

# Commit
git commit -m "Description of changes"

# Push
git push origin main
```

## 🚨 If You Accidentally Committed Secrets

**Immediate Action Required:**

1. **Rotate all credentials** in Firebase Console immediately
2. **Regenerate API keys** and OAuth clients
3. **Remove from history:**

```bash
# Install BFG Repo Cleaner
# (Download from: https://rtyley.github.io/bfg-repo-cleaner/)

# Remove file from all history
bfg --delete-files google-services.json

# Clean git refs
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Force push (WARNING: rewrites history)
git push --force-with-lease origin main
```

## ✅ Verification Checklist

Before marking project as ready:

- [ ] All sensitive files are in `.gitignore`
- [ ] `git status` shows no secret files
- [ ] `.gitignore` is committed to repository
- [ ] `README.md` has setup instructions
- [ ] `SHORT_README.md` is present
- [ ] `SECRETS_SETUP.md` explains how to add secrets locally
- [ ] `google-services.json.example` shows structure
- [ ] Repository is on GitHub
- [ ] No API keys in git log: `git log -p | grep -i "key\|secret\|token"`

## 📚 Additional Resources

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Docs - Managing Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Git BFG - Remove Sensitive Data](https://rtyley.github.io/bfg-repo-cleaner/)
- [OWASP - Secrets Management](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)

## 🆘 Troubleshooting

### "fatal: 'origin' does not appear to be a 'git' repository"

**Solution:**

```bash
git remote add origin https://github.com/YOUR_USERNAME/reddit_tutorial.git
```

### "Permission denied (publickey)"

**Solution:** Use HTTPS instead of SSH:

```bash
git remote set-url origin https://github.com/YOUR_USERNAME/reddit_tutorial.git
```

### "refusing to merge unrelated histories"

**Solution:**

```bash
git pull origin main --allow-unrelated-histories
```

### "Updates were rejected because the remote contains work that you do not have locally"

**Solution:**

```bash
git pull origin main
git push origin main
```

---

**Need help?** Refer to `.github/` folder for templates or check GitHub documentation.

**Last Updated**: March 2026
