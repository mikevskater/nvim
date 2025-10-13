# SQL Snippets Reference Guide

Quick reference for custom SQL snippets (similar to Redgate SQL Prompt)

## 🚀 How to Use

1. Type the snippet prefix (e.g., `ss`, `ij`, `cte`)
2. The autocomplete menu will show the snippet
3. Press `<Tab>` or `<CR>` to expand
4. Use `<Tab>` to jump between placeholders
5. Use `<Shift-Tab>` to jump back

## 📋 Available Snippets

### Basic SELECT Statements
| Prefix | Description |
|--------|-------------|
| `ss` | SELECT * with WHERE clause |
| `ssc` | SELECT specific columns |
| `sst` | SELECT TOP N (SQL Server) |

### JOINs
| Prefix | Description |
|--------|-------------|
| `ij` | INNER JOIN |
| `lj` | LEFT JOIN |

### Data Modification
| Prefix | Description |
|--------|-------------|
| `ii` | INSERT INTO |
| `upd` | UPDATE statement |
| `del` | DELETE statement |

### DDL & Schema
| Prefix | Description |
|--------|-------------|
| `ct` | CREATE TABLE |
| `sp` | CREATE PROCEDURE |

### Control Flow
| Prefix | Description |
|--------|-------------|
| `bt` | BEGIN/COMMIT TRANSACTION |
| `try` | TRY/CATCH block with transaction |
| `ife` | IF EXISTS block |
| `case` | CASE statement |

### Advanced Queries
| Prefix | Description |
|--------|-------------|
| `cte` | Common Table Expression (WITH) |
| `sit` | SELECT INTO temp table |
| `gbh` | GROUP BY with HAVING |
| `wf` | Window function (ROW_NUMBER, etc.) |

### Utilities
| Prefix | Description |
|--------|-------------|
| `dec` | DECLARE variable |
| `cb` | Comment block |

## ✏️ Adding Your Own Snippets

Edit: `~\AppData\Local\nvim\snippets\sql.json`

### Snippet Format
```json
{
  "Snippet Name": {
    "prefix": "shortcut",
    "body": [
      "Line 1 with ${1:placeholder}",
      "Line 2 with ${2:another_placeholder}",
      "Line 3 ends here$0"
    ],
    "description": "What this snippet does"
  }
}
```

### Placeholder Syntax
- `${1:default_text}` - First tab stop with default text
- `${2:}` - Second tab stop (empty)
- `$0` - Final cursor position after all tab stops
- `${1:table_name}` - Multiple references to same placeholder will update together

## 🎯 Tips

1. **Redgate-style shortcuts**: Use short, memorable prefixes (2-3 chars)
2. **Tab stops**: Number them logically (1, 2, 3...) in the order you'll fill them
3. **Default values**: Provide helpful default text in placeholders
4. **Final position**: Always end with `$0` for where the cursor should land
5. **Multi-line**: Use array format for better readability

## 🔥 Examples

### Example 1: Quick SELECT
Type `ss` → Tab → Enter table name → Tab → Enter condition

```sql
SELECT *
FROM users
WHERE status = 'active'
```

### Example 2: CTE Query
Type `cte` → Tab → Name the CTE → Tab through fields

```sql
WITH ActiveUsers AS (
    SELECT
        user_id, email
    FROM users
    WHERE status = 'active'
)
SELECT *
FROM ActiveUsers
```

### Example 3: Try/Catch Transaction
Type `try` → Tab → Add your SQL

```sql
BEGIN TRY
    BEGIN TRANSACTION
    
    UPDATE accounts SET balance = balance - 100 WHERE id = 1
    UPDATE accounts SET balance = balance + 100 WHERE id = 2
    
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION
    
    THROW
END CATCH
```

## 🎨 Creating Complex Snippets

### Nested Placeholders
```json
{
  "Complex Join": {
    "prefix": "mjoin",
    "body": [
      "SELECT",
      "    ${1:t1}.${2:column1},",
      "    ${3:t2}.${4:column2}",
      "FROM ${5:table1} ${1:t1}",
      "INNER JOIN ${6:table2} ${3:t2}",
      "    ON ${1:t1}.${7:id} = ${3:t2}.${8:foreign_id}",
      "WHERE ${9:condition}$0"
    ]
  }
}
```

### Variables/Choices (VS Code snippet syntax)
```json
{
  "Select with Order": {
    "prefix": "sso",
    "body": [
      "SELECT ${1:*}",
      "FROM ${2:table_name}",
      "ORDER BY ${3:column} ${4|ASC,DESC|}$0"
    ]
  }
}
```

## 🔄 Reloading Snippets

After editing `sql.json`:
1. Save the file
2. Restart Neovim OR
3. Run `:Lazy reload blink.cmp`

## 📁 File Locations

- **Custom snippets**: `~\AppData\Local\nvim\snippets\sql.json`
- **This guide**: `~\AppData\Local\nvim\snippets\SQL_SNIPPETS_REFERENCE.md`
- **Config**: `~\AppData\Local\nvim\lua\myconfig\plugins\completion.lua`

## 🛠️ Troubleshooting

**Snippets not showing up?**
1. Check the file is named `sql.json` in the `snippets` folder
2. Verify JSON syntax is valid (use a JSON validator)
3. Make sure you're in a `.sql` file
4. Try `:messages` to see any errors
5. Reload with `:Lazy reload blink.cmp`

**Snippets showing but not expanding?**
- Press `<Tab>` or `<CR>` (Enter) to expand
- Check your completion keymaps in `completion.lua`

**Want different prefixes?**
- Edit the `"prefix"` value in `sql.json`
- Keep them short and memorable (2-4 characters)

## 💡 Pro Tips from Redgate Users

1. **Alias shortcuts**: Create snippets for common table aliases
2. **Audit fields**: Snippet for `CreatedDate`, `ModifiedDate` columns
3. **Permission checks**: Quick `IF EXISTS` for security checks
4. **Standard headers**: Comment blocks with your naming conventions
5. **Error handling**: Consistent TRY/CATCH patterns

---

Happy coding! 🎉
