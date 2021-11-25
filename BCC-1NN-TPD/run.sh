
for i in {1..100}
do
    cp -r sample $i/
    cd $i
    julia  seq_mh.jl > report.out
    cd ..
done
