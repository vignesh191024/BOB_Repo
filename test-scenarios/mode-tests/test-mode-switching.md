# Test: Mode Switching

## Purpose
Verify that switching between custom modes works correctly and that each mode has the expected capabilities.

## Prerequisites
- Bob sandbox environment set up
- Custom modes loaded from `.bob/custom_modes.yaml`
- VS Code opened with bob-sandbox as workspace

## Test Steps

### Step 1: Verify Initial Mode
1. Open VS Code with bob-sandbox workspace
2. Check the mode indicator in the status bar
3. Note the current mode

**Expected Result:** Default mode is displayed (e.g., Code mode)

**Actual Result:** _[Fill in after testing]_

---

### Step 2: Switch to Test Mode
1. Click the mode indicator in the status bar
2. Select "🧪 Test" from the mode switcher
3. Verify the status bar updates

**Expected Result:** 
- Status bar shows "🧪 Test"
- Mode switcher closes

**Actual Result:** _[Fill in after testing]_

---

### Step 3: Verify Test Mode Identity
Ask Bob: "What mode are you in? What are your capabilities?"

**Expected Result:**
Bob should respond with:
- Current mode: Test
- Capabilities: read files, edit files (restricted to bob-sandbox/), execute commands
- Restrictions: Cannot edit files outside bob-sandbox/

**Actual Result:** _[Fill in after testing]_

---

### Step 4: Switch to Debug Mode
1. Click the mode indicator
2. Select "🐛 Debug" from the mode switcher
3. Verify the status bar updates

**Expected Result:**
- Status bar shows "🐛 Debug"
- Mode switcher closes

**Actual Result:** _[Fill in after testing]_

---

### Step 5: Verify Debug Mode Identity
Ask Bob: "What mode are you in? What are your capabilities?"

**Expected Result:**
Bob should respond with:
- Current mode: Debug
- Capabilities: read files, edit files (unrestricted), execute commands, browser actions
- Focus: Troubleshooting and debugging

**Actual Result:** _[Fill in after testing]_

---

### Step 6: Switch to Experimental Mode
1. Click the mode indicator
2. Select "🚀 Experimental" from the mode switcher
3. Verify the status bar updates

**Expected Result:**
- Status bar shows "🚀 Experimental"
- Mode switcher closes

**Actual Result:** _[Fill in after testing]_

---

### Step 7: Verify Experimental Mode Identity
Ask Bob: "What mode are you in? What are your capabilities?"

**Expected Result:**
Bob should respond with:
- Current mode: Experimental
- Capabilities: All tools including MCP
- Focus: Innovation and rapid prototyping

**Actual Result:** _[Fill in after testing]_

---

### Step 8: Rapid Mode Switching
1. Switch from Experimental to Test
2. Immediately switch from Test to Debug
3. Immediately switch from Debug to Experimental

**Expected Result:**
- Each switch completes successfully
- No errors or delays
- Status bar updates correctly each time

**Actual Result:** _[Fill in after testing]_

---

### Step 9: Verify Mode Persistence
1. Switch to Test mode
2. Close VS Code
3. Reopen VS Code with bob-sandbox workspace
4. Check current mode

**Expected Result:**
- Mode persists across VS Code restarts
- OR defaults to a standard mode (implementation-dependent)

**Actual Result:** _[Fill in after testing]_

---

## Summary

### Test Results
- [ ] All steps passed
- [ ] Some steps failed (document below)
- [ ] Test incomplete

### Issues Found
_[Document any issues discovered during testing]_

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