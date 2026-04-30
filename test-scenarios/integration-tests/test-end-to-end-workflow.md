# Test: End-to-End Workflow

## Purpose
Verify that Bob can handle a complete, realistic workflow involving multiple tools, mode switches, and complex operations.

## Scenario
Create a simple web project with HTML, CSS, and JavaScript files, then test and document it.

## Prerequisites
- Bob sandbox environment set up
- All custom modes available
- Test mode active initially

## Test Steps

### Phase 1: Project Setup (Test Mode)

#### Step 1: Switch to Test Mode
1. Click mode indicator
2. Select "🧪 Test"

**Expected Result:** Test mode active

**Actual Result:** _[Fill in after testing]_

---

#### Step 2: Create Project Structure

Ask Bob: "Create the following directory structure in bob-sandbox:
- web-project/
  - css/
  - js/
  - docs/"

**Expected Result:** All directories created

**Actual Result:** _[Fill in after testing]_

---

#### Step 3: Create HTML File

Ask Bob: "Create bob-sandbox/web-project/index.html with a basic HTML5 template that includes:
- A header with 'My Web Project'
- A main section with a button id='testButton'
- Links to css/style.css and js/script.js"

**Expected Result:** Valid HTML file created

**Actual Result:** _[Fill in after testing]_

---

#### Step 4: Verify HTML Content

Ask Bob: "Read bob-sandbox/web-project/index.html and verify it has all required elements"

**Expected Result:** 
- File contains header, button, and links
- HTML is well-formed

**Actual Result:** _[Fill in after testing]_

---

### Phase 2: Add Styling (Test Mode)

#### Step 5: Create CSS File

Ask Bob: "Create bob-sandbox/web-project/css/style.css with styles for:
- Body: centered content, nice font
- Header: large text, colored background
- Button: styled with hover effect"

**Expected Result:** CSS file created with styles

**Actual Result:** _[Fill in after testing]_

---

#### Step 6: Verify CSS

Ask Bob: "Read bob-sandbox/web-project/css/style.css and check if all styles are present"

**Expected Result:** All requested styles present

**Actual Result:** _[Fill in after testing]_

---

### Phase 3: Add Interactivity (Test Mode)

#### Step 7: Create JavaScript File

Ask Bob: "Create bob-sandbox/web-project/js/script.js that:
- Adds a click event listener to the button
- Shows an alert when clicked
- Logs to console"

**Expected Result:** JavaScript file created with functionality

**Actual Result:** _[Fill in after testing]_

---

#### Step 8: Verify JavaScript

Ask Bob: "Read bob-sandbox/web-project/js/script.js and verify the event listener is properly implemented"

**Expected Result:** Code is syntactically correct

**Actual Result:** _[Fill in after testing]_

---

### Phase 4: Testing and Debugging (Debug Mode)

#### Step 9: Switch to Debug Mode

1. Click mode indicator
2. Select "🐛 Debug"

**Expected Result:** Debug mode active

**Actual Result:** _[Fill in after testing]_

---

#### Step 10: Analyze Project Structure

Ask Bob: "List all files in bob-sandbox/web-project/ recursively and show their sizes"

**Expected Result:** 
- All files listed
- Sizes shown
- Structure verified

**Actual Result:** _[Fill in after testing]_

---

#### Step 11: Search for Potential Issues

Ask Bob: "Search for 'TODO' or 'FIXME' comments in all bob-sandbox/web-project/ files"

**Expected Result:** 
- Search completes
- Any TODOs found and reported

**Actual Result:** _[Fill in after testing]_

---

#### Step 12: Validate HTML Structure

Ask Bob: "Read bob-sandbox/web-project/index.html and check for:
- Proper DOCTYPE
- Closed tags
- Valid attribute syntax"

**Expected Result:** HTML validation report

**Actual Result:** _[Fill in after testing]_

---

### Phase 5: Enhancement (Experimental Mode)

#### Step 13: Switch to Experimental Mode

1. Click mode indicator
2. Select "🚀 Experimental"

**Expected Result:** Experimental mode active

**Actual Result:** _[Fill in after testing]_

---

#### Step 14: Add Advanced Feature

Ask Bob: "Enhance bob-sandbox/web-project/js/script.js to:
- Add a counter that increments on each click
- Display the count on the page
- Store count in localStorage"

**Expected Result:** 
- JavaScript enhanced with new features
- Code is functional

**Actual Result:** _[Fill in after testing]_

---

#### Step 15: Verify Enhancement

Ask Bob: "Read the updated bob-sandbox/web-project/js/script.js and explain the new functionality"

**Expected Result:** 
- New code present
- Explanation provided
- Logic is sound

**Actual Result:** _[Fill in after testing]_

---

### Phase 6: Documentation (Test Mode)

#### Step 16: Switch Back to Test Mode

1. Click mode indicator
2. Select "🧪 Test"

**Expected Result:** Test mode active

**Actual Result:** _[Fill in after testing]_

---

#### Step 17: Create README

Ask Bob: "Create bob-sandbox/web-project/README.md with:
- Project title and description
- File structure explanation
- How to use the project
- Features list"

**Expected Result:** Comprehensive README created

**Actual Result:** _[Fill in after testing]_

---

#### Step 18: Create Technical Documentation

Ask Bob: "Create bob-sandbox/web-project/docs/TECHNICAL.md documenting:
- HTML structure
- CSS architecture
- JavaScript functionality
- Browser compatibility notes"

**Expected Result:** Technical documentation created

**Actual Result:** _[Fill in after testing]_

---

### Phase 7: Final Verification

#### Step 19: Complete Project Review

Ask Bob: "Perform a complete review of the web-project:
1. List all files
2. Read each file
3. Verify all links and references are correct
4. Check for any issues"

**Expected Result:** 
- Comprehensive review completed
- All files verified
- Issues identified (if any)

**Actual Result:** _[Fill in after testing]_

---

#### Step 20: Create Project Summary

Ask Bob: "Create bob-sandbox/web-project/PROJECT-SUMMARY.md with:
- What was built
- Technologies used
- Testing performed
- Any issues encountered
- Next steps"

**Expected Result:** Summary document created

**Actual Result:** _[Fill in after testing]_

---

### Phase 8: Cleanup

#### Step 21: Archive Project

Ask Bob: "Create a summary of the web-project in bob-sandbox/web-project-archive.txt, then delete the web-project directory"

**Expected Result:** 
- Summary created
- Project directory deleted

**Actual Result:** _[Fill in after testing]_

---

## Summary

### Workflow Metrics
- **Total Steps:** 21
- **Mode Switches:** 4
- **Files Created:** ~7
- **Tools Used:** write_to_file, read_file, list_files, search_files, apply_diff
- **Time Taken:** _[Fill in]_

### Test Results
- [ ] Complete workflow executed successfully
- [ ] Some steps failed (document below)
- [ ] Workflow incomplete

### Mode Effectiveness
**Test Mode:**
- Strengths: _[Fill in]_
- Limitations: _[Fill in]_

**Debug Mode:**
- Strengths: _[Fill in]_
- Limitations: _[Fill in]_

**Experimental Mode:**
- Strengths: _[Fill in]_
- Limitations: _[Fill in]_

### Issues Found
_[Document any issues discovered during testing]_

### Performance Notes
_[Note any performance issues or bottlenecks]_

### User Experience
_[Comment on the overall experience of the workflow]_

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
- **Duration:** _[Fill in]_