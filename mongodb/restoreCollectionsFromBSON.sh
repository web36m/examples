cd ./dbdumppath/
for file in ./dbnamepath/*.bson; do str=${file%%.bson}; collection=${str#*/*/}; db=${str#*/}; db=${db%%/*}; mongorestore --collection "$collection" --db "$db" "$file"; done
