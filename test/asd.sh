string="Marshmello & Anne-Marie"
set -f                      # avoid globbing (expansion of *).
array=(${string//&/ })
for i in "${!array[@]}"
do
    echo "${array[i]}"
done