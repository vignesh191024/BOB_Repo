# Test: File Operations

## Purpose
Verify that all file operation tools work correctly: read_file, write_to_file, apply_diff, insert_content, list_files, and search_files.

## Prerequisites
- Bob sandbox environment set up
- Test mode or Debug mode active
- Write permissions in bob-sandbox directory

## Test Steps

### Step 1: Test write_to_file (Create New File)

Ask Bob: "Create a new file at bob-sandbox/test-scenarios/tool-tests/sample.txt with the following content:
```
Line 1: Hello World
Line 2: This is a test
Line 3: Testing file operations
```"

**Expected Result:** 
- File created successfully
- Confirmation message with line count

**Actual Result:** _[Fill in after testing]_

---

### Step 2: Test read_file (Full Read)

Ask Bob: "Read the file bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
- All 3 lines displayed
- Line numbers shown
- Content matches what was written

**Actual Result:** _[Fill in after testing]_

---

### Step 3: Test read_file (Partial Read with Line Range)

Ask Bob: "Read lines 1-2 of bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
- Only lines 1-2 displayed
- Line 3 not shown

**Actual Result:** _[Fill in after testing]_

---

### Step 4: Test apply_diff (Modify Existing Content)

Ask Bob: "Use apply_diff to change 'Hello World' to 'Hello Bob' in bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
- Diff applied successfully
- Line 1 now reads "Line 1: Hello Bob"
- Other lines unchanged

**Actual Result:** _[Fill in after testing]_

---

### Step 5: Verify apply_diff Changes

Ask Bob: "Read bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
```
Line 1: Hello Bob
Line 2: This is a test
Line 3: Testing file operations
```

**Actual Result:** _[Fill in after testing]_

---

### Step 6: Test insert_content (Add at Beginning)

Ask Bob: "Insert 'Line 0: Header' at line 1 of bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
- New line inserted at beginning
- Existing lines shifted down

**Actual Result:** _[Fill in after testing]_

---

### Step 7: Verify insert_content at Beginning

Ask Bob: "Read bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
```
Line 0: Header
Line 1: Hello Bob
Line 2: This is a test
Line 3: Testing file operations
```

**Actual Result:** _[Fill in after testing]_

---

### Step 8: Test insert_content (Add at End)

Ask Bob: "Insert 'Line 4: Footer' at line 0 (end of file) of bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
- New line appended to end
- Existing lines unchanged

**Actual Result:** _[Fill in after testing]_

---

### Step 9: Verify insert_content at End

Ask Bob: "Read bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
```
Line 0: Header
Line 1: Hello Bob
Line 2: This is a test
Line 3: Testing file operations
Line 4: Footer
```

**Actual Result:** _[Fill in after testing]_

---

### Step 10: Test list_files (Non-Recursive)

Ask Bob: "List files in bob-sandbox/test-scenarios/tool-tests/ (non-recursive)"

**Expected Result:** 
- Shows files in tool-tests directory
- Does not show subdirectories' contents
- Includes sample.txt

**Actual Result:** _[Fill in after testing]_

---

### Step 11: Test list_files (Recursive)

Ask Bob: "List all files in bob-sandbox/test-scenarios/ recursively"

**Expected Result:** 
- Shows all files in test-scenarios and subdirectories
- Includes files from mode-tests, tool-tests, integration-tests
- Hierarchical structure visible

**Actual Result:** _[Fill in after testing]_

---

### Step 12: Test search_files

Ask Bob: "Search for the word 'test' in bob-sandbox/test-scenarios/tool-tests/ files"

**Expected Result:** 
- Finds matches in sample.txt
- Shows context around matches
- Line numbers included

**Actual Result:** _[Fill in after testing]_

---

### Step 13: Test search_files with Regex

Ask Bob: "Search for lines starting with 'Line [0-9]:' in bob-sandbox/test-scenarios/tool-tests/sample.txt using regex"

**Expected Result:** 
- Finds all 5 lines matching pattern
- Shows matches with context

**Actual Result:** _[Fill in after testing]_

---

### Step 14: Test write_to_file (Overwrite Existing)

Ask Bob: "Overwrite bob-sandbox/test-scenarios/tool-tests/sample.txt with:
```
New content
Completely replaced
```"

**Expected Result:** 
- File overwritten
- Old content gone
- New content in place

**Actual Result:** _[Fill in after testing]_

---

### Step 15: Verify Overwrite

Ask Bob: "Read bob-sandbox/test-scenarios/tool-tests/sample.txt"

**Expected Result:** 
```
New content
Completely replaced
```

**Actual Result:** _[Fill in after testing]_

---

### Step 16: Test Multiple File Operations

Ask Bob: "Create three files:
1. bob-sandbox/test-scenarios/tool-tests/file1.txt with 'Content 1'
2. bob-sandbox/test-scenarios/tool-tests/file2.txt with 'Content 2'
3. bob-sandbox/test-scenarios/tool-tests/file3.txt with 'Content 3'"

**Expected Result:** All three files created successfully

**Actual Result:** _[Fill in after testing]_

---

### Step 17: Test read_file with Multiple Files

Ask Bob: "Read all three files: file1.txt, file2.txt, and file3.txt from bob-sandbox/test-scenarios/tool-tests/"

**Expected Result:** 
- All three files read in one operation
- Contents displayed for each
- Efficient single request

**Actual Result:** _[Fill in after testing]_

---

### Step 18: Test Edge Cases - Empty File

Ask Bob: "Create an empty file at bob-sandbox/test-scenarios/tool-tests/empty.txt"

**Expected Result:** Empty file created

**Actual Result:** _[Fill in after testing]_

---

### Step 19: Test Edge Cases - Large Content

Ask Bob: "Create a file with 100 lines of content at bob-sandbox/test-scenarios/tool-tests/large.txt"

**Expected Result:** 
- File created successfully
- All 100 lines written

**Actual Result:** _[Fill in after testing]_

---

### Step 20: Cleanup

Ask Bob: "Delete all test files: sample.txt, file1.txt, file2.txt, file3.txt, empty.txt, and large.txt from bob-sandbox/test-scenarios/tool-tests/"

**Expected Result:** All test files deleted

**Actual Result:** _[Fill in after testing]_

---

## Summary

### Test Results
- [ ] All file operations work correctly
- [ ] Some operations failed (document below)
- [ ] Test incomplete

### Performance Notes
_[Note any performance issues with large files or multiple operations]_

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