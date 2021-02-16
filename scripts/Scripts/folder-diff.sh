for i in */;
do
    for j in */;
    do
        diff -rs "$i" "$j" | egrep '^Files .+ and .+ are identical$';
    done
done
