DIR_HPC=$(dirname $DIR)/hpc/coffee/rust2proto

mkdir -p gen
cd gen
rm -rf pb
cargo new --lib pb
cd ..

cargo build -p mod
