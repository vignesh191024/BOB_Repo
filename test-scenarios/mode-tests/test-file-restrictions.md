# Test: File Access Restrictions

## Purpose
Verify that Test mode's file editing restrictions work correctly and only allow editing files within the bob-sandbox directory.

## Prerequisites
- Bob sandbox environment set up
- Custom modes loaded
- Test mode available
- Sample files created both inside and outside bob-sandbox/

## Test Steps

### Step 1: Create Test Files

**Inside sandbox:**
Ask Bob: "Create a test file at bob-sandbox/test-scenarios/test-file-inside.txt with content 'This is inside the sandbox'"

**Expected Result:** File created successfully

**Actual Result:** _[Fill in after testing]_

---

**Outside sandbox:**
Ask Bob: "Create a test file at test-file-outside.txt (in workspace root) with content 'This is outside the sandbox'"

**Expected Result:** File created successfully (we're not in Test mode yet)

**Actual Result:** _[Fill in after testing]_

---

### Step 2: Switch to Test Mode
1. Click mode indicator
2. Select "🧪 Test"
3. Verify mode switch

**Expected Result:** Status bar shows "🧪 Test"

**Actual Result:** _[Fill in after testing]_

---

### Step 3: Test Reading Files (Should Work)

**Read inside sandbox:**
Ask Bob: "Read the file bob-sandbox/test-scenarios/test-file-inside.txt"

**Expected Result:** File contents displayed successfully

**Actual Result:** _[Fill in after testing]_

---

**Read outside sandbox:**
Ask Bob: "Read the file test-file-outside.txt"

**Expected Result:** File contents displayed successfully (reading is not restricted)

**Actual Result:** _[Fill in after testing]_

---

### Step 4: Test Editing Inside Sandbox (Should Work)

Ask Bob: "Append the line 'Modified in Test mode' to bob-sandbox/test-scenarios/test-file-inside.txt"

**Expected Result:** 
- File modified successfully
- No errors or warnings
- Confirmation of changes

**Actual Result:** _[Fill in after testing]_

---

### Step 5: Verify Edit Inside Sandbox

Ask Bob: "Read bob-sandbox/test-scenarios/test-file-inside.txt and show me the contents"

**Expected Result:** 
File contains:
```
This is inside the sandbox
Modified in Test mode
```

**Actual Result:** _[Fill in after testing]_

---

### Step 6: Test Editing Outside Sandbox (Should Fail)

Ask Bob: "Append the line 'Modified in Test mode' to test-file-outside.txt"

**Expected Result:** 
- Operation denied or warning issued
- Bob explains file is outside allowed scope
- File remains unchanged

**Actual Result:** _[Fill in after testing]_

---

### Step 7: Verify Edit Was Blocked

Ask Bob: "Read test-file-outside.txt and show me the contents"

**Expected Result:** 
File contains only:
```
This is outside the sandbox
```
(No modification occurred)

**Actual Result:** _[Fill in after testing]_

---

### Step 8: Test Creating Files Inside Sandbox

Ask Bob: "Create a new file at bob-sandbox/test-scenarios/new-file-inside.txt with content 'Created in Test mode'"

**Expected Result:** File created successfully

**Actual Result:** _[Fill in after testing]_

---

### Step 9: Test Creating Files Outside Sandbox

Ask Bob: "Create a new file at new-file-outside.txt with content 'Created in Test mode'"

**Expected Result:** 
- Operation denied or warning issued
- File not created

**Actual Result:** _[Fill in after testing]_

---

### Step 10: Switch to Debug Mode and Verify Unrestricted Access

1. Switch to Debug mode
2. Ask Bob: "Append 'Modified in Debug mode' to test-file-outside.txt"
3. Ask Bob: "Read test-file-outside.txt"

**Expected Result:** 
- Edit succeeds in Debug mode
- File now contains both original and new content

**Actual Result:** _[Fill in after testing]_

---

### Step 11: Test Edge Cases

**Test with relative paths:**
Ask Bob (in Test mode): "Edit ../test-file-outside.txt"

**Expected Result:** Operation denied (path escapes sandbox)

**Actual Result:** _[Fill in after testing]_

---

**Test with absolute paths:**
Ask Bob (in Test mode): "Edit C:/Users/VigneshB/BOB/test-file-outside.txt"

**Expected Result:** Operation denied (not in sandbox)

**Actual Result:** _[Fill in after testing]_

---

### Step 12: Cleanup

1. Switch to Debug mode (unrestricted)
2. Ask Bob: "Delete test-file-outside.txt, new-file-outside.txt (if exists), bob-sandbox/test-scenarios/test-file-inside.txt, and bob-sandbox/test-scenarios/new-file-inside.txt"

**Expected Result:** All test files deleted

**Actual Result:** _[Fill in after testing]_

---

## Summary

### Test Results
- [ ] All restrictions work as expected
- [ ] Some restrictions failed (document below)
- [ ] Test incomplete

### Issues Found
_[Document any issues discovered during testing]_

### Security Concerns
_[Note any security implications of findings]_

### Notes
_[Additional observations or comments]_

### Recommendations
_[Suggestions for improvements based on test results]_

---

## Test Metadata
- **Test Date:** _[Fill in]_
- **Tester:** _[Fill in]_
- **Bob Version:** _[Fill in]_
- **VS Code Version:** _[Fill in]_