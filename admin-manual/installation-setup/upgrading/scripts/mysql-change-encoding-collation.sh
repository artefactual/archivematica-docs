#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # do not hide errors within pipes

# Array of database names
DATABASES=(
  MCP
  SS
)

# Collation and CHARSET
CHARSET="utf8mb4"
COLLATION="utf8mb4_0900_ai_ci"

# MySQL authentication (optional, default no auth)
MYSQL_USE_AUTH=False
MYSQL_USER=root
MYSQL_PASSWORD="THE_PASSWORD"

# Function to execute a query
execute_query() {
    local query="$1"
    local db_name="$2"
    local user_arg=""

    if [ "$MYSQL_USE_AUTH" = "True" ]; then
        user_arg="-u$MYSQL_USER"
        export MYSQL_PWD="$MYSQL_PASSWORD"
    fi

    mysql -N -B $user_arg -e "$query" "$db_name"
}

# Function to fix database charset and collation
fix_database_charset() {
    local query="ALTER DATABASE ${DB_NAME} CHARACTER SET $CHARSET COLLATE $COLLATION;"
    echo "Fixing database charset and collation"
    execute_query "$query" "$DB_NAME"
    echo "Fixed database charset and collation"
}

# Function to fix tables charset and collation
fix_tables_charset() {
    local query="SELECT CONCAT('ALTER TABLE \`',  table_name, '\` CHARACTER SET $CHARSET COLLATE $COLLATION;') \
    FROM information_schema.TABLES AS T, information_schema.\`COLLATION_CHARACTER_SET_APPLICABILITY\` AS C \
    WHERE C.collation_name = T.table_collation \
    AND T.table_schema = '$DB_NAME' \
    AND (C.CHARACTER_SET_NAME != '$CHARSET' OR C.COLLATION_NAME != '$COLLATION');"

    local alter_table_queries=$(execute_query "$query" "$DB_NAME")
    alter_table_queries_no_foreign_key_checks=$(echo -e "SET FOREIGN_KEY_CHECKS=0;\n$alter_table_queries\nSET FOREIGN_KEY_CHECKS=1;")
    # echo "$alter_table_queries_no_foreign_key_checks"
    echo "Fixing tables charset and collation"
    execute_query "$alter_table_queries_no_foreign_key_checks" "$DB_NAME"
    echo "Fixed tables charset and collation"
}

# Function to fix column collation for varchar columns
fix_varchar_columns_collation() {
    local query="SELECT CONCAT('ALTER TABLE \`', table_name, '\` MODIFY \`', column_name, '\` ', DATA_TYPE, \
    '(', CHARACTER_MAXIMUM_LENGTH, ') CHARACTER SET $CHARSET COLLATE $COLLATION', \
    (CASE WHEN IS_NULLABLE = 'NO' THEN ' NOT NULL' ELSE '' END), ';') \
    FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '$DB_NAME' AND DATA_TYPE = 'varchar' AND \
    ( CHARACTER_SET_NAME != '$CHARSET' OR COLLATION_NAME != '$COLLATION');"

    local alter_table_queries=$(execute_query "$query" "$DB_NAME")
    alter_table_queries_no_foreign_key_checks=$(echo -e "SET FOREIGN_KEY_CHECKS=0;\n$alter_table_queries\nSET FOREIGN_KEY_CHECKS=1;")
    # echo "$alter_table_queries_no_foreign_key_checks"
    echo "Fixing column collation for varchar columns"
    execute_query "$alter_table_queries_no_foreign_key_checks" "$DB_NAME"
    echo "Fixed column collation for varchar columns"
}

# Function to fix column collation for non-varchar columns
fix_non_varchar_columns_collation() {
    local query="SELECT CONCAT('ALTER TABLE \`', table_name, '\` MODIFY \`', column_name, '\` ', DATA_TYPE, ' \
    CHARACTER SET $CHARSET COLLATE $COLLATION', (CASE WHEN IS_NULLABLE = 'NO' THEN ' NOT NULL' ELSE '' END), ';') \
    FROM information_schema.COLUMNS \
    WHERE TABLE_SCHEMA = '$DB_NAME' \
    AND DATA_TYPE != 'varchar' \
    AND (CHARACTER_SET_NAME != '$CHARSET' OR COLLATION_NAME != '$COLLATION');"

    local alter_table_queries=$(execute_query "$query" "$DB_NAME")
    alter_table_queries_no_foreign_key_checks=$(echo -e "SET FOREIGN_KEY_CHECKS=0;\n$alter_table_queries\nSET FOREIGN_KEY_CHECKS=1;")
    # echo "$alter_table_queries_no_foreign_key_checks"
    echo "Fixing column collation for non-varchar columns"
    execute_query "$alter_table_queries_no_foreign_key_checks" "$DB_NAME"
    echo "Fixed column collation for non-varchar columns"
}

# Loop through each database in the array
for DB_NAME in "${DATABASES[@]}"; do
    echo "Processing database: $DB_NAME"
    fix_database_charset
    fix_tables_charset
    fix_varchar_columns_collation
    fix_non_varchar_columns_collation
    echo "Migration completed for $DB_NAME"
done

# Unset the MYSQL_PWD environment variable after executing the queries
unset MYSQL_PWD
