#!/bin/zsh

array=(
  item1
  item2
  item3
  item4
)

for i in ${array[@]}; do
    echo $i
done

for i (array); do
    echo $i
done

echo "All the items: $array"
echo "All the items: ${array[*]}"

function loop_array() {
    for arg; do
        echo "function: $arg"
    done
}

loop_array ${array[@]}
